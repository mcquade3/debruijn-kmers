#!/usr/local/bin/perl
# Mike McQuade
# DeBruijn-kmers.pl
# Constructs a DeBruijn Graph for a list of k-mers.

# Define the packages to use
use strict;
use warnings;

# Initialize variables
my (@kmers,%deBruijn);

# Open the file to read
open(my $fh,"<ba3e.txt") or die $!;

# Read in the values from the file
while (my $line = <$fh>) {
	chomp($line);
	push @kmers,$line;
}

# Map each k-mer's prefix to it's matching suffix
foreach my $kmer (@kmers) {
	if (!$deBruijn{substr($kmer,0,-1)}) {
		$deBruijn{substr($kmer,0,-1)} = [substr($kmer,1)];
	} else {
		push ($deBruijn{substr($kmer,0,-1)}, substr($kmer,1));
	}
}

# Print out the graph
foreach my $key (sort keys %deBruijn) {
	print "$key -> ";
	print join(",", sort @{$deBruijn{$key}});
	print "\n";
}

# Close the file
close($fh) || die "Couldn't close file properly";