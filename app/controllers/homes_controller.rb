class HomesController < ApplicationController

  # GET /homes
  def index
    @homes = Home.all
  end

  private
    
end
