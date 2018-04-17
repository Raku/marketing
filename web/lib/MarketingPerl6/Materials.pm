package MarketingPerl6::Materials;

use Mojo::Base -base;
use Mojo::Collection qw/c/;
use MarketingPerl6::Materials::Piece;
use MarketingPerl6::Materials::Cat;

has [qw/materials  root/];

sub all {
    my ($self) = @_;
    my %mat = $self->materials->%*;
    my @cats;
    for (sort keys %mat) {
        push @cats, MarketingPerl6::Materials::Cat->new(
            name => $_,
            materials => c map MarketingPerl6::Materials::Piece->new(
                %$_, root => $self->root,
            ), $mat{$_}->@*
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
