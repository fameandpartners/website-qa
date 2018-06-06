require 'watir'
require 'fileutils'
require_relative('../../features/support/hooks_helper')
include HooksHelper

Before do |scenario|
  # def assert_it message, &block
  #   begin
  #     if (block.call)
  #       puts "Assertion PASSED for #{message}"
  #     else
  #       puts "Assertion FAILED for #{message}"
  #       fail('Test Failure on assertion')
  #     end
  #   rescue => e
  #     puts "Assertion FAILED for #{message} with exception '#{e}'"
  #     fail('Test Failure on assertion')
  #   end
  # end

  if browser_path != nil
    Selenium::WebDriver::Firefox.path= "#{browser_path}"
  end
  if environment == :grid
    @browser = Watir::Browser.new(:remote, :url => "http://#{grid_url}/wd/hub", :desired_capabilities => {browserName: browser_name, version: browser_version})
    @browser.window.maximize
  else
    @browser = Watir::Browser.new browser_name
    @browser = Watir::Browser.new
  end

  platform = File.basename(File.dirname(scenario.location.file)).to_sym

  case platform
    when :spree_admin
      @browser.window.maximize
    when :desktop
      @browser.window.maximize
    when :mobile
      @browser.window.resize_to(720, 1100)
  end
end

After do |scenario|
  if scenario.failed?
    file_name = ['FAILED_', scenario.name.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, ''), '.png'].join
    datetime_folder = File.join('screenshots', Time.now.strftime('%d-%m-%Y-%H-%M-%S'))
    FileUtils.mkdir_p(datetime_folder)
    screenshot_file = File.join(datetime_folder, file_name)
    @browser.driver.save_screenshot(screenshot_file)
    attach_file(file_name, screenshot_file)
    # embed screenshot_file, 'image/png'
  end
  @browser.close
end
