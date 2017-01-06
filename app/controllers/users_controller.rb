class UsersController < ApplicationController

    #Renders page to make a new user
    def new
    end

    #Handles creation of new users upon valid submit
    def create
      user = User.new(user_params)
      approved = ApprovedAccount.find_by_email(user.email)
        if approved
            user = User.new(user_params)
            user.bio = "No bio yet."
            user.division = approved.division
            if user.save
                session[:user_id] = user.id
                approved.destroy
                redirect_to '/'
            else
                redirect_to '/member_portal/signup'
            end
        else
            flash[:notice] = 'Account is not approved for creation.'
            redirect_to '/member_portal/users/signup'
        end
    end

    #Shows the profile page for a user
    def show
        user = current_user
        url_id = request.fullpath.sub('/member_portal/users/', '')
        redirect_to user_page_path(user.id) unless (url_id == current_user.id.to_s)
        @user = User.find_by_id(params[:id])
        @shifts = @user.one_shifts.select { |shift| shift.shift_time > Time.now }.sort_by!{ |shift| shift.shift_time }
    end

    #Shows the shifts for standard users
    #Not in shifts because one day it will be customized based on user preference
    def shifts
        user = current_user
        url_id = request.fullpath.sub('/member_portal/users/', '')
        url_id = url_id.sub('/shifts','')
        redirect_to user_shifts_path(user.id) unless (url_id == user.id.to_s)
        @shifts = Shift.select { |shift| shift.shift_time > Time.now }.sort_by!{ |shift| shift.shift_time }
        @weeks = Array.new
        if @shifts.size == 0
          weekNum = 0
        else
          weekNum = (((@shifts.last.shift_time.to_date - Date.today) / 7)).ceil + 1
        end
        weekNum.times do |n|
            @weeks[n] = Date.today + (7 * n)
        end
    end

    #Shows an index of a user's certs
    def certs
        user = current_user
        url_id = request.fullpath.sub('/member_portal/users/', '')
        url_id = url_id.sub('/certs','')
        redirect_to user_certs_path(user.id) unless (url_id == user.id.to_s)
        @certificates = User.find_by_id(params[:id]).certificates
    end

    #Handles updating a bio
    def update_bio
        user = User.find_by_id(params[:id])
        user.update_attribute(:bio,params[:bio])
        @user = user
    end

    #This shows account settings, which is currently only updating the password
    def account_settings
      @user = User.find_by_id(params[:id])
    end

    #This handles updating a user's password
    def update_password
      user = User.find_by_id(params[:id])
      if user.authenticate(params[:old_password])
        user.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
        flash[:success] = 'Password Change Successful'
        redirect_to account_settings_path(user.id)
      else
        flash[:notice] = 'Password Change Failed'
        redirect_to account_settings_path(user.id)
      end
    end

    #Handles updating a photo
    def update_photo
        @user = User.find_by_id(params[:id])
        if @user.update_attributes(user_photo_params)
            redirect_to user_page_path(params[:id])

        else
            redirect_to update_user_path(params[:id])
        end
    end

    #Not sure what this does
    def edit
        @user = User.find_by_id(params[:id])
    end

    #Renders json object for user based autocompletes
    def user_names_autocomplete
        @users = User.select { |user| user.first && user.last }
        @names = @users.map {|user| user.first + ' ' + user.last}
        @names.push('None')
        respond_to do |format|
            format.json { render :json => @names.to_json }
        end
    end

    private
    def user_params
        params.require(:user).permit(:first,:last,:mass_number, :email, :password, :password_confirmation, :phone_number)
    end

    def user_photo_params
        params.require(:user).permit(:photo)
    end
end
