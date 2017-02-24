require 'watir'
require 'watir-scroll'
require 'page-object'
require_relative 'pages/base_page'
require 'faker'
require 'csv'
require_relative 'pages/store_front_pages/modules/wed_atl_helper'
CONFIG = YAML.load_file(Dir.pwd+"/config/local.yml").to_hash

World(PageObject::PageFactory)