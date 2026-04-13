class Admin::PartnersController < Admin::BaseController
  before_action :set_partner, only: [:show, :edit, :update, :destroy]

  def index
    @partners = Partner.order(:name)
    
    if params[:status].present?
      @partners = @partners.where(status: params[:status])
    end
    
    if params[:type].present?
      @partners = @partners.where(partnership_type: params[:type])
    end
  end

  def show
    @donations = @partner.donations.order(donated_at: :desc)
  end

  def new
    @partner = Partner.new(started_at: Date.current)
  end

  def edit
  end

  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      redirect_to admin_partner_path(@partner), notice: "Parceiro cadastrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @partner.update(partner_params)
      redirect_to admin_partner_path(@partner), notice: "Parceiro atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @partner.destroy!
    redirect_to admin_partners_path, notice: "Parceiro removido.", status: :see_other
  end

  private

  def set_partner
    @partner = Partner.find(params[:id])
  end

  def partner_params
    params.require(:partner).permit(
      :name, :document, :contact_name, :phone, :email, :website,
      :address, :city, :state, :partnership_type, :status, :notes, :started_at
    )
  end
end
