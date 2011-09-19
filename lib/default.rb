# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "rubygems"
require "bundler/setup"

require 'compass'
require 'chronic'

Compass.add_project_configuration('compass/config.rb')

include Nanoc3::Helpers::Blogging

Nanoc3::Filter.register '::Nanoc3::Filters::Sass', :scss

def date_of(item)
  date = Chronic.parse(item[:created_at])
  date.strftime('%d %b %Y')
end
