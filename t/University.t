use lib '../lib';
use Test::More tests => 20;
use Test::Deep;
use Data::Dumper;
use 5.010;

use TestHelper;
my $tester = TestHelper->new->generate_test_empire;
my $db = $tester->db;
my $session_id = $tester->session->id;
my $empire_id = $tester->empire->id;

my $result;

$result = $tester->post('university', 'build', [$session_id, $tester->empire->home_planet_id, 3, 3]);
my $uid = $result->{result}{building}{id};

$db->domain('Lacuna::DB::Building::University')->find($uid)->finish_upgrade;

$result = $tester->post('university', 'view', [$session_id, $uid]);
is($result->{result}{building}{level}, 1, "made it to level 1");
my $empire = $db->domain('empire')->find($empire_id);
is($empire->university_level, 1, 'empire university level was upgraded');

for my $level (2..10) {

    my $home = $empire->home_planet;
    $home->ore_capacity(50000000);
    $home->energy_capacity(50000000);
    $home->food_capacity(50000000);
    $home->water_capacity(50000000);
    $home->bauxite_stored(50000000);
    $home->algae_stored(50000000);
    $home->energy_stored(50000000);
    $home->water_stored(50000000);
    $home->energy_hour(50000000);
    $home->algae_production_hour(50000000);
    $home->water_hour(50000000);
    $home->ore_hour(50000000);
    $home->put;

    $result = $tester->post('university', 'upgrade', [$session_id, $uid]);    
    $db->domain('Lacuna::DB::Building::University')->find($uid)->finish_upgrade;
    
    $result = $tester->post('university', 'view', [$session_id, $uid]);
    is($result->{result}{building}{level}, $level, "made it to level ".$level);
    $empire = $db->domain('empire')->find($empire_id);
    is($empire->university_level, $level, 'empire university level was upgraded');    
    
}


END {
    $tester->cleanup;
}
