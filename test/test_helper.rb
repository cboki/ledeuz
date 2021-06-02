ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def select_date(date, from:)
    label_el = find('label', text: from)
    id = label_el['for'].delete_suffix('_3i')
    select(date.year, from: "#{id}_1i")
    select(I18n.l(date, format: "%B"), from: "#{id}_2i")
    select(date.day, from: "#{id}_3i")
  end

  # Devise test helpers
  include Warden::Test::Helpers
  Warden.test_mode!
end

# Register the new driver for Capybara
Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu window-size=1400,900])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.save_path = Rails.root.join('tmp/capybara')
Capybara.javascript_driver = :headless_chrome
