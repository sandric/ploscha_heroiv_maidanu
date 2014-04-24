#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "capybara"
require "capybara/dsl"
require "capybara-webkit"

Capybara.run_server = false
Capybara.current_driver = :webkit
Capybara.app_host = "http://dniprorada.gov.ua"

module Volodya
  class Slezay
    include Capybara::DSL

    def vote
      visit '/poll/3-square-renaming-poll'
      choose 'площа Героїв Майдану'
      click_button 'OK'
    end
  end
end

spider = Volodya::Slezay.new

counter = 1
ARGV[0].to_i.times.each do
  p "#{counter} Huylo"
  spider.vote
  Capybara.current_session.driver.browser.clear_cookies

  sleep(2.0 + (Random.rand(100) / 50.0))

  counter += 1
end
