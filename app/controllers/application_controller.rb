class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def strip_money(value)
    value.gsub(/[\$,\,]/, "")
  end
end
