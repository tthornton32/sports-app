class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authorized?, only: [:index]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def home
  end

  def comment
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @comments = @user.comments.order('created_at desc')
    @new_comment = Comment.new(user_id: @user.id)
    @commenter = current_user

   @games = Game.all
    @hash = Gmaps4rails.build_markers(@games) do |game, marker|
      marker.lat game.latitude
      marker.lng game.longitude
      marker.infowindow render_to_string(:partial => "layouts/window", :locals => { :object => game})
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:cellphone)
  end

    def authorized?
      unless current_user.admin == true
        flash[:error] = "You are not authorized to view that page."
        redirect_to root_path
      end
    end
end
