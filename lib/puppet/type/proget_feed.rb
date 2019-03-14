require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'proget_feed',
  docs: <<-EOS,
      This type provides Puppet with the capability to manage Proget package feeds.
    EOS
  features: [],
  attributes: {
    ensure: {
      type:    'Enum[present, absent]',
      desc:    'Whether the feed should be present or absent.',
      default: 'present',
    },
    name: {
      type:      'String',
      desc:      'The name of the feed.',
      behaviour: :namevar,
    },
    id: {
      type:      'Integer',
      desc:      'The ID of the feed.',
      behaviour: :read_only,
    },
    type: {
      type:      'Enum[nugget, chocolatey]',
      desc:      'The type of package feed.',
      behaviour: :parameter,
    },
  },
)
