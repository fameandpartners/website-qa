require 'watir'
require 'watir-scroll'
require 'page-object'
require_relative 'pages/base_page'

CONFIG = YAML.load_file(Dir.pwd+"/config/local.yml").to_hash

World(PageObject::PageFactory)