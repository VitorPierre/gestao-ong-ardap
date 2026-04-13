require "test_helper"

class ComplaintTest < ActiveSupport::TestCase
  def setup
    @complaint = complaints(:complaint_one)
  end

  test "should be valid from fixture" do
    assert @complaint.valid?
  end

  test "protocol generation is hooked" do
    new_complaint = Complaint.new(
      description: "Animal amarrado curto no sol", 
      priority: "urgent", 
      category: "abuse", 
      status: "new_status",
      anonymous: true,
      received_at: Time.current
    )
    new_complaint.save!
    
    assert_not_nil new_complaint.protocol_number
    assert new_complaint.protocol_number.start_with?("DEN-"), "Protocol does not contain standard DEN prefix"
  end
end
