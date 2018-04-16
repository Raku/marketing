# Rakudo.org

This is the source code for <https://rakudo.org>.

## Installation

To install into `rakudo.org` dir in current directory run:

    git clone https://github.com/perl6/rakudo.org &&
    cd rakudo.org &&
    cpanm -vn --installdeps .

*Optionally*, copy the Rakudo Star, Rakudo, and NQP binaries into `binaries/`
directory. You can use a different directory, but ensure to change it
accordingly in `conf.conf` file, under `binaries_dir` key.

    mkdir binaries
    cp -R ~/some-location-with-binaries/* binaries/

To star development server, run:

    ./morbo

To start production server, run:

    ./hyp

If you need to stop it entirely later, run `hypnotoad app.pl --stop`

The servers listen on localhost, port `4242`: http://localhost:4242

## Updating Live Site

A cronjob runs [`update-rakudo.org.sh`](update-rakudo.org.sh) script every
5 minutes.

The script pulls changes from the repo. For blog posts, the updates will show
up automatically. For other changes, you need to ask for app restart by
putting string `[REAPP]` (including square brackets) into the commit title.

### Infrustructure Setup

See [infrastructure docs](https://github.com/perl6/infrastructure-doc/blob/master/hosts/www.p6c.org.pod#rakudoorg) for details on how the site
is setup on the current server.

### Adding More URL Rewrites

The site has a ton of URL rewrites in
`/etc/apache2/sites-available/rakudo.org.conf` (copy is saved in
the repo in [`apache.conf`](apache.conf)). Note that that file does NOT get
automatically updated from the repo and needs to be edited manually.

If you need to add a rewrite, note that `Proxy` stuff takes precedence
over `Redirect` directives. You need to ensure the `Proxy` stuff doesn't
proxy the stuff you want to redirect (there's already a `ProxyPassMatch`
regex in the file; just add more stuff to it)

### Debug Aid

Some areas of the site are platform-specific (e.g. showing a download
link to a `.deb` file if the visitor is using Ubuntu). You can force a view
for a specific platform by using `platform` query parameter. See
`process_platform_specific_content()` in `assets/main.js` for valid values.

### LICENSE

See [LICENSE](LICENSE) file for the details of the license of the code in this repository.

This repository also contains code authored by third parties that may be licensed under a different license. Such
files indicate the copyright and license terms at the top of the file. Currently these include:

* jQuery and jQuery UI libraries: Copyright 2015 jQuery Foundation and other contributors; [MIT License](http://creativecommons.org/licenses/MIT)
* The Camelia image is copyright 2009 by Larry Wall. Permission to use is granted under the [Artistic License 2.0](License), or any subsequent version
of the Artistic License.
* [Cover template](http://getbootstrap.com/docs/4.0/examples/cover/)
    for Bootstrap, by [`@mdo`](https://twitter.com/mdo)
* [OpenIconic](https://useiconic.com/open/) icons are licensed under
    [MIT License](http://creativecommons.org/licenses/MIT) and its fonts
    are licensed under SIL OPEN FONT LICENSE Version 1.1.
* [platform.js](https://github.com/bestiejs/platform.js) is licensed under
    [MIT License](http://creativecommons.org/licenses/MIT)
* Twitter footer icon by `blk` from
    [ShareIcon](https://www.shareicon.net/twitter-93943),
    [MIT License](http://creativecommons.org/licenses/MIT)
* IRC people icon
    from [ShareIcon](https://www.shareicon.net/people-queue-crowd-line-stick-man-722560)
* Signed file icon is by `Sergei Kokota` from
    [ShareIcon](https://www.shareicon.net/document-business-file-signature-agreement-contract-paper-105338)