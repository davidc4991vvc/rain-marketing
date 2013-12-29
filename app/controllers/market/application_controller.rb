class Market::ApplicationController < ApplicationController
  before_filter :authenticate_user!
  layout 'market'
end