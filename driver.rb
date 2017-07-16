def create_driver
  chrome_driver_path = "mac/chromedriver"
  chrome_driver_port = 9515 + ENV['TEST_ENV_NUMBER'].to_i
  server_command = [chrome_driver_path, "--port=#{chrome_driver_port}"]
  puts "Starting chrome driver on http://localhost:#{chrome_driver_port}..."
  chrome_driver = ChildProcess.build(*server_command)
  chrome_driver.start
  socket_poller = Selenium::WebDriver::SocketPoller.new("localhost", chrome_driver_port, 20)
  sleep 2 until socket_poller.connected?
  browser = Watir::Browser.new(Selenium::WebDriver.for(:chrome, {:url => "http://localhost:#{chrome_driver_port}", :switches => %w[--allow-running-insecure-content]}))
  Watir.default_timeout = 60
  at_exit do
    sleep(2)
    browser.quit
  end
  browser
end