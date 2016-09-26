package PERLANCAR::ShellQuote::Any;

# DATE
# VERSION

# Be lean.
#use 5.010001;
#use strict 'subs', 'vars';
#use warnings;

sub import {
    my $caller = caller;

    *{"$caller\::shell_quote"} = \&shell_quote;
}

sub shell_quote {
    if ($^O eq 'MSWin32') {
        require Win32::ShellQuote;
        Win32::ShellQuote::quote_system_string(@_);
    } else {
        require String::ShellQuote;
        String::ShellQuote::shell_quote(@_);
    }
}

1;
# ABSTRACT: Escape strings for the shell on Unix or MSWin32

=head1 SYNOPSIS

 use ShellQuote::Any; # exports shell_quote()

 shell_quote('curl', 'http://example.com/?foo=123&bar=baz');
 # curl 'http://example.com/?foo=123&bar=baz'


=head1 DESCRIPTION

B<This distribution is currently For testing only.>


=head1 FUNCTIONS

=head2 shell_quote(@cmd) => str

Quote command C<@cmd> according to C<$os> (defaults to C<$^O>). On Windows, will
use L<Win32::ShellQuote>'s C<quote_system_string()>. Otherwise, will use
L<String::ShellQuote>'s C<shell_quote()>. Exported by default.

If you want to simulate how quoting is done under another OS, you could do
something like:

 {
     local $^O = "Win32"; # simulate Windows
     say shell_quote("foo bar");
 }


=head1 SEE ALSO

L<Win32::ShellQuote>

L<String::ShellQuote>

L<ShellQuote::Any>
