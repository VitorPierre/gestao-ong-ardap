module Admin
  class AuditLogsController < Admin::BaseController
    before_action :require_admin!

    def index
      @audit_logs = AuditLog.includes(:user, :auditable).recent
      
      @audit_logs = @audit_logs.by_user(params[:user_id]) if params[:user_id].present?
      @audit_logs = @audit_logs.by_action(params[:action_filter]) if params[:action_filter].present?
      @audit_logs = @audit_logs.by_resource_type(params[:resource_type]) if params[:resource_type].present?
      
      @audit_logs = @audit_logs.limit(1000) # Prevents overloading UI
    end
  end
end
