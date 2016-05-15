def run_spec(folder)
  current_folder = Dir.pwd
  chdir folder
  run_command 'bundle install'
  run_command 'bundle exec rspec'
  chdir current_folder
end

def run_command(command)
  system command
  unless $?.exitstatus == 0
    Kernel.exit($?.exitstatus)
  end
end

desc 'Run Unit Tests'
task :unit_tests do
  run_command './gradlew clean assemble test'
end

desc 'Run Acceptance Tests'
task :acceptance_tests do
  run_spec 'acceptance'
end

desc 'Run all specs'
task :default => [:unit_tests, :acceptance_tests]