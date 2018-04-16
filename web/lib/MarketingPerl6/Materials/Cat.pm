package MarketingPerl6::Materials::Cat;

use Mojo::Base -base;

has [qw/name materials/];

sub id {
    my ($self) = @_;
    'cat-' . ($self->name =~ s/\W/_/gr);
}

1;
