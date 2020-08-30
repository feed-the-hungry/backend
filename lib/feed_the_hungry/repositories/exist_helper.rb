# frozen_string_literal: true

module ExistHelper
  def exist?(id: nil, field:, value: nil, collection:)
    return false if value.nil? || value&.strip == ''

    if id.nil?
      collection.exist?(field.to_sym => value)
    else
      collection.exclude(id: id).exist?(field.to_sym => value)
    end
  end
end
