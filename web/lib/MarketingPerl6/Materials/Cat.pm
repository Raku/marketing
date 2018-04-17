package MarketingPerl6::Materials::Cat;

use Mojo::Base -base;

has [qw/name materials/];

sub title {
    my ($self) = @_;
    $self->name =~ tr/_/ /r;
}

sub id {
    my ($self) = @_;
    'cat-' . ($self->name =~ s/\W/_/gr);
}

1;
