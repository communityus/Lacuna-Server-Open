package Lacuna::DB::Building::University;

use Moose;
extends 'Lacuna::DB::Building';

around 'build_tags' => sub {
    my ($orig, $class) = @_;
    return ($orig->($class), qw(Infrastructure Happiness));
};

use constant controller_class => 'Lacuna::Building::University';

use constant max_instances_per_planet => 1;

use constant image => 'university';

use constant name => 'University';

use constant food_to_build => 190;

use constant energy_to_build => 190;

use constant ore_to_build => 190;

use constant water_to_build => 190;

use constant waste_to_build => 100;

use constant time_to_build => 600;

use constant food_consumption => 20;

use constant energy_consumption => 20;

use constant ore_consumption => 4;

use constant water_consumption => 22;

use constant waste_production => 26;

use constant happiness_production => 40;

after finish_upgrade => sub {
    my $self = shift;
    my $empire = $self->body->empire; # we are possibly stale
    if ($empire->university_level < $self->level) {
        $empire->university_level($self->level);
        $empire->put;
    }
};

no Moose;
__PACKAGE__->meta->make_immutable;
