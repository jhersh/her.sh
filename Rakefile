task :setup do
    sh "bundle check --path=vendor/bundle || bundle install --jobs=4 --retry=2 --path=vendor/bundle"
end

task :serve do
    sh "bundle exec jekyll serve --watch --config _config.yml"
end

task :build do
    sh "bundle exec jekyll build --config _config.yml"
end

task :lint do
    sh "bundle exec htmlproofer --check-favicon --check-html --check-external-hash --only-4xx _site"
end

task :publish do    
    system %{

        find _site/ -iname '*.html' -exec gzip -n --best {} +
        find _site/ -iname '*.xml' -exec gzip -n --best {} +
        find _site/ -iname '*.css' -exec gzip -n --best {} +

        for f in `find _site/ -iname '*.gz'`; do
            mv $f ${f%.gz}
        done
    }
    
    cmd_extra = "--verbose -M --progress --acl-public --recursive"
    
    if ENV['CIRCLECI'] == 'true'
        cmd_extra += " --access_key=$SITE_AWS_KEY --secret_key=$SITE_AWS_SECRET"
    end

    sh "s3cmd sync #{cmd_extra} --no-mime-magic --no-guess-mime-type "+
    "--default-mime-type='text/html; charset=utf-8' "+
    "--add-header='Content-Encoding:gzip' "+
    "--add-header='Content-Type: text/html; charset=utf-8' "+
    "_site/ s3://her.sh/ "+
    "--exclude '*.*' "+
    "--include '*.html' --include '*.xml'"

    sh "s3cmd sync #{cmd_extra} --no-mime-magic "+
    "--add-header='Content-Encoding:gzip' "+
    "--add-header='Cache-Control:max-age=86400' "+
    "_site/ s3://her.sh/ "+
    "--exclude '*.*' "+
    "--include '*.css' "

    sh "s3cmd sync #{cmd_extra} --no-mime-magic "+
    "--add-header='Cache-Control:max-age=86400' "+
    "_site/ s3://her.sh/ "+
    "--exclude '*.*' "+
    "--include '*.png' --include '*.css' --include '*.js' --include '*.txt' --include '*.gif' --include '*.jpeg' --include '*.ico' "

end
