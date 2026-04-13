require "test_helper"

class AuditLogTest < ActiveSupport::TestCase
  def setup
    @log = audit_logs(:log_one)
  end

  test "validates proper log instance" do
    assert @log.valid?
  end

  test "requires action and occurred_at" do
    @log.action = nil
    assert_not @log.valid?, "Must have an action name"

    @log.action = "delete"
    @log.occurred_at = nil
    assert_not @log.valid?, "Must have occurred_at timestamp"
  end

  test "scopes find exact matching records" do
    assert_includes AuditLog.by_action("sign_in"), @log
    assert_not_includes AuditLog.by_action("delete"), @log
  end
end
