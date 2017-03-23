require 'jsonlint/rake_task'
JsonLint::RakeTask.new do |t|
  t.paths = %w(
    templates/**/*.json
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

task :audit_solution_stacks do
  require 'aws-sdk'
  require 'fuzzy_match'

  find_template = ->(hash) do
    return hash if hash['Type'] == 'AWS::ElasticBeanstalk::ConfigurationTemplate'
    hash.each_pair do |k,v|
      result = find_template.call(v) if v.is_a?(Hash)
      return result unless result.nil?
    end
    nil
  end

  stacks = Aws::ElasticBeanstalk::Client.new.list_available_solution_stacks.solution_stacks
  matcher = FuzzyMatch.new(stacks)
  files = Dir['templates/*.json']

  files.each do |file|
    doc = JSON.parse(File.read(file))
    template = find_template.call(doc)
    next if template.nil?
    solution_stack = template['Properties']['SolutionStackName']
    next if solution_stack.nil?
    if stacks.include?(solution_stack)
      puts "#{file}: Solution Stack `#{solution_stack}': OK"
    else
      puts "#{file}: Solution Stack `#{solution_stack}': NOT FOUND"
      puts "  Did you mean `#{matcher.find(solution_stack)}'?"
    end
  end
end

task default: [:jsonlint, :copy_artifacts]
