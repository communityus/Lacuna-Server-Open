package Lacuna::DB::Building::Food::Factory::Shake;

use Moose;
extends 'Lacuna::DB::Building::Food::Factory';

use constant controller_class => 'Lacuna::Building::Shake';

use constant building_prereq => {'Lacuna::DB::Building::Food::Farm::Beeldeban'=>5};

use constant image => 'shake';

use constant name => 'Beeldeban Protein Shake Factory';

use constant food_to_build => 125;

use constant energy_to_build => 135;

use constant ore_to_build => 135;

use constant water_to_build => 125;

use constant waste_to_build => 100;

use constant time_to_build => 200;

use constant food_consumption => 30;

use constant shake_production => 30;

use constant energy_consumption => 5;

use constant ore_consumption => 1;

use constant water_consumption => 8;

use constant waste_production => 14;



no Moose;
__PACKAGE__->meta->make_immutable;
