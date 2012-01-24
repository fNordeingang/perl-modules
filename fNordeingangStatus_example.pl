# fNordeingangStatus_example.pl
# Rsoft 2012
# Beispiel fuer das fNordeingangStatus-Modul

use fNordIO::fNordeingangStatus; # Wir benutzen das fNordeingangStatus-Modul.

my $fNordstat = new fNordeingangStatus(); # Eine Instanz erstellen. Die Standard-URL ist http://status.fnordeingang.de/.

if(@ARGV[0]) { # Wenn ein Argument uebergeben wurde,
  $fNordstat->setURL(@ARGV[0]); # die URL der Instanz auf den Wert des 1. Argumentes setzen.
}

print "fNordeingang Status Tester using fNordeingangStatus Perl Module.\n";
my $currentStatus = $fNordstat->getStatus(); # Den Status abfragen.

if($currentStatus == 1) {
  print "Der fNordeingang ist offen.\n";
} elsif($currentStatus == 0) {
  print "Der fNordeingang ist geschlossen.\n";
} elsif($currentStatus == -1) {
  print "Unerwartete Rueckgabe des Servers: \"" . $fNordstat->getRawData() . "\"\n"; # Die Rohdaten ausgeben.
} else {
  print $fNordstat->getRawData() . "\n"; # Die Fehlermeldung an den Benutzer weitergeben.
}