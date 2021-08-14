# frozen_string_literal: true

module ExistHelper
  def exist?(field:, value: nil, collection:)
    return false if value.nil? || value&.strip == ''

    collection.exist?(field => value)
  end
end
