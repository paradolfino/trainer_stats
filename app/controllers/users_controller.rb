class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :require_admin, only: [:new, :index]
    
    def index
        @users = User.all
        @title = "Users"
    end
    
    def new
        @user = User.new
        @title = "New User"
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            create_event("created", "user: #{@user.role} #{@user.name}")
            redirect_to '/'
        end
    end
    
    def edit
        require_same_user(@user)
        @title = "Edit User"
    end
    
    def update
        if params[:user][:password].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end
        if @user.update(user_params)
            create_event("updated", "user: #{@user.name}")
            flash[:notice] = "User #{@user.name} has been updated!" 
            redirect_to '/admin/users'
        else
            flash[:alert] = "There were errors when attempting to update, please review before submitting."
            render 'edit'
        end
    end
    
    def destroy
        require_same_user(@user)
        create_event("destroyed", "user: #{@user.name}")
        flash[:notice] = "#{@user.name} has been deleted."
        @user.destroy
        redirect_to '/admin/users'
    end
    
    private
    
        def set_user
           @user = User.find(params[:id]) 
        end
    
        def user_params
           params.require(:user).permit(:name, :email, :password, :password_confirmation, :role) 
        end
end