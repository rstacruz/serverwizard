desc "Run all tests [Testing]"
task(:test) {
  Dir['./test/**/*_test.rb'].each { |f| load f }
}

namespace(:test) do
  desc "Runs tests continuously when files change [Testing]"
  task(:auto) {
    system "rstake \"rake test:spork\" ."
  }

  [ :chrome, :firefox ].each do |driver|
    desc "Run all tests with JS tests in #{driver.to_s.capitalize} [Testing]"
    task(driver) {
      ENV['CAPYBARA_DRIVER'] = driver.to_s
      Dir['./test/**/*_test.rb'].each { |f| load f }
    }
  end
end

