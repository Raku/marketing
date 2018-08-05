package MarketingPerl6::Materials;

use Mojo::Base -base;
use Mojo::Collection qw/c/;
use MarketingPerl6::Materials::Piece;
use MarketingPerl6::Materials::Cat;
use List::MoreUtils qw/natatime/;

has [qw/materials  root/];

sub all {
    my ($self) = @_;
    my $it = natatime 2, $self->materials->@*;
    my @cats;
    while (my @mat = $it->()) {
        push @cats, MarketingPerl6::Materials::Cat->new(
            name => $mat[0],
            materials => c map MarketingPerl6::Materials::Piece->new(
                %$_, root => $self->root,
            ), $mat[1]->@*
        );
    }
    c @cats;
}

sub has_material {
    my ($self, $material) = @_;
    for my $cat ($self->all->@*) {
        for my $m ($cat->materials->@*) {
            for my $thumb ($m->thumbs->@*) {
                return 1 if $material eq $thumb;
            }
        }
    }
    0;
}

1;
