class Market::ApplicationController < ApplicationController
  include MarketHelper
  before_filter :authenticate_user!
  before_filter :load_market_site
  layout 'market'

  def load_market_site
    #'添加网站'不需要验证
    unless params[:controller] == 'market_sites' && ['new', 'create'].include?(params[:action])
      if session[:market_site_id].nil?
        redirect_to "/choose_site" and return
      end
      @market_site = Market::Site.find_by(id: session[:market_site_id])
      if @market_site.nil?
        redirect_to "/choose_site" and return
      end
    end
  end
end