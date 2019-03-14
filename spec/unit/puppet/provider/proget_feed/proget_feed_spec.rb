require 'spec_helper'

ensure_module_defined('Puppet::Provider::ProgetFeed')
require 'puppet/provider/proget_feed/proget_feed'

RSpec.describe Puppet::Provider::ProgetFeed::ProgetFeed do
  subject(:provider) { described_class.new }

  let(:context) { instance_double('Puppet::ResourceApi::BaseContext', 'context') }

  let(:feed_list) do
    File.read(File.join(
      File.dirname(__FILE__),
      '../../../../fixtures/unit/puppet/provider/proget_feed/get_feeds.xml'
    ))
  end

  describe '#get' do
    it 'processes resources' do
      expect(context).to receive(:debug).with('Returning pre-canned example data')
      expect(provider).to receive(:get_feeds).with(context).and_return(feed_list)
      expect(provider.get(context)).to eq [
        {
          name: 'PROGET-IAASTEAM-DEV',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-EXP',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-NONPROD',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-PROD',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-QA',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-TEST',
          ensure: 'present',
        },
      ]
    end
  end

  describe 'create(context, name, should)' do
    it 'creates the resource' do
      expect(context).to receive(:notice).with(%r{\ACreating 'a'})

      provider.create(context, 'a', name: 'a', ensure: 'present')
    end
  end

  describe 'update(context, name, should)' do
    it 'updates the resource' do
      expect(context).to receive(:notice).with(%r{\AUpdating 'foo'})

      provider.update(context, 'foo', name: 'foo', ensure: 'present')
    end
  end

  describe 'delete(context, name)' do
    it 'deletes the resource' do
      expect(context).to receive(:notice).with(%r{\ADeleting 'foo'})

      provider.delete(context, 'foo')
    end
  end
end
