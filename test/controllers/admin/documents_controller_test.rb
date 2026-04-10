require "test_helper"

class Admin::DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @document = documents(:one)
  end

  test "should get index" do
    get admin_documents_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_document_url
    assert_response :success
  end

  test "should create document" do
    assert_difference("Document.count") do
      post admin_documents_url, params: { document: {} }
    end

    assert_redirected_to admin_document_url(Document.last)
  end

  test "should show document" do
    get admin_document_url(@document)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_document_url(@document)
    assert_response :success
  end

  test "should update document" do
    patch admin_document_url(@document), params: { document: {} }
    assert_redirected_to admin_document_url(@document)
  end

  test "should destroy document" do
    assert_difference("Document.count", -1) do
      delete admin_document_url(@document)
    end

    assert_redirected_to admin_documents_url
  end
end
