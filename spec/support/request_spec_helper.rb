# frozen_string_literal: true
module RequestSpecHelper
  def sign_in(user)
    post "/users/sign_in", params: { user: { email: user.email, password: user.password } }
  end
end
