use lib '../lib';
use Test::More tests => 6;
use Test::Deep;
use Data::Dumper;
use 5.010;
use DateTime;

use TestHelper;
my $tester = TestHelper->new->generate_test_empire;
my $session_id = $tester->session->id;
my $empire = $tester->empire;
my $home = $empire->home_planet;


my $result;


my $uni = Lacuna::DB::Building::University->new(
    simpledb        => $tester->db,
    x               => 0,
    y               => -1,
    class           => 'Lacuna::DB::Building::University',
    date_created    => DateTime->now,
    body_id         => $home->id,
    body            => $home,
    empire_id       => $empire->id,
    empire          => $empire,
    level           => 2,
);
$home->build_building($uni);
$uni->finish_upgrade;

$home->ore_capacity(5000);
$home->energy_capacity(5000);
$home->food_capacity(5000);
$home->water_capacity(5000);
$home->bauxite_stored(5000);
$home->algae_stored(5000);
$home->energy_stored(5000);
$home->water_stored(5000);
$home->ore_hour(5000);
$home->energy_hour(5000);
$home->algae_production_hour(5000);
$home->water_hour(5000);
$home->needs_recalc(0);
$home->put;


$result = $tester->post('intelligence', 'build', [$session_id, $home->id, 0, 1]);
ok($result->{result}{building}{id}, "built an intelligence ministry");
my $intelligence = $empire->get_building('Lacuna::DB::Building::Intelligence',$result->{result}{building}{id});
$intelligence->finish_upgrade;

$result = $tester->post('intelligence', 'view', [$session_id, $intelligence->id]);
is($result->{result}{spies}{maximum}, 5, "get spy data");

$result = $tester->post('intelligence', 'train_spy', [$session_id, $intelligence->id, 3]);
is($result->{result}{trained}, 3, "train a spy");

$result = $tester->post('intelligence', 'view_spies', [$session_id, $intelligence->id]);
my ($spy_id) = keys %{$result->{result}{spies}};
is($result->{result}{spies}{$spy_id}{is_available}, 0, "spy training");
is($result->{result}{possible_assignments}[0], 'Idle', "possible assignments");

$result = $tester->post('intelligence', 'burn_spy', [$session_id, $intelligence->id, $spy_id]);
ok(exists$result->{result}, "burn a spy");


END {
    $tester->cleanup;
}
