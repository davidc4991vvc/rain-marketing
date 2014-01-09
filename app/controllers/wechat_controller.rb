class WechatController < ApplicationController
  skip_before_filter :verify_authenticity_token
   before_filter :check_weixin_legality, except: [:index, :new]

  def index
    render :text => params[:echostr]
  end
  def new
  end

  def create
    logger.info "creae"
    File.open(File.join(Rails.root, "a.xml"), "w"){|f| f.write(params) }
    #render text: ""
    logger.info "eche"
    render "echo", :formats => :xml
  end
  
  private
  def check_weixin_legality
    array = [ENV["weixin_token"], params[:xml][:timestamp], params[:xml][:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:xml][:signature] != Digest::SHA1.hexdigest(array.join)
    logger.info "success"
  end
end
