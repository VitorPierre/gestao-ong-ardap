module Admin
  class SessionsController < Admin::BaseController
    skip_before_action :authenticate_user!
    layout 'login'

    def new
      # Redirect if already logged in
      redirect_to admin_root_path if user_signed_in?
    end

    def create
      user = User.find_by(email: params[:email])

      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_root_path, notice: "Bem-vindo(a), #{user.name}!"
      else
        flash.now[:alert] = "E-mail ou senha inválidos."
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to admin_login_path, notice: "Você saiu do sistema."
    end
  end
end
