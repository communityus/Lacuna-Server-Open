package Lacuna::Building::CornMeal;

use Moose;
extends 'Lacuna::Building';

sub app_url {
    return '/cornmeal';
}

sub model_class {
    return 'Lacuna::DB::Building::Food::Factory::CornMeal';
}

no Moose;
__PACKAGE__->meta->make_immutable;

