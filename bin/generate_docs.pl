use strict;
use 5.010;
use Pod::Simple::HTML;
use File::Copy;

my $poddir = '/data/Lacuna-Server/docs/';
my $htmldir = '/data/www/public/api/';

opendir(my $dir, $poddir);
my @docs = readdir($dir);
closedir($dir);

copy($poddir."api.css", $htmldir."api.css");
copy($poddir."index.html", $htmldir."index.html");

foreach my $doc (@docs) {
    next if $doc !~ m/\.pod$/;
    say "Processing $doc";

    my $parser = Pod::Simple::HTML->new();
    $parser->{index} = 1;
    $parser->{html_css} = '/api/api.css';
    $parser->{perldoc_url_prefix} = '/api/';
    $parser->{perldoc_url_postfix} = '.html';
    $parser->{title_prefix} = 'The Lacuna Expanse API - ';
    $parser->{html_footer} = '&copy; 2010 Lacuna Expanse Corp';

    open my $in, '<', $poddir.$doc;
    my $name = $doc;
    $name =~ s/^(.*)\.pod/$1.html/;
    open my $out, '>', $htmldir.$name;
    
    $parser->output_fh(*$out);
    $parser->parse_file(*$in);

    close $in;
    close $out;
}


