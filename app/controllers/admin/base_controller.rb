module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate_user!
    before_action :require_operator_for_writes!

    after_action :audit_standard_event, only: %i[create update destroy]

    private

    def audit_standard_event
      # Audita apenas se a requisição não falhou com erro de formulário visando sucesso na operação.
      # Exclui UsersController das standard actions, pois a auditoria do modulo de equipe fará manual.
      return unless (response.redirect? || response.successful?) && controller_name != 'users'

      record = instance_variable_get("@#{controller_name.singularize}")
      return unless record.present? && (record.persisted? || record.destroyed?)

      payload = {}
      if record.respond_to?(:previous_changes) && ['create', 'update'].include?(action_name)
        payload = record.previous_changes.except('created_at', 'updated_at')
      end

      audit!(action_name, record, payload)
    end

    def require_operator_for_writes!
      # Impede explicitamente perfis Viewer de acessar rotas que modificam dados
      write_actions = %w[new create edit update destroy cancel mark_generated toggle_active resolve close]
      
      if (write_actions.include?(action_name) || (!request.get? && action_name != 'index' && action_name != 'show')) && !can_write?
        redirect_to request.referer || admin_root_path, alert: "Acesso restrito. Meu Perfil é APENAS DE LEITURA."
      end
    end

    def authenticate_user!
      if user_signed_in? && !current_user.active?
        session[:user_id] = nil
        redirect_to admin_login_path, alert: "Sua conta foi inativada."
      elsif !user_signed_in?
        redirect_to admin_login_path, alert: "Você precisa estar logado."
      end
    end

    def require_admin!
      unless current_user&.admin?
        redirect_to admin_root_path, alert: "Acesso restrito a administradores."
      end
    end
  end
end
