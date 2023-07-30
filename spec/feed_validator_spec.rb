# frozen_string_literal: true

require 'spec_helper'

require 'feed_validator'

RSpec.describe FeedValidator do
  subject { described_class.new('foo') }

  describe '#call' do
    it 'when raise an error during validation, the feed must be invalid' do
      allow(subject).to receive(:fetch).and_raise(StandardError)

      validator = subject.call

      expect(validator).not_to be_valid
    end
  end
end
