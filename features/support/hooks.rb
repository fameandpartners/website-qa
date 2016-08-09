require 'watir-webdriver'

def browser_path
  (ENV['BPATH'])
end

def browser_name
  (ENV['BROWSER'] ||= 'chrome').downcase.to_sym
end

def environment
  (ENV['ENV'] ||= 'grid').downcase.to_sym
end

def browser_version
  (ENV['VER'])
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
    @browser = Watir::Browser.new(:remote, :url=>"http://10.0.145.74:4444/wd/hub", :desired_capabilities=> {browserName: browser_name,version: browser_version})
    @browser.window.maximize
  else
    @browser = Watir::Browser.new browser_name
    @browser.window.maximize
  end

end

After do
  @browser.close
end






# Before do
#   @browser = Watir::Browser.new :chrome
#   @browser.window.maximize
# end
# After do
#   @browser.close
# end


