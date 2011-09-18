# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require 'compass'

Compass.add_project_configuration('compass/config.rb')

include Nanoc3::Helpers::Blogging

Nanoc3::Filter.register '::Nanoc3::Filters::Sass', :scss
