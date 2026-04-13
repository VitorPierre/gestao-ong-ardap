module Admin
  class DashboardController < BaseController
    def index
      @animals_in_foster  = Animal.in_foster_care.count
      @animals_available  = Animal.available.count
      @recent_adoptions   = Adoption.where('created_at >= ?', 1.month.ago).count
      
      @open_complaints    = Complaint.where(status: [:new_status, :investigating]).count
      @urgent_complaints  = Complaint.where(status: [:new_status, :investigating], priority: [:urgent, :critical]).count
      
      @active_partners    = Partner.where(status: :active).count
      @donations_this_month = Donation.where(donated_at: Time.current.beginning_of_month..Time.current.end_of_month).sum(:amount)

      @latest_adoptions   = Adoption.order(created_at: :desc).limit(3)
      @latest_animals     = Animal.order(created_at: :desc).limit(3)
      @latest_complaints  = Complaint.order(received_at: :desc).limit(3)
      @latest_donations   = Donation.order(donated_at: :desc).limit(3)
    end
  end
end
