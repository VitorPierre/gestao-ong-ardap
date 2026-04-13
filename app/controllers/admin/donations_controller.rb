class Admin::DonationsController < Admin::BaseController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  def index
    @donations = Donation.order(donated_at: :desc)

    if params[:type].present?
      @donations = @donations.where(donation_type: params[:type])
    end

    if params[:status].present?
      @donations = @donations.where(status: params[:status])
    end
    
    if params[:period] == 'this_month'
      @donations = @donations.where(donated_at: Time.current.beginning_of_month..Time.current.end_of_month)
    end
  end

  def show
  end

  def new
    @donation = Donation.new(
      donated_at: Date.current,
      partner_id: params[:partner_id],
      person_id: params[:person_id]
    )
  end

  def edit
  end

  def create
    @donation = Donation.new(donation_params)

    if @donation.save
      redirect_to admin_donations_path, notice: "Doação registrada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @donation.update(donation_params)
      redirect_to admin_donations_path, notice: "Doação atualizada com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @donation.destroy!
    redirect_to admin_donations_path, notice: "Doação removida com sucesso.", status: :see_other
  end

  private

  def set_donation
    @donation = Donation.find(params[:id])
  end

  def donation_params
    params.require(:donation).permit(
      :partner_id, :person_id, :donation_type, :amount, :description,
      :donated_at, :recurrent, :recurrence_interval, :payment_method,
      :receipt_number, :status, :notes
    )
  end
end
