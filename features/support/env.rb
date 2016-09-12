require 'watir'
require 'watir-scroll'
require 'watir-webdriver'
require 'page-object'


CONFIG = YAML.load_file(Dir.pwd+"/config/local.yml").to_hash

World(PageObject::PageFactory)