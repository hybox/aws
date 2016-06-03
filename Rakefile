require 'jsonlint/rake_task'
JsonLint::RakeTask.new do |t|
  t.paths = %w(
    stacks/**/*.json
    params/**/*.json
  )
end

task :copy_artifacts do
  if ENV['CI'] == 'true' && ENV['TRAVIS_PULL_REQUEST'] == 'false'
    build_dir = File.expand_path('build')
    `mkdir -p #{build_dir};
     cp -R templates #{build_dir};
     cp -R params #{build_dir};
     sed -i "s/{{branch}}/#{ENV['TRAVIS_BRANCH']}/" #{build_dir}/templates/*.json;
     sed -i "s/{{commit}}/#{ENV['TRAVIS_COMMIT'].slice(0, 8)}/" #{build_dir}/templates/*.json
     `
  end
end

task default: [:jsonlint, :copy_artifacts]
