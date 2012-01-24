# fNordeingangStatus Perl-Modul
# Rsoft 2012
# ----------
# Funktionen:
# $self->setURL("http://foo.bar/"); - Setzt die abzufragende URL auf http://foo.bar/
# $self->getStatus(); - Fragt den Server und gibt den Status zurueck.
# $self->getRaw(); - Gibt bei Status -1 die Rueckgabe des Servers und bei Status -2 eine (halbwegs) benutzerfreundliche Fehlermeldung zurueck.
# ----------
# $self->getStatus Return-Werte:
# 1: Der fNordeingang ist offen.
# 0: Der fNordeingang ist geschlossen.
# -1: Unerwartete Rueckgabe des Servers.
# -2: Sonstiges(LWP gibt undef zurück)
# Anmerkung: DNS-Server der Telekom geben bei einer nicht erreichbaren URL eine Fehlerseite in HTML zurueck, sodass in diesem Fall der Status -2 nicht erreicht wird, sondern nur -1.

package fNordeingangStatus;
use LWP::Simple;
use strict;

sub new {
  my $class = shift;
  my $self = {};

  $self->{'url'} = 'http://status.fnordeingang.de/'; # Die Standard-URL

  bless $self, $class;

  return $self;
}

sub setURL {
  my $self = shift;

  $self->{'url'} = shift;
}

sub getStatus {
  my $self = shift;
  my $content = get $self->{'url'};

  if(!$content) {
    $self->{'rawData'} = "Der Server unter '" . $self->{'url'} . "' antwortet nicht.";
    return -2;
  }
  if($content eq 'true') {
    $self->{'rawData'} = undef;
    $content = undef;
    return 1;
  } elsif ($content eq 'false') {
    $self->{'rawData'} = undef;
    $content = undef;
    return 0;
  } else {
    $self->{'rawData'} = $content;
    $content = undef;
    return -1;
  }
}

sub getRawData {
  my $self = shift;

  return $self->{'rawData'};
}

1;