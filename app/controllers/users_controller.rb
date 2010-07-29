class UsersController < ApplicationController
  
  before_filter :require_user, :except => [:index, :new, :activate, :create, :forgot, :reset]
  before_filter :require_admin, :only => [:suspend, :unsuspend, :purge]
  before_filter :find_user, :except => [:index, :new, :create, :activate, :forgot, :reset]
  
  def index
    @users = User.find(:all, :order => "full_name, login")
  end
 
  def show
  end
 
  def edit
    use_tinymce
  end
 
  def update
    if current_user_is_admin?
      @user.is_admin = (params[:user][:is_admin] == '1')
      @user.save!
    end
    if params[:user][:image]
      @user.save_image_file(params[:user][:image])
    end
    @user.update_attributes(params[:user])
    redirect_to(edit_user_path(@user.id)) 
  end
 
  def new
#    redirect_to(edit_user_path(current_user)) and return false if logged_in?
    use_tinymce
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error] = "We couldn't set up that account, sorry.  Please try again."
      render :action => 'new'
    end
  end
  
  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user
        user.create_reset_code
        notice_message("Reset code sent to #{user.email}.")
      else
        notice_message("#{params[:user][:email]} does not exist in system.")
      end
      redirect_to(root_url)
    end
  end

  def reset
    @user = User.find_by_activation_code(params[:code]) if params[:code] 
    @user = current_user unless @user
    unless @user
      alert_message("No user present.")
      redirect_to(root_path) and return false 
    end
    if request.post?
      if @user.update_attributes(
          :password => params[:user][:password], 
          :password_confirmation => params[:user][:password_confirmation]
        )
        self.current_user = @user
        @user.delete_reset_code
        flash[:notice] = "Password reset successfully for #{@user.email}"
        redirect_back_or_default('/')
      end
    end
  end

#  def suspend
#    @user.suspend! 
#    redirect_to users_path
#  end

#  def unsuspend
#    @user.unsuspend! 
#    redirect_to users_path
#  end

  def destroy
    @user.delete!
    notice_message("Successfully destroyed your account and all of your books, chapters, comments and notifications.")
    redirect_to root_path
  end

#  def purge
#    @user.destroy
#    redirect_to root_path
#  end
  
  def admin_bootstrap
    if 0 == User.admins.size
      current_user.is_admin = true
      if current_user.save!
        notice_message("Successfully made you the first admin.")
      else
        error_message *(["An error occurred: "] + current_user.errors.full_messages)
      end
    else 
      error_message("The primary admin already exists.")
    end
    redirect_to(root_path)
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected

#  def authorized?(action = action_name, user = nil)
#    logged_in? and (current_user_is_admin? or current_user == @user)
#  end
    
  def find_user
    if current_user_is_admin? 
      @user = User.find(params[:id])
    else 
      @user = current_user
    end
    unless @user
      error_message("Can't find requested user.")
      redirect_to(users_path)
    end
  end
  
end
