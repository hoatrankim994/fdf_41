class StaticPagesController < ApplicationController
  def home
    @products = Product.page(params[:page]).per(Settings.home.per_home)
  end
end
