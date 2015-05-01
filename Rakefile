task :setup do
    sh "bundle check --path=vendor/bundle || bundle install --jobs=4 --retry=2 --path=vendor/bundle"
    sh "npm list write-good || npm install -g write-good"
end

task :serve do
    sh "bundle exec jekyll serve --watch --config _config.yml"
end

task :build do
    sh "bundle exec jekyll build --config _config.yml"
end

task :lint do
    sh "bundle exec htmlproof --check-favicon --check-html --only-4xx _site"
    puts `write-good index.html`
end

task :publish do    
    system %{

        SITE="s3://her.sh/"

        find _site/ -iname '*.html' -exec gzip -n --best {} +
        find _site/ -iname '*.xml' -exec gzip -n --best {} +

        for f in `find _site/ -iname '*.gz'`; do
            mv $f ${f%.gz}
        done

        # Sync GZip'd HTML and XML

        s3cmd sync --progress -M --acl-public \
        --access_key=$SITE_AWS_KEY \
        --secret_key=$SITE_AWS_SECRET \
        --add-header 'Content-Encoding:gzip' \
        _site/ $SITE \
        --exclude '*.*' \
        --include '*.html' --include '*.xml' \
        --verbose 

        # Sync all remaining files

        s3cmd sync --progress -M --acl-public \
        --access_key=$SITE_AWS_KEY \
        --secret_key=$SITE_AWS_SECRET \
        _site/ $SITE \
        --exclude '*.*' \
        --include '*.png' --include '*.css' --include '*.js' --include '*.txt' --include '*.gif' --include '*.jpeg' \
        --verbose 

    }
end
