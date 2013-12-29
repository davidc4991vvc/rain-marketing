class Market::SitesController < Market::ApplicationController
  before_action :set_market_site, only: [:show, :edit, :update, :destroy]

  # GET /market/sites
  # GET /market/sites.json
  def index
    @market_sites = Market::Site.all
  end

  # GET /market/sites/1
  # GET /market/sites/1.json
  def show
  end

  # GET /market/sites/new
  def new
    @market_site = Market::Site.new
  end

  # GET /market/sites/1/edit
  def edit
  end

  # POST /market/sites
  # POST /market/sites.json
  def create
    @market_site = Market::Site.new(market_site_params)
    @market_site.user_id = current_user.id

    respond_to do |format|
      if @market_site.save
        format.html { redirect_to @market_site, notice: 'Site was successfully created.' }
        format.json { render action: 'show', status: :created, location: @market_site }
      else
        format.html { render action: 'new' }
        format.json { render json: @market_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market/sites/1
  # PATCH/PUT /market/sites/1.json
  def update
    respond_to do |format|
      if @market_site.update(market_site_params)
        format.html { redirect_to @market_site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @market_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /market/sites/1
  # DELETE /market/sites/1.json
  def destroy
    @market_site.destroy
    respond_to do |format|
      format.html { redirect_to market_sites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_site
      @market_site = Market::Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_site_params
      params.require(:market_site).permit(:user_id, :name, :domain, :online_date)
    end
end
