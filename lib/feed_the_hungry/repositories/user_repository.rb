# frozen_string_literal: true

class UserRepository < Hanami::Repository
  def email_exist?(id: nil, email: nil)
    return false if email.nil? || email&.strip == ''

    if id.nil?
      users.exist?(email: email)
    else
      users
        .exclude(id: id)
        .exist?(email: email)
    end
  end
end
