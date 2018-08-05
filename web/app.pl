#!/usr/bin/env perl

use 5.026;
use lib qw<lib>;
use File::Spec::Functions qw/catfile/;
use Mojolicious::Lite;
use Mojo::File qw/path/;
use Mojo::Util qw/trim  xml_escape/;
use Time::Moment;
use MarketingPerl6::Materials;


plugin Config => { file => 'conf.conf' };

my $mat_root  = catfile app->home."", '..';
my $materials = MarketingPerl6::Materials->new(
    materials => app->config('materials'),
    root      => $mat_root,
);

plugin AssetPack => { pipes => [qw/Sass  JavaScript  Combine/] };
app->asset->process('app.css' => qw{
    https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css

    sass/open-iconic-bootstrap.css
    sass/main.scss
});
app->asset->process('app.js' => qw{
    https://code.jquery.com/jquery-3.3.1.min.js
    https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js
    https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js

    js/platform.js
    js/jquery-ui.js
    js/main.js
});

### Routes
get '/' => sub {
    my $self = shift;
    $self->stash(materials => $materials->all);
}, => 'home';

get '/m/*material' => sub {
    my $self = shift;
    my $m = $self->stash('material');
    $materials->has_material($m) or return $self->reply->not_found;
    $self->reply->asset(
        Mojo::Asset::File->new(path => path(catfile $mat_root, $m)));
} => 'm';

get '/id/*id/*type' => sub {
    my $self = shift;
    my $id = $self->stash('id');
    my $m = $materials->by_id($id) or return $self->reply->not_found;

    my $type = $self->stash('type');
    $m->has_type($type) or return $self->reply->not_found;
    $self->reply->asset(
        Mojo::Asset::File->new(
            path => path(catfile $mat_root, $m->base, $m->$type())));
} => 'by_id';

get 'irc' => sub {
    shift->redirect_to('https://webchat.freenode.net/?channels=#perl6');
} => 'irc';

any $_ => sub {
    my $c = shift;
    # my $posts = [ map +{ %$_ }, @{ $posts->all } ];
    # $_->{date} = blog_date_to_feed_date($_->{date}) for @$posts;

    # my $blog_last_updated_date = $posts->[0]{date};
    # $c->stash(
    #     posts       => $posts,
    #     last_update => $blog_last_updated_date,
    #     template    => 'feed',
    #     format      => 'xml',
    # );
}, ($_ eq '/feed' ? 'feed' : ())
    for '/feed', '/feed/', '/feed/index', '/atom', '/atom/', '/atom/index';

my %exts = qw/
    .gz source  .msi windows  .exe windows
    .dmg macos  .AppImage macos   .asc sig    .txt sig
/;
helper icon_for => sub {
    my ($self, $path) = @_;
    $exts{($path =~ /(.[^.]+)$/)[0]//''}//''
};
helper p6 => sub { '<span class="nb">Perl 6</span>' };
helper items_in => sub {
    my ($c, $what ) = @_;
    return unless defined $what;
    $what = $c->stash($what) // [] unless ref $what;
    return @$what;
};

app->start;

# sub blog_date_to_feed_date {
#     my $date = shift;
#     return Time::Moment->from_string("${date}T00:00:00Z")
#         ->strftime("%a, %d %b %Y %H:%M:%S %z");
# }

