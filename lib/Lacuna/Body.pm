package Lacuna::Body;

use Moose;
extends 'JSON::RPC::Dispatcher::App';
use Lacuna::Util qw(in);
use Lacuna::Verify;
use Lacuna::Constants qw(BUILDABLE_CLASSES);
use DateTime;

has simpledb => (
    is      => 'ro',
    required=> 1,
);

with 'Lacuna::Role::Sessionable';

sub get_body {
    my ($self, $session_id, $body_id) = @_;
    my $body = $self->simpledb->domain('body')->find($body_id);
    unless (defined $body) {
        confess [1002, 'Body does not exist.', $body_id];
    }
    my $empire = $self->get_empire_by_session($session_id);
    return {
        status  => $empire->get_status,
        body    => $body->get_status($empire),
    }
}

sub rename {
    my ($self, $session_id, $body_id, $name) = @_;
    Lacuna::Verify->new(content=>\$name, throws=>[1000,'Name not available.',$name])
        ->length_gt(2)
        ->length_lt(31)
        ->no_restricted_chars
        ->no_profanity
        ->not_ok($self->simpledb->domain('body')->count(where => {name_cname=>Lacuna::Util::cname($name), 'itemName()'=>['!=',$body_id]}, consistent=>1)); # name available
    
    my $empire = $self->get_empire_by_session($session_id);
    my $body = $empire->get_body($body_id);
    $body->add_news(200,"In a bold move to show its growing power, %s renamed %s to %s.",$empire->name, $body->name, $name);
    $body->update({name => $name})->put;
    return 1;
}

sub get_buildings {
    my ($self, $session_id, $body_id) = @_;
    my $empire = $self->get_empire_by_session($session_id);
    my $body = $empire->get_body($body_id);
    $body->tick;
    my %out;
    foreach my $buildings ($body->buildings) {
        while (my $building = $buildings->next) {
            $out{$building->id} = {
                url     => $building->controller_class->app_url,
                image   => $building->image_level,
                name    => $building->name,
                x       => $building->x,
                y       => $building->y,
                level   => $building->level,
            };
        }
    }
    
    return {buildings=>\%out, status=>$empire->get_status};
}

sub get_build_queue {
    my ($self, $session_id, $body_id) = @_;
    my $empire = $self->get_empire_by_session($session_id);
    my $body = $empire->get_body($body_id);
    my $builds = $body->builds;
    my %queue;
    $body->tick;
    while (my $build = $builds->next) {
        my $status = $build->get_status;
        if ($status) {
            $queue{$build->building_id} = $status;
        }
    }
    return { build_queue => \%queue, status => $empire->get_status };
}

sub get_buildable {
    my ($self, $session_id, $body_id, $x, $y) = @_;
    my $empire = $self->get_empire_by_session($session_id);
    my $body = $empire->get_body($body_id);

    $body->check_for_available_build_space($x, $y);

    # dummy building properties
    my %properties = (
            x               => $x,
            y               => $y,
            level           => 0,
            body_id         => $body->id,
            body            => $body,
            empire_id       => $empire->id,
            empire          => $empire,
            date_created    => DateTime->now,
    );

    my %out;
    $body->tick;
    foreach my $class (BUILDABLE_CLASSES) {
        $properties{class} = $class->model_class;
        my $building = $class->model_class->new(simpledb=>$self->simpledb)->update(\%properties);
        my $cost = $building->cost_to_upgrade;
        my $can_build = eval{$body->has_met_building_prereqs($building, $cost)};
        my $reason = $@;
        my @extra_tags;
        if ($can_build) {
            push @extra_tags, 'Now';          
        }
        elsif ($reason->[0] == 1011) {
            push @extra_tags, 'Soon';
        }
        else {
            push @extra_tags, 'Later';
        }
        $out{$building->name} = {
            url         => $class->app_url,
            image       => $building->image_level,
            build       => {
                can         => ($can_build) ? 1 : 0,                
                cost        => $cost,
                reason      => $reason,
                tags        => [$building->build_tags, @extra_tags],
            },
            production  => $building->stats_after_upgrade,
        };
    }

    return {buildable=>\%out, status=>$empire->get_status};
}


__PACKAGE__->register_rpc_method_names(qw(rename get_build_queue get_buildings get_buildable));

no Moose;
__PACKAGE__->meta->make_immutable;

