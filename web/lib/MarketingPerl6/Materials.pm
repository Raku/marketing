package MarketingPerl6::Materials;

use Mojo::Base -base;
use Mojo::Collection qw/c/;
use MarketingPerl6::Materials::Piece;
use MarketingPerl6::Materials::Cat;

has 'materials';

sub all {
    my ($self) = @_;
    my %mat = $self->materials->%*;
    my @cats;
    for (sort keys %mat) {
        push @cats, MarketingPerl6::Materials::Cat->new(
            name => $_,
            materials => c map MarketingPerl6::Materials::Piece->new(%$_),
                $mat{$_}->@*
        );
    }
    c @cats;
}

1;
