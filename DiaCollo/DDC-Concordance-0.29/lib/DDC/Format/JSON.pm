##-*- Mode: CPerl -*-

## File: DDC::Format::JSON.pm
## Author: Bryan Jurish <moocow@cpan.org>
## Description:
##  + DDC Query utilities: output formatting: Data::Dumper
##======================================================================

package DDC::Format::JSON;
use JSON;
use Carp;
use strict;

##======================================================================
## Globals
our @ISA = qw(DDC::Format);

##======================================================================
## Constructors, etc.

## $fmt = $CLASS_OR_OBJ->new(%args)
##  + %args:
##    (
##     pretty => $level,    ##-- json prettification level (default:0)
##     jxs    => $jxs,      ##-- underlying JSON object
##    )
sub new {
  my $that = shift;
  my $fmt = bless {
		   level=>0,
		   jxs   =>JSON->new->utf8(1)->relaxed(1)->canonical(0)->allow_blessed(1)->convert_blessed(1),
		   @_
		  }, ref($that)||$that;
  return $fmt;
}

## $fmt = $fmt->reset()
##  + reset counters, etc.
sub reset {
  $_[0]{jxs}->pretty($_[0]{level}||0);
  $_[0]{jxs}->canonical(abs($_[0]{level}||0)>1 ? 1 : 0);
  return $_[0]->SUPER::reset();
}

##======================================================================
## Helper functions

## $hitStr = $fmt->hitString($hit)
##  + increments $fmt->{start}
sub hitString {
  my ($fmt,$hit) = @_;
  return $fmt->{jxs}->pretty($_[0]{level}||0)->canonical(abs($_[0]{level}||0)>1 ? 1 : 0)->encode($hit);
}

##======================================================================
## API

## $str = $fmt->toString($hitList)
sub toString {
  my ($fmt,$hits) = @_;
  return $fmt->{jxs}->pretty($_[0]{level}||0)->canonical(abs($_[0]{level}||0)>1 ? 1 : 0)->encode($hits);
}

1; ##-- be happy

__END__

##======================================================================
## Docs
=pod

=head1 NAME

DDC::Format::JSON - JSON formatting for DDC hits

=head1 SYNOPSIS

 use DDC::Concordance;

 @hits = DDC::Client::Distributed->new()->query('foo&&bar'); ##-- get some hits

 $fmt  = DDC::Format::JSON->new(indent=>1);
 $str = $fmt->toString(\@hits);        ##-- conversion to string
 $fmt->toFile(\@hits,$filename);       ##-- output to file
 $fmt->toFh(\@hits,$fh);               ##-- output to filehandle

=cut

##======================================================================
## Description
=pod

=head1 DESCRIPTION

Class for formatting L<DDC::Hit|DDC::Hit> objects as perl code using L<JSON|JSON>.

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::JSON: Globals
=pod

=head2 Globals

=over 4

=item Variable: @ISA

DDC::Format::JSON inherits from L<DDC::Format|DDC::Format>.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::JSON: Constructors, etc.
=pod

=head2 Constructors, etc.

=over 4

=item new

 $fmt = $CLASS_OR_OBJ->new(%args);

Accepted keywords in %args:

 (
  jxs    => $dumper, ##-- underlying JSON object
  level  => $bool,   ##-- pretty-print?
 )

=item reset

 $fmt = $fmt->reset();

Resets the formatting object.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::JSON: Helper functions
=pod

=head2 Helper functions

=over 4

=item hitString

 $hitStr = $fmt->hitString($hit);

Formats a single C<$hit> as a string.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::JSON: API
=pod

=head2 API

=over 4

=item toString

 $str = $fmt->toString(\@hits);

Implements L<DDC::Format::toString()|DDC::Format/toString>.

=back

=cut

##========================================================================
## END POD DOCUMENTATION, auto-generated by podextract.perl


##======================================================================
## Footer
##======================================================================

=pod

=head1 AUTHOR

Bryan Jurish E<lt>moocow@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011-2016 by Bryan Jurish

This package is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
