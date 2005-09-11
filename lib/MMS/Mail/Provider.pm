package MMS::Mail::Provider;

use warnings;
use strict;

use MMS::Mail::Message::Parsed;

=head1 NAME

MMS::Mail::Provider - This provides a default class for parsing an MMS::Mail::Message object into a MMS::Mail::Message::Parsed object.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

This class provides a parse method for parsing an MMS::Mail::Message object into an MMS::Mail::Message::Parsed object for 'generic' MMS messages (or ones that cannot be identified as coming from a specific provider).

=head1 METHODS

The following are the top-level methods of the MMS::Mail::Provider class.

=head2 Constructor

=over

=item new()

Return a new MMS::Mail::Provider object.

=back

=head2 Regular Methods

=over

=item parse MMS::Mail::Message

The parse method can be called as a class method or an instance method, normally it will be invoked as a class method.  It parses the MMS::Mail::Message and returns an MMS::Mail::Message::Parsed.

=back

=head1 AUTHOR

Rob Lee, C<< <robl@robl.co.uk> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-mms-mail-provider@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MMS-Mail-Provider>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 NOTES

To quote the perl artistic license ('perldoc perlartistic') :

10. THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
    WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES
    OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=head1 ACKNOWLEDGEMENTS

As per usual this module is sprinkled with a little Deb magic.

=head1 COPYRIGHT & LICENSE

Copyright 2005 Rob Lee, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

sub new {
  my $type = shift;
  my $self = {};
  bless $self, $type;

  return $self;
}

sub parse {

  my $self;
  if (_is_object(@_)) {
    $self = shift;
  }

  my $message = shift;

  my $parsed =  new MMS::Mail::Message::Parsed($message);

  $parsed->images($parsed->retrieve_attachments('^image'));
  $parsed->videos($parsed->retrieve_attachments('^video'));

  return $parsed;

}

sub _is_object {

  my @args = @_;

  my ($package, $filename, $line) = caller;

  if (scalar @args>0) {
    return 1 if (UNIVERSAL::isa($args[0], $package));
  } 
  return 0;
 
}


1; # End of MMS::Mail::Provider
