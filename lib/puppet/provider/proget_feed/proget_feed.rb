require 'puppet/resource_api/simple_provider'
require 'nokogiri'

# Implementation for the proget_feed type using the Resource API.
class Puppet::Provider::ProgetFeed::ProgetFeed < Puppet::ResourceApi::SimpleProvider
  def get(context)
    context.debug('Returning pre-canned example data')
    xml_feeds = Nokogiri::XML(get_feeds(context))
    xml_feeds.xpath('//Feeds').map do |f|
      {
        name: f.xpath('Feed_Name').text,
        id: f.xpath('Feed_Id').text.to_i,
        ensure: 'present',
      }
    end
  end

  def get_feeds(context)
    # TODO: implement with soap/REST
  end

  def create(context, name, should)
    context.notice("Creating '#{name}' with #{should.inspect}")
  end

  def update(context, name, should)
    context.notice("Updating '#{name}' with #{should.inspect}")
  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
  end
end
