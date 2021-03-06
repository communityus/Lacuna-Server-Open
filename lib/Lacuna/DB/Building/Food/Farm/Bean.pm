package Lacuna::DB::Building::Food::Farm::Bean;

use Moose;
extends 'Lacuna::DB::Building::Food::Farm';

use constant controller_class => 'Lacuna::Building::Bean';

use constant min_orbit => 4;

use constant max_orbit => 4;

use constant image => 'beans';

use constant name => 'Amalgus Bean Plantation';

use constant food_to_build => 10;

use constant energy_to_build => 61;

use constant ore_to_build => 55;

use constant water_to_build => 40;

use constant waste_to_build => 10;

use constant time_to_build => 120;

use constant food_consumption => 1;

use constant bean_production => 24;

use constant energy_consumption => 1;

use constant ore_consumption => 2;

use constant water_consumption => 1;

use constant waste_production => 2;



no Moose;
__PACKAGE__->meta->make_immutable;
