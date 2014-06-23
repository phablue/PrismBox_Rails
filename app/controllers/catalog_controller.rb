class CatalogController < ApplicationController
  skip_before_action :authorize

  def index
    @laptops = Laptop.all
  end
end
