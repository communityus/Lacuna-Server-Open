package Lacuna::DB::Building::Food::Factory::Bread;

use Moose;
extends 'Lacuna::DB::Building::Food::Factory';

use constant controller_class => 'Lacuna::Building::Bread';

use constant building_prereq => {'Lacuna::DB::Building::Food::Farm::Wheat'=>5};

use constant image => 'bread';

use constant name => 'Bread Bakery';

use constant food_to_build => 150;

use constant energy_to_build => 150;

use constant ore_to_build => 150;

use constant water_to_build => 150;

use constant waste_to_build => 100;

use constant time_to_build => 200;

use constant food_consumption => 30;

use constant bread_production => 30;

use constant energy_consumption => 10;

use constant water_consumption => 5;

use constant ore_consumption => 5;

use constant waste_production => 20;



no Moose;
__PACKAGE__->meta->make_immutable;
