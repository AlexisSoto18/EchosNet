class TweeetsController < ApplicationController
  before_action :set_tweeet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]


  # GET /tweeets or /tweeets.json
  def index
    @tweeets = Tweeet.all
    if user_signed_in?
      # Obtener los IDs de los usuarios que el usuario actual sigue
      followed_user_ids = current_user.followed_users.pluck(:id)

      # Obtener los tweets de los usuarios que sigue el usuario actual, incluyendo los suyos

      @tweeets = Tweeet.left_joins(:retweets).where(retweets: { user_id: followed_user_ids + [ current_user.id ] }).or(Tweeet.where(user_id: followed_user_ids + [ current_user.id ])).distinct.order(created_at: :desc)

      # Obtener una lista de usuarios sugeridos para seguir
      @users_to_follow = User.where.not(id: followed_user_ids + [ current_user.id ]).limit(5)
    else
      # Si el usuario no está autenticado, no mostrar ningún tweet ni sugerencias
      @tweeets = Tweeet.none
      @users_to_follow = User.none
    end
    @tweeet = Tweeet.new
  end

  def following
    @following = current_user.followed_users
  end

  def followers
    @followers = current_user.followers
  end


  # GET /tweeets/1 or /tweeets/1.json
  def show
  end

  # GET /tweeets/new
  def new
    @tweeet = current_user.tweeets.build
  end

  # GET /tweeets/1/edit
  def edit
  end

  # POST /tweeets or /tweeets.json
  def create
    @tweeet = current_user.tweeets.build(tweeet_params)

    respond_to do |format|
      if @tweeet.save
        format.html { redirect_to root_path, notice: "Tweeet was successfully created." }
        format.json { render :show, status: :created, location: @tweeet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweeets/1 or /tweeets/1.json
  def update
    respond_to do |format|
      if @tweeet.update(tweeet_params)
        format.html { redirect_to @tweeet, notice: "Tweeet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweeet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweeets/1 or /tweeets/1.json
  def destroy
    @tweeet.destroy!

    respond_to do |format|
      format.html { redirect_to tweeets_path, status: :see_other, notice: "Tweeet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeet
      @tweeet = Tweeet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweeet_params
      params.require(:tweeet).permit(:tweeet, :image)
    end
end
