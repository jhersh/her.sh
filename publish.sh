#!/usr/bin/env bash

set -e

find _site/ -iname '*.html' -exec gzip -n --best {} +
find _site/ -iname '*.xml' -exec gzip -n --best {} +
find _site/ -iname '*.css' -exec gzip -n --best {} +

for f in `find _site/ -iname '*.gz'`; do
  mv $f ${f%.gz}
done

s3cmd sync --verbose -M --progress --acl-public \
--recursive --access_key=$SITE_AWS_KEY \
--secret_key=$SITE_AWS_SECRET --no-mime-magic \
--no-guess-mime-type --default-mime-type='text/html; charset=utf-8' \
--add-header='Content-Encoding:gzip' \
--add-header='Content-Type: text/html; charset=utf-8' \
_site/ s3://her.sh/ \
--exclude '*.*' \
--include '*.html' --include '*.xml'

s3cmd sync --verbose -M --progress --acl-public \
--recursive --access_key=$SITE_AWS_KEY \
--secret_key=$SITE_AWS_SECRET --no-mime-magic \
--add-header='Content-Encoding:gzip' \
--add-header='Cache-Control:max-age=86400' \
_site/ s3://her.sh/ \
--exclude '*.*' \
--include '*.css'

s3cmd sync --verbose -M --progress --acl-public \
--recursive --access_key=$SITE_AWS_KEY \
--secret_key=$SITE_AWS_SECRET --no-mime-magic \
--add-header='Cache-Control:max-age=86400' \
_site/ s3://her.sh/ \
--exclude '*.*' \
--include '*.png' --include '*.css' --include '*.js' \
--include '*.txt' --include '*.gif' --include '*.jpeg' \
--include '*.ico'
