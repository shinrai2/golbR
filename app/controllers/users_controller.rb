class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # debugger
    unless !!current_user && current_user.activated?
      flash[:info] = "Please check after login."
      redirect_to root_url and return
    end
    @posts = @user.posts.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # log_in @user
        # flash[:success] = 'User was successfully created.'
        # format.html { redirect_to @user }
        # format.json { render :show, status: :created, location: @user }
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        format.html { redirect_to root_url }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to @user }
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
    flash[:success] = 'User was successfully destroyed.'
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # 确保是正确的用户
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:warning] = "Only can set your own information."
        redirect_to current_user
      end
    end

    # 确保是管理员
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
