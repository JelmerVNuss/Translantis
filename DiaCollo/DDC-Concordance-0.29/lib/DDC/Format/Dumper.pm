##-*- Mode: CPerl -*-

## File: DDC::Format::Dumper.pm
## Author: Bryan Jurish <moocow@cpan.org>
## Description:
##  + DDC Query utilities: output formatting: Data::Dumper
##======================================================================

package DDC::Format::Dumper;
use Data::Dumper;
use IO::File;
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
##     indent=>$level,             ##-- Data::Dumper level (default=1)
##    )
sub new {
  my $that = shift;
  my $fmt = bless {
		   indent=>1,
		   dumper=>undef,
		   @_
		  }, ref($that)||$that;
  if (!defined($fmt->{dumper})) {
    $fmt->{dumper} = Data::Dumper->new([])->Purity(1)->Terse(0)->Deepcopy(1);
  }
  return $fmt;
}

## $fmt = $fmt->reset()
##  + reset counters, etc.
sub reset {
  $_[0]{dumper}->Reset->Indent($_[0]{indent});
  return $_[0]->SUPER::reset();
}

##======================================================================
## Helper functions

## $hitStr = $fmt->hitString($hit)
##  + increments $fmt->{start}
sub hitString {
  my ($fmt,$hit) = @_;
  return $fmt->{dumper}->Reset->Indent($fmt->{indent})->Names(['hit'])->Values([$hit])->Dump;
}

##======================================================================
## API

## $str = $fmt->toString(\@hits)
sub toString {
  my ($fmt,$hits) = @_;
  return $fmt->{dumper}->Reset->Indent($fmt->{indent})->Names(['hits'])->Values([$hits])->Dump;
}

1; ##-- be happy

__END__

##======================================================================
## Docs
=pod

=head1 NAME

DDC::Format::Dumper - Data::Dumper formatting for DDC hits

=head1 SYNOPSIS

 use DDC::Concordance;

 $hitList = DDC::Client::Distributed->new()->query('foo&&bar'); ##-- get some hits

 $fmt  = DDC::Format::Dumper->new(indent=>1);
 $str = $fmt->toString($hitList);        ##-- conversion to string
 $fmt->toFile($hitList,$filename);       ##-- output to file
 $fmt->toFh($hitList,$fh);               ##-- output to filehandle

=cut

##======================================================================
## Description
=pod

=head1 DESCRIPTION

Class for formatting L<DDC::Hit|DDC::Hit> objects as perl code using L<Data::Dumper|Data::Dumper>.

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::Dumper: Globals
=pod

=head2 Globals

=over 4

=item Variable: @ISA

DDC::Format::Dumper inherits from L<DDC::Format|DDC::Format>.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::Dumper: Constructors, etc.
=pod

=head2 Constructors, etc.

=over 4

=item new

 $fmt = $CLASS_OR_OBJ->new(%args);

Accepted keywords in %args:

 (
  dumper => $dumper, ##-- underlying Data::Dumper object
  indent => $level,  ##-- indentation level (default=1)
 )

=item reset

 $fmt = $fmt->reset();

Resets the formatting object.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::Dumper: Helper functions
=pod

=head2 Helper functions

=over 4

=item hitString

 $hitStr = $fmt->hitString($hit);

Formats a single C<$hit> as a string.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::Dumper: API
=pod

=head2 API

=over 4

=item toString

 $str = $fmt->toString($hitList);

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

Copyright (C) 2010-2016 by Bryan Jurish

This package is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
