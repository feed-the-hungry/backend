# frozen_string_literal: true

module InteractorHelpers
  def error_messages(result)
    messages = result.messages
    output = result.output

    messages.each do |attribute, message|
      error({ attribute => { value: output[attribute], message: message } })
    end
  end

  def unique_error(attribute, value)
    error(
      {
        attribute => { value: value, message: [I18n.t('errors.messages.unique')] }
      }
    )
  end
end
