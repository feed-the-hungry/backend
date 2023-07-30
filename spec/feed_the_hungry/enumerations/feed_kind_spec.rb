# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FeedTheHungry::Enumerations::FeedKind do
  subject { described_class }

  describe '.all' do
    it 'return all feed kinds available' do
      expect(subject.all).to eq %w[text audio]
    end
  end
end
