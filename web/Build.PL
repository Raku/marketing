use strict;
use Module::Build;

my $build = Module::Build->new(
    module_name        => 'RakudoOrg',
    dist_abstract      => 'rakudo.org website',
    dist_name          => 'rakudo.org',
    dist_author        => 'Perl 6 Hackers',
    license            => 'perl',
    create_makefile_pl => 'passthrough',
    dist_version => '0.1',
    recursive_test_files => 1,
    requires => {
      'CSS::Minifier::XS'                => '0.09',
      'CSS::Sass'                        => '3.4.10',
      'File::Glob'                       => '0',
      'File::Temp'                       => '0.2304',
      'File::Spec::Functions'            => 0,
      'IO::Socket::SSL'                  => '2.056',
      'JavaScript::Minifier::XS'         => '0.11',
      'Mojo::Base'                       => '0',
      'Mojo::Collection'                 => '0',
      'Mojo::File'                       => '0',
      'Mojo::Util'                       => '0',
      'Mojo::SQLite'                     => '3.000',
      'Mojolicious'                      => '7.31',
      'Mojolicious::Lite'                => '0',
      'Mojolicious::Plugin::AssetPack'   => '1.42',
      'Sort::Versions'                   => '1.62',
      'POSIX'                            => '0',
      'strict'                           => '0',
      'Text::MultiMarkdown'              => '1.000035',
      'Test::Most'                       => '0.35',
      'Time::Moment'                     => '0.43',
      'warnings'                         => '0',
    }
);
$build->create_build_script;