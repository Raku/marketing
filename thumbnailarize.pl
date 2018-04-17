#!/usr/bin/env perl

use 5.026;
use strict;
use warnings;
use Mojo::File qw/path/;

@ARGV or die "Usage: $0 path/to/file.pdf";
my $pdf = path shift;

my $pic_dir = path($pdf->dirname)->child('thumbs')->make_path;
system 'convert', qw/-colorspace RGB -background white -alpha remove/, $pdf,
    qw/-antialias -resize x400>/, $pic_dir->child($pdf->basename . '.jpg');

