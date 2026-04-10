module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate_user!

    private

    def authenticate_user!
      unless user_signed_in?
        redirect_to admin_login_path, alert: "Você precisa estar logado para acessar a área administrativa."
      end
    end
  end
end
