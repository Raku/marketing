package MarketingPerl6::Materials::Piece;

use Mojo::Base -base;
use Mojo::Collection qw/c/;
use File::Spec::Functions qw/catfile/;
use File::Glob qw/bsd_glob/;
use Image::Size;

has [qw/title  desc  root  base  print_bleed  print  pdf  digital/];

sub id {
    my ($self) = @_;
    'piece-' . ($self->title =~ s/\W/_/gr);
}

sub thumbs {
    my ($self) = @_;
    my $root = $self->root;
    c(bsd_glob catfile $root, $self->base, 'thumbs', '*.jpg')->map(
        sub {
            $_ =~ s{\Q$root\E/}{}r
        }
    );
}

1;
