require 'jsonlint/rake_task'
JsonLint::RakeTask.new do |t|
  t.paths = %w(
    **/*.json
  )
end

task default: :jsonlint
