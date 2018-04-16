#!/bin/bash
. /var/www/rakudo.perl6.org/perl5/perlbrew/etc/bashrc
set -e -x
echo 'Starting rakudo.org update'
date
cd ~/rakudo.org/

git fetch
before=$(git rev-parse HEAD)
git checkout origin/master
after=$(git rev-parse HEAD)
cp update-rakudo.org.sh ../

if [ "$before" != "$after" ]
then
    echo "Got new commits"
    if [[ `git log "$before"..."$after" --oneline` =~ '[REAPP]' ]]; then
        echo "Restarting app"
        set +e
        hypnotoad app.pl
        set -e
    fi
fi

echo 'Done'