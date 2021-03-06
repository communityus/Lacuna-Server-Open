package Lacuna::DB::Building::Energy::Reserve;

use Moose;
extends 'Lacuna::DB::Building::Energy';

use constant controller_class => 'Lacuna::Building::EnergyReserve';

use constant university_prereq => 1;

use constant image => 'energy-reserve';

use constant name => 'Energy Reserve';

use constant food_to_build => 100;

use constant energy_to_build => 100;

use constant ore_to_build => 100;

use constant water_to_build => 100;

use constant waste_to_build => 200;

use constant time_to_build => 120;

use constant food_consumption => 1;

use constant energy_consumption => 6;

use constant ore_consumption => 1;

use constant water_consumption => 1;

use constant waste_production => 1;

use constant energy_storage => 1000;



no Moose;
__PACKAGE__->meta->make_immutable;
