use lib '../lib';
use Test::More tests => 5;
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
$home->put;

$result = $tester->post('network19', 'build', [$session_id, $home->id, 0, 1]);
ok($result->{result}{building}{id}, "built a network19");
my $network19 = $empire->get_building('Lacuna::DB::Building::Network19',$result->{result}{building}{id});
$network19->finish_upgrade;

$result = $tester->post('network19', 'view', [$session_id, $network19->id]);
is($result->{result}{restrict_coverage}, '', "coverage unrestricted");

$result = $tester->post('network19', 'restrict_coverage', [$session_id, $network19->id, 1]);
ok(exists $result->{result}, "restrict coverage");

$result = $tester->post('network19', 'view', [$session_id, $network19->id]);
is($result->{result}{restrict_coverage}, 1, "coverage restricted");

$result = $tester->post('network19', 'view_news', [$session_id, $network19->id]);
cmp_ok(scalar(@{$result->{result}{news}}), '>', 0, "view news");



END {
    $tester->cleanup;
}
