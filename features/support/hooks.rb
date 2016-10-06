require 'watir-webdriver'
require 'fileutils'

def browser_path
  (ENV['BPATH'])
end

def browser_name
  ENV.fetch('BROWSER_NAME', 'safari')
end

def url
  ENV.fetch('URL', '192.168.13.131:4444')
end

def environment
  (ENV['ENV'] ||= 'grid').downcase.to_sym
end

def browser_version
  (ENV['VER'])
end

def session_data
  @session_data ||= {
    browser_name => {}
  }
end

Before do
  def assert_it message, &block
    begin
      if (block.call)
        puts "Assertion PASSED for #{message}"
      else
        puts "Assertion FAILED for #{message}"
        fail('Test Failure on assertion')
      end
    rescue => e
      puts "Assertion FAILED for #{message} with exception '#{e}'"
      fail('Test Failure on assertion')
    end
  end
  if browser_path != nil
    Selenium::WebDriver::Firefox.path= "#{browser_path}"
  end
  if environment == :grid
    @browser = Watir::Browser.new(:remote, :url=>"http://#{url}/wd/hub", :desired_capabilities=> {browserName: browser_name,version: browser_version})
    @browser.window.maximize
  else
    @browser = Watir::Browser.new browser_name
    @browser = Watir::Browser.new

    @browser.window.maximize
  end

end

After do |scenario|
  if scenario.failed?
    file_name = ['FAILED_', scenario.name.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, ''), '.png'].join
    datetime_folder = File.join('screenshots', Time.now.strftime('%d-%m-%Y-%H-%M-%S'))
    FileUtils.mkdir_p(datetime_folder)
    screenshot_file = File.join(datetime_folder, file_name)
    @browser.driver.save_screenshot(screenshot_file)
    embed screenshot_file, 'image/png'
  end
  @browser.close
end

# if ENV['BROWSER'] == 'chrome'
#   puts 'I am chrome'
# elsif ENV['BROWSER'] == 'firefox'
#   puts 'I am firefox'
# end

# binding.remote_pry