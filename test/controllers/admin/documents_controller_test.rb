require 'test_helper'

class Admin::DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as_operator
    @draft = documents(:draft_doc)
  end

  test "document creation logs to audit camera" do
    post admin_documents_path, params: { document: { title: "Termo Novo", category: "person", document_type: "person_registration" } }
    assert_equal 'create', AuditLog.last.action
  end

  test "state mark generated changes document behavior" do
    patch mark_generated_admin_document_path(@draft)
    assert @draft.reload.generated?
    assert_equal 'mark_generated', AuditLog.last.action
  end

  test "cancel obliterates workflow forever" do
    patch cancel_admin_document_path(@draft)
    assert @draft.reload.canceled?
    assert_equal 'cancel', AuditLog.last.action
  end
end
