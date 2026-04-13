require "test_helper"

class DocumentSignatureTest < ActiveSupport::TestCase
  test "validates required parameters if signed logic is active" do
    signature = DocumentSignature.new
    assert_not signature.valid?, "Expected DocumentSignature to enforce minimum fields"
  end
end
