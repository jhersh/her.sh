task :setup do
    sh "bundle config build.nokogiri --use-system-libraries "+
    "--with-libxml2lib=/usr/local/Cellar/libxml2/2.9.2/lib "+
    "--with-xml2-include=/usr/local/Cellar/libxml2/2.9.2/include/libxml2 "+
    "--with-xslt-lib=/usr/local/lib "+
    "--with-xslt-include=/usr/local/include "+
    "--with-iconv-dir=/usr/lib "
    sh "bundle check --path=vendor/bundle || bundle install --jobs=4 --retry=2 --path=vendor/bundle"
end

task :serve do
    sh "bundle exec jekyll serve --watch --config _config.yml"
end

task :publish do
    system %{

        SITE="s3://her.sh/"

        bundle exec jekyll build --config _config.yml
        bundle exec htmlproof --check-favicon --check-html --verbose _site

        find _site/ -iname '*.html' -exec gzip -n --best {} +
        find _site/ -iname '*.xml' -exec gzip -n --best {} +

        for f in `find _site/ -iname '*.gz'`; do
            mv $f ${f%.gz}
        done

        # Sync GZip'd HTML and XML

        s3cmd sync --progress -M --acl-public \
        --add-header 'Content-Encoding:gzip' \
        _site/ $SITE \
        --exclude '*.*' \
        --include '*.html' --include '*.xml' \
        --verbose 

        # Sync all remaining files

        s3cmd sync --progress -M --acl-public \
        _site/ $SITE \
        --exclude '*.*' \
        --include '*.png' --include '*.css' --include '*.js' --include '*.txt' --include '*.gif' --include '*.jpeg' \
        --verbose 

    }
end
