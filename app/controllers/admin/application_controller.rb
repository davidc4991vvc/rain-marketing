class Admin::ApplicationController < ApplicationController
  include AdminHelper

  before_filter :authenticate_user!
  layout 'admin'
end