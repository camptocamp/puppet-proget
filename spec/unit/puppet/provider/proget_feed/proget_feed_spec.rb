require 'spec_helper'

ensure_module_defined('Puppet::Provider::ProgetFeed')
require 'puppet/provider/proget_feed/proget_feed'

RSpec.describe Puppet::Provider::ProgetFeed::ProgetFeed do
  subject(:provider) { described_class.new }

  let(:context) { instance_double('Puppet::ResourceApi::BaseContext', 'context') }

  let(:feed_list) do
    File.read(
      File.join(
        File.dirname(__FILE__),
        '../../../../fixtures/unit/puppet/provider/proget_feed/get_feeds.xml',
      ),
    )
  end

  describe '#get' do
    it 'processes resources' do
      expect(context).to receive(:debug).with('Returning pre-canned example data')
      expect(Puppet).to receive(:[]).with(:confdir).and_return(File.join(File.dirname(__FILE__), '../../../../fixtures/unit/puppet/provider/proget_feed'))
      expect_any_instance_of(Savon::Client).to receive(:call).with(:feeds_get_feeds, message: { 'API_Key' => 'abcd' }).and_return(feed_list)
      expect(provider.get(context)).to eq [
        {
          name: 'PROGET-IAASTEAM-DEV',
          id: 1,
          type: 'Chocolatey',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-EXP',
          id: 2,
          type: 'Chocolatey',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-NONPROD',
          id: 3,
          type: 'Chocolatey',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-PROD',
          id: 5,
          type: 'Chocolatey',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-QA',
          id: 4,
          type: 'Chocolatey',
          ensure: 'present',
        },
        {
          name: 'PROGET-IAASTEAM-TEST',
          id: 6,
          type: 'Nugget',
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
