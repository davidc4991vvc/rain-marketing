class WechatsController < ApplicationController
  before_action :set_wechat, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  def show
    render :text => params[:echostr]
  end

  def create
    if params[:xml][:MsgType] == "text"
      render "echo", :formats => :xml
    end
  end

  # GET /wechats
  # GET /wechats.json
  def index
    @wechats = Wechat.all
  end

  # GET /wechats/new
  def new
    @wechat = Wechat.new
  end

  # GET /wechats/1/edit
  def edit
  end

  # POST /wechats
  # POST /wechats.json
  def create
    @wechat = Wechat.new(wechat_params)

    respond_to do |format|
      if @wechat.save
        format.html { redirect_to @wechat, notice: 'Wechat was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wechat }
      else
        format.html { render action: 'new' }
        format.json { render json: @wechat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wechats/1
  # PATCH/PUT /wechats/1.json
  def update
    respond_to do |format|
      if @wechat.update(wechat_params)
        format.html { redirect_to @wechat, notice: 'Wechat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wechat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wechats/1
  # DELETE /wechats/1.json
  def destroy
    @wechat.destroy
    respond_to do |format|
      format.html { redirect_to wechats_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wechat
      @wechat = Wechat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wechat_params
      params.require(:wechat).permit(:to_user_name, :from_user_name, :msg_type, :event, :event_key)
    end

    # 根据参数校验请求是否合法，如果非法返回错误页面
    def check_weixin_legality
      array = [ENV["WECHAT_TOKEN"], params[:timestamp], params[:nonce]].sort
      render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
    end
end
