##-*- Mode: CPerl -*-

## File: DDC::Format::Template.pm
## Author: Bryan Jurish <moocow@cpan.org>
## Description:
##  + DDC Query utilities: output formatting: Template-based
##======================================================================

package DDC::Format::Template;
use Template;
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
##     src         => $src,         ##-- template source (filename, fh, or string ref)
##     config      => \%ttconfig,   ##-- see Template(3pm)
##     vars        => \%vars,       ##-- extra vars
##     tmpl        => $template,    ##-- Template object (overrides \%ttconfig)
##    )
sub new {
  my $that = shift;
  my $fmt = bless {
		   src=>undef,
		   config=>{
			    INTERPOLATE => 1,
			    PRE_CHOMP   => 0,
			    POST_CHOMP  => 1,
			    EVAL_PERL   => 1,
			    ABSOLUTE    => 1,
			   },
		   vars => {},
		   tmpl => undef,
		   @_
		  }, ref($that)||$that;
  if (!$fmt->{tmpl}) {
    $fmt->{tmpl} = Template->new($fmt->{config})
      or confess(__PACKAGE__ . "::new(): could note create Template object: $Template::ERROR");
  }
  return $fmt;
}

## $fmt = $fmt->reset()
##  + reset counters, etc.
#sub reset {
#  return $_[0]->SUPER::reset();
#}

##======================================================================
## API

## $str = $fmt->toString(\@hits)
sub toString {
  my ($fmt,$hits) = @_;
  my $vars = { fmt=>$fmt, hits=>$hits, %{$fmt->{vars}||{}} };
  my $tmpl = $fmt->{tmpl};
  my $out  = '';

  ##-- Template Toolkit doesn't like leading underscores in hash keys if $Template::Stash::PRIVATE is defined
  #$Template::Stash::PRIVATE = undef;

  $tmpl->process($fmt->{src}, $vars, \$out)
    or confess(__PACKAGE__ . "::toString(): template error: ".$tmpl->error);

  return $out;
}

1; ##-- be happy

__END__

##======================================================================
## Docs
=pod

=head1 NAME

DDC::Format::Template - Template-based formatting for DDC hits

=head1 SYNOPSIS

 use DDC::Concordance;

 @hits = DDC::Client::Distributed->new()->query('foo&&bar'); ##-- get some hits

 $fmt = DDC::Format::Template->new(src=>$src,config=>\%cfg,vars=>\%vars);
 $str = $fmt->toString(\@hits);        ##-- conversion to string
 $fmt->toFile(\@hits,$filename);       ##-- output to file
 $fmt->toFh(\@hits,$fh);               ##-- output to filehandle

=cut

##======================================================================
## Description
=pod

=head1 DESCRIPTION

Class for formatting L<DDC::Hit|DDC::Hit> objects as perl code using the L<Template|Template> module.

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::Template: Globals
=pod

=head2 Globals

=over 4

=item Variable: @ISA

DDC::Format::Template inherits from L<DDC::Format|DDC::Format>.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::Template: Constructors, etc.
=pod

=head2 Constructors, etc.

=over 4

=item new

 $fmt = $CLASS_OR_OBJ->new(%args);

Accepted keywords in %args:

 (
  src         => $src,         ##-- template source (filename, fh, or string ref)
  config      => \%ttconfig,   ##-- see Template(3pm)
  vars        => \%vars,       ##-- extra vars
  tmpl        => $template,    ##-- Template object (overrides \%ttconfig)
 )

Default %ttconfig is:

 (
  INTERPOLATE => 1,
  PRE_CHOMP   => 0,
  POST_CHOMP  => 1,
  EVAL_PERL   => 1,
  ABSOLUTE    => 1,
 )

=item reset

 $fmt = $fmt->reset();

Resets the formatting object.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::Format::Template: API
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