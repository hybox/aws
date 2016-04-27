require 'jsonlint/rake_task'
JsonLint::RakeTask.new do |t|
  t.paths = %w(
    stacks/**/*.json
    params/**/*.json
  )
end

task :copy_artifacts do
  `mkdir build; cp -R stacks build; cp -R params build`
end

task default: [:jsonlint, :copy_artifacts]
