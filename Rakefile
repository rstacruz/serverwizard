require './lib/log_helpers'
extend LogHelpers

desc "Starts the server [Development]"
task(:start) {
  system "ruby init.rb"
}

desc "Opens a console session [Development]"
task(:irb) {
  irb = ENV['IRB_PATH'] || 'irb'
  system "#{irb} -r./init.rb"
}

Dir['./lib/tasks/**/*.rake'].each { |f| load f }
task :default => :help

desc "Builds a bundle [Recipe]"
task(:build, :bundle) { |_, args|
  recipes = args[:bundle].split('+')

  unless recipes.any?
    $stderr.write "Usage: rake build[recipe1+recipe2...]\n"
    exit 61
  end

  require './init'
  b = Bundle.new recipes
  puts b.build
}
