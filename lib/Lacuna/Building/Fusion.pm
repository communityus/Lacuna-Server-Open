package Lacuna::Building::Fusion;

use Moose;
extends 'Lacuna::Building';

sub app_url {
    return '/fusion';
}

sub model_class {
    return 'Lacuna::DB::Building::Energy::Fusion';
}

no Moose;
__PACKAGE__->meta->make_immutable;

