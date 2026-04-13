module Admin
  class UsersController < Admin::BaseController
    before_action :require_admin!
    before_action :set_user, only: %i[show edit update toggle_active]

    def index
      @users = User.all.order(active: :desc, role: :asc, created_at: :desc)
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.created_by = current_user
      
      if @user.save
        audit!('user_create', @user)
        redirect_to admin_users_path, notice: "Usuário #{@user.name} cadastrado com sucesso."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      # Allow editing without changing password
      params_to_update = user_params
      params_to_update.delete(:password) if params_to_update[:password].blank?

      if @user.update(params_to_update)
        audit!('user_update', @user, @user.previous_changes.except('password_digest', 'updated_at'))
        redirect_to admin_users_path, notice: "Configurações do usuário atualizadas."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def toggle_active
      if @user == current_user
        redirect_to admin_users_path, alert: "Você não pode suspender sua própria conta logada."
      else
        @user.update(active: !@user.active)
        audit!(@user.active ? 'user_enable' : 'user_disable', @user)
        status = @user.active ? "ativado" : "desativado"
        redirect_to admin_users_path, notice: "O acesso de #{@user.name} foi #{status}."
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :role, :password)
    end
  end
end
