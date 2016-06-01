#! /usr/bin/env perl

=begin
Perform a benchmark on matching regexp over strings
=cut

use strict;
use warnings;

use File::Spec;
use JSON;
use JSON::Parse;
use Time::HiRes;

use constant CONFIG_PATH => 'config';
use constant CONFIG_FILE_NAME => File::Spec->catfile(CONFIG_PATH, 'config.json');
use constant REGEXPS_FILE_NAME => File::Spec->catfile(CONFIG_PATH, 'regexps.json');

my $config_data = do {
    open my $json_fh, "<:encoding(UTF-8)", CONFIG_FILE_NAME or
        die 'Cannot find file ' + CONFIG_FILE_NAME;
    local $/;
    <$json_fh>
};
our $config = JSON::Parse::parse_json($config_data);

my $regexps_data = do {
    open my $json_fh, "<:encoding(UTF-8)", REGEXPS_FILE_NAME or
        die 'Cannot find file ' + REGEXPS_FILE_NAME;
    local $/;
    <$json_fh>
};
our $regexps = JSON::Parse::parse_json($regexps_data);


sub PerformTest {
    my @lines = @{$_[0]};
    my $regexp = $_[1];
    my $matching = 0;
    my $not_matching = 0;

    foreach (@lines) {
        if ($_ =~ /$regexp/) {
            $matching++;
        } else {
            $not_matching++;
        }
    }
    $matching == $main::config->{'num_matching_lines'} or
        die "Unexpected matching lines.";
    $not_matching == $main::config->{"num_not_matching_lines"} or
        die "Expecting unmatching lines.";
}

sub main {
    my %result;

    while(my ($key, $regexp) = each %{$regexps}) {
        open my $fh, '<', File::Spec->catfile($main::config->{"scratch_directory"}, $key);
        chomp(my @lines = <$fh>);
        close $fh;

        my $start = Time::HiRes::gettimeofday;
        for(my $i = 0; $i < %{$main::config}{"repeat_times"}; ++$i) {
            PerformTest(\@lines, $regexp);
        }
        my $end = Time::HiRes::gettimeofday;
        $result{$key} = $end - $start;
    }

    print encode_json(\%result);
}

main();
