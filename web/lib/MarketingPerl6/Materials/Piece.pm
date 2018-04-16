package MarketingPerl6::Materials::Piece;

use Mojo::Base -base;

has [qw/title  desc  base  print_bleed  print  pdf  digital/];

sub id {
    my ($self) = @_;
    'piece-' . ($self->title =~ s/\W/_/gr);
}

1;
