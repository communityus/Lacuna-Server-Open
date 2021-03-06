package Lacuna::DB::Session;

use Moose;
extends 'SimpleDB::Class::Item';
use DateTime;

__PACKAGE__->set_domain_name('session');
__PACKAGE__->add_attributes(
    empire_id       => { isa => 'Str' },
    date_created    => { isa => 'DateTime' },
    expires         => { isa => 'DateTime' },
);

__PACKAGE__->belongs_to('empire', 'Lacuna::DB::Empire', 'empire_id');

sub extend {
    my $self = shift;
    $self->expires(DateTime->now->add(hours=>2));
    $self->put;
}

sub has_expired {
    my $self = shift;
    return (DateTime->now > $self->expires);
}

no Moose;
__PACKAGE__->meta->make_immutable;
