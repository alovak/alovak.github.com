# encoding: utf-8

# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "rubygems"
require "bundler/setup"

require 'compass'
require 'chronic'
require 'nokogiri'

Compass.add_project_configuration('compass/config.rb')

include Nanoc3::Helpers::Blogging

Nanoc3::Filter.register '::Nanoc3::Filters::Sass', :scss

def date_of(item)
  date = Chronic.parse(item[:created_at])
  date.strftime('%d %b %Y')
end

def excerpt_of(item, read_more='<!-- read more -->')
  post_dom = Nokogiri::HTML::DocumentFragment.parse(item.compiled_content)
  more_tag_found = false

  post_dom.css('*').each do |p, index|
    if p.inner_html.match(read_more)
      p.inner_html = p.inner_html.gsub(Regexp.new("#{read_more}.*"), "<p><a href=\"#{item.identifier}\" class=\"read-more\">Read more...</a></p>")
      more_tag_found = true
      next
    end
    p.remove if more_tag_found
  end

  more_tag_found ?  post_dom.to_s : item.compiled_content
end
