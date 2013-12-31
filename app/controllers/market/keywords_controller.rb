class Market::KeywordsController < Market::ApplicationController
  before_action :set_market_keyword, only: [:show, :edit, :update, :destroy]

  # GET /market/keywords
  # GET /market/keywords.json
  def index
    @market_keywords_count ||= Market::Keyword.all.size
    @market_keywords_parent_count ||= Market::Keyword.where(parent_id: 0).size
    @market_keywords = Market::Keyword.search(params[:search]).page(params[:page])
  end

  # GET /market/keywords/1
  # GET /market/keywords/1.json
  def show
    @baidu_web_result = BaiduWeb.search(@market_keyword.name, :per_page => 50, :page_index => 2)
  end

  # GET /market/keywords/new
  def new
    @market_keyword = Market::Keyword.new
  end

  # GET /market/keywords/1/edit
  def edit
  end

  # POST /market/keywords
  # POST /market/keywords.json
  def create
    @market_keyword = Market::Keyword.find_by(name: market_keyword_params[:name])
    @market_keyword ||= Market::Keyword.new(market_keyword_params)
    respond_to do |format|
      if @market_keyword.save
        KeywordExtendWorker.perform_async(@market_keyword.id, @market_keyword.name, market_keyword_params[:opt1], market_keyword_params[:opt2])
        format.html { redirect_to @market_keyword, notice: 'Keyword was successfully created.' }
        format.json { render action: 'show', status: :created, location: @market_keyword }
      else
        format.html { render action: 'new' }
        format.json { render json: @market_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market/keywords/1
  # PATCH/PUT /market/keywords/1.json
  def update
    respond_to do |format|
      if @market_keyword.update(market_keyword_params)
        format.html { redirect_to @market_keyword, notice: 'Keyword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @market_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /market/keywords/1
  # DELETE /market/keywords/1.json
  def destroy
    @market_keyword.destroy
    respond_to do |format|
      format.html { redirect_to market_keywords_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_keyword
      @market_keyword = Market::Keyword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_keyword_params
      params.require(:market_keyword).permit(:market_site_id, :parent_id, :name)
    end
end
