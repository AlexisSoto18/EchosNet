class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Encuentra el tweet original
    original_tweeet = Tweeet.find(params[:tweeet_id])

    # Crea el retweet, asociándolo al usuario actual
    @retweet = Retweet.new(user: current_user, tweeet: original_tweeet)

    if @retweet.save
      redirect_to root_path, notice: "Retecho realizado correctamente"
    else
      redirect_to root_path, alert: "Hubo un error al hacer el retecho"
    end
  end
end
