package Lacuna::DB::Building::Waste::Treatment;

use Moose;
extends 'Lacuna::DB::Building::Waste';

around 'build_tags' => sub {
    my ($orig, $class) = @_;
    return ($orig->($class), qw(Energy Ore Water));
};

use constant controller_class => 'Lacuna::Building::WasteTreatment';

use constant image => 'wastetreatment';

use constant university_prereq => 5;

use constant name => 'Waste Treatment Center';

use constant food_to_build => 75;

use constant energy_to_build => 95;

use constant ore_to_build => 83;

use constant water_to_build => 95;

use constant waste_to_build => 20;

use constant time_to_build => 300;

use constant food_consumption => 1;

use constant energy_consumption => 2;

use constant energy_production => 14;

use constant ore_consumption => 2;

use constant ore_production => 14;

use constant water_consumption => 2;

use constant water_production => 14;

use constant waste_consumption => 40;

use constant waste_production => 2;



no Moose;
__PACKAGE__->meta->make_immutable;
