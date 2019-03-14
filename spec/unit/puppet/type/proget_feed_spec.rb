require 'spec_helper'
require 'puppet/type/proget_feed'

RSpec.describe 'the proget_feed type' do
  it 'loads' do
    expect(Puppet::Type.type(:proget_feed)).not_to be_nil
  end
end
