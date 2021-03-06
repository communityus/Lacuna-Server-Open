package Lacuna::DB::Building::Food::Farm::Corn;

use Moose;
extends 'Lacuna::DB::Building::Food::Farm';

use constant controller_class => 'Lacuna::Building::Corn';

use constant min_orbit => 2;

use constant max_orbit => 3;

use constant image => 'corn';

use constant name => 'Corn Plantation';

use constant food_to_build => 10;

use constant energy_to_build => 70;

use constant ore_to_build => 55;

use constant water_to_build => 83;

use constant waste_to_build => 10;

use constant time_to_build => 120;

use constant food_consumption => 1;

use constant corn_production => 28;

use constant energy_consumption => 1;

use constant ore_consumption => 2;

use constant water_consumption => 2;

use constant waste_production => 5;



no Moose;
__PACKAGE__->meta->make_immutable;
