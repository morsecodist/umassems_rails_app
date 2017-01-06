class SessionsController < ApplicationController
    
    #This renders the login page for making a new session
    def new
        if current_user then redirect_to user_page_path(current_user.id) end
    end
    
    #This creates a session if login credentials are valid
    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to user_page_path(user.id)
            return
        elsif user && !user.authenticate(params[:password])
            flash[:notice] = 'Invalid Password'
        else
            flash[:notice] = 'Account does not exist.'
        end
        redirect_to '/member_portal/login'
    end
    
    #This destroys a session
    def destroy
        session[:user_id] = nil
        redirect_to '/'
    end
end
