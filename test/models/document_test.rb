require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  def setup
    @draft = documents(:draft_doc)
    @signed = documents(:signed_doc)
  end

  test "should be valid by default" do
    assert @draft.valid?
    assert @signed.valid?
  end

  test "signed documents should be locked and store integrity hash" do
    assert @signed.signed?
    assert @signed.is_locked?
    assert_not_nil @signed.hash_signature, "Documentos assinados precisam manter o tracking do hash nativo"
  end

  test "enum logic categories" do
    assert_respond_to @draft, :adoption?
    assert_respond_to @draft, :adoption_term?
    
    assert @draft.draft?
  end
end
