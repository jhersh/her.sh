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
    sh "bundle exec htmlproofer --check-external-hash --only-4xx _site"
end
