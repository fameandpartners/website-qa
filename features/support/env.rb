require 'watir'
require 'watir-scroll'
require 'page-object'
require_relative 'pages/base_page'
require 'faker'
require 'csv'
require 'allure-cucumber'
require_relative 'pages/store_front_pages/modules/wed_atl_helper'
CONFIG = YAML.load_file(Dir.pwd+"/config/local.yml").to_hash
include AllureCucumber::DSL

World(PageObject::PageFactory)

class Cucumber::Core::Test::Step
  def name
    text
  end
end