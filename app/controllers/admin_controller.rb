class AdminController < ApplicationController
  skip_before_action :authorize
end
