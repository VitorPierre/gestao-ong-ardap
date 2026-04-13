class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :user_signed_in?, :can_write?, :can_manage_users?, :can_audit?

  private

  def can_write?
    current_user&.admin? || current_user&.operator?
  end

  def can_manage_users?
    current_user&.admin?
  end
  
  def can_audit?
    current_user&.admin?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def audit!(action, record = nil, payload = nil, specific_user_id = nil)
    AuditLog.create!(
      user_id: specific_user_id || session[:user_id],
      action: action,
      auditable: record,
      resource_name: record.to_s,
      ip_address: request.remote_ip,
      path: request.fullpath,
      payload: payload || {},
      occurred_at: Time.current
    )
  rescue => e
    Rails.logger.error "Falha Crítica ao tentar registrar Auditoria: #{e.message}"
  end
end
