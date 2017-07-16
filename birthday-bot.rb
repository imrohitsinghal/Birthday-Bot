require 'active_support'
require 'watir-webdriver'
require 'selenium-webdriver'
require 'selenium/webdriver/common/socket_poller'
require_relative 'driver'
require_relative 'credentials'

@config = {
    wish: 'Happy Birthday..Partyy Hard and Have a Super Duper Bday! :)',
    url: 'http://www.facebook.com',
    birthday: '/events/birthdays',
    day: 86400
}

@locator = {
    email_id: 'email',
    password_id: 'pass',
    login_value: 'Log In'
}

while true
  @bb = create_driver
  @bb.goto(@config[:url])
  @bb.text_field(:id => @locator[:email_id]).set @account[:username]
  @bb.text_field(:id => @locator[:password_id]).set @account[:password]
  @bb.button(:value => @locator[:login_value]).click
  @bb.goto(@config[:url] + @config[:birthday])
  birthdays = @bb.textareas
  birthdays.each do |birthday|
    birthday.set @config[:wish]
    @bb.send_keys :enter
  end
  @bb.close
  sleep @config[:day]
end