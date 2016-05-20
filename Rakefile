require 'jsonlint/rake_task'
JsonLint::RakeTask.new do |t|
  t.paths = %w(
    stacks/**/*.json
    params/**/*.json
  )
end

task :copy_artifacts do
  if ENV['CI'] == 'true' && ENV['TRAVIS_PULL_REQUEST'] == 'false'
    `mkdir -p build;
     cp -R templates build;
     cp -R params build;
     sed -i "s/{{branch}}/#{ENV['TRAVIS_BRANCH']}/" build/templates/*.json;
     sed -i "s/{{commit}}/#{ENV['TRAVIS_COMMIT'].slice(0, 8)}/" build/templates/*.json
     `
  end
end

task default: [:jsonlint, :copy_artifacts]
