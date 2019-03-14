require 'puppet/resource_api/simple_provider'
require 'puppet/util/inifile'
require 'savon'
require 'nokogiri'

# Implementation for the proget_feed type using the Resource API.
class Puppet::Provider::ProgetFeed::ProgetFeed < Puppet::ResourceApi::SimpleProvider
  def get(context)
    context.debug('Returning pre-canned example data')
    xml_feeds = Nokogiri::XML(feeds)
    xml_feeds.xpath('//Feeds').map do |f|
      {
        name: f.xpath('Feed_Name').text,
        id: f.xpath('Feed_Id').text.to_i,
        type: f.xpath('FeedType_Name').text,
        ensure: 'present',
      }
    end
  end

  def feeds
    client.call(:feeds_get_feeds, message: { 'API_Key' => api_key })
  end

  def config
    unless @conf
      path = "#{Puppet[:confdir]}/proget.ini"
      @conf = Puppet::Util::IniConfig::PhysicalFile.new(path)
      @conf.read
    end
    @conf
  end

  def server_url
    config.get_section('server')['url']
  end

  def api_key
    config.get_section('api')['key']
  end

  def client
    @client ||= Savon.client(wsdl: server_url)
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
