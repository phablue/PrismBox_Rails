class CatalogController < ApplicationController
  skip_before_action :authorize

  def index
    if !(current_user.admin)
      @laptops = Laptop.where(state: "STOCKS")
    else
      @laptops = Laptop.all
    end
  end
end
