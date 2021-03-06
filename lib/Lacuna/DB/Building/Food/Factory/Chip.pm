package Lacuna::DB::Building::Food::Factory::Chip;

use Moose;
extends 'Lacuna::DB::Building::Food::Factory';

use constant controller_class => 'Lacuna::Building::Chip';

use constant image => 'chips';

use constant building_prereq => {'Lacuna::DB::Building::Food::Farm::Root'=>5};

use constant name => 'Denton Root Chip Frier';

use constant food_to_build => 160;

use constant energy_to_build => 160;

use constant ore_to_build => 160;

use constant water_to_build => 160;

use constant waste_to_build => 100;

use constant time_to_build => 200;

use constant food_consumption => 30;

use constant chip_production => 30;

use constant energy_consumption => 5;

use constant ore_consumption => 14;

use constant water_consumption => 5;

use constant waste_production => 24;



no Moose;
__PACKAGE__->meta->make_immutable;
