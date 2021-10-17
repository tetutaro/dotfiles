#!/usr/bin/perl
use strict;
use warnings;

my $fg_black = "\x1b[30m";
my $fg_white = "\x1b[37m";
my $bg = "\x1b[48;5;";
my $rv = "\x1b[7m";
my $rs = "\x1b[0m";

sub get_color_white {
   my ($color) = @_;
   my $number = sprintf '%3d', $color;
   return qq/${bg}${color}m${fg_white} ${number} ${rv} ${number} ${rs}/;
}
sub get_color_black {
   my ($color) = @_;
   my $number = sprintf '%3d', $color;
   return qq/${bg}${color}m${fg_black} ${number} ${rv} ${number} ${rs}/;
}
my $color = 0;
for(my $row = 0; $row < 32; ++$row) {
   for (my $col = 0; $col < 8; ++$col) {
      print get_color_white($color);
      $color++;
   }
   print "\n";
}
$color = 0;
for(my $row = 0; $row < 32; ++$row) {
   for (my $col = 0; $col < 8; ++$col) {
      print get_color_black($color);
      $color++;
   }
   print "\n";
}
