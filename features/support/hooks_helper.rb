module HooksHelper

  def browser_path
    (ENV['BPATH'])
  end

  def browser_name
    ENV.fetch('BROWSER_NAME', 'chrome')
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

  def test_server
    ENV.fetch('SRV', 'staging')
  end

  def session_data
    @session_data ||= {
        browser_name => {}
    }
  end

end