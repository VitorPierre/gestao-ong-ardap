module Admin
  class SessionsController < Admin::BaseController
    skip_before_action :authenticate_user!
    skip_before_action :require_operator_for_writes!
    layout 'login'

    def new
      # Redirect if already logged in
      redirect_to admin_root_path if user_signed_in?
    end

    def create
      puts "\n=== DEBUG SESSIONS CREATE ==="
      puts "EMAIL: #{params[:email]}"
      puts "PWD: #{params[:password]}"
      user = User.find_by(email: params[:email])
      puts "USER: #{user&.email}"
      puts "AUTH: #{user&.authenticate(params[:password]).present?}"
      puts "ACTIVE: #{user&.active?}"
      puts "===========================\n"

      if user&.authenticate(params[:password])
        if user.active?
          session[:user_id] = user.id
          user.update_column(:last_sign_in_at, Time.current)
          audit!('sign_in')
          redirect_to admin_root_path, notice: "Bem-vindo(a), #{user.name}!"
        else
          audit!('sign_in_failure_blocked', nil, { email: params[:email] }, user.id)
          flash.now[:alert] = "Sua conta está desativada. Procure a administração."
          render :new, status: :forbidden
        end
      else
        audit!('sign_in_failure_invalid', nil, { email: params[:email] }, user&.id)
        flash.now[:alert] = "E-mail ou senha inválidos."
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      audit!('sign_out')
      session[:user_id] = nil
      redirect_to admin_login_path, notice: "Você saiu do sistema."
    end
  end
end
