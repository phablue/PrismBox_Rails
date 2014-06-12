class CatalogController < ApplicationController
  def index
    @laptops = Laptop.all
  end
end
