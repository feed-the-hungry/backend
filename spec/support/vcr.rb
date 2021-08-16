# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end

RSpec.configure do |config|
  # Add VCR to all tests
  config.around do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = example
             .metadata[:description]
             .split(/\s+/, 2)
             .join('/')
             .downcase
             .gsub(/\./, '/')
             .gsub(%r{[^\w/]+}, '_')
             .gsub(%r{/$}, '')
      VCR.use_cassette(name, record: :once, &example)
    end
  end
end
