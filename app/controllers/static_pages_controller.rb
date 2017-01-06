class StaticPagesController < ApplicationController

    #Renders home page
    def home
    end

    #Renders about page
    def about_info
    end

    #Renders cpr info page
    def cpr_info
    end

    #Renders the class info, handles the automatic season update of the open/close announcement
    def class_info
        @openclose = StaticContent.find_by_sc_key('class-open')
        switcher = @openclose.sc_value
        today = Time.now
        year = today.year.to_s
        if(today.month >= 7 && today.month <=11)
            season = 'Fall'
        elsif(today.month > 11 || today.month <= 4)
            year = (today.year).to_s
            season = 'Spring'
        else
            season = 'Summer'
        end
        @openclosemessage = "Registration for the " + season + " " + year + " EMT class is now " + switcher + "."
    end

    #Gets the current staff and renders the staff info page
    def staff_info
      @eduser = User.where('role LIKE ?', "executive_director").first
      @douser = User.where('role LIKE ?', "operations_director").first
      @dfuser = User.where('role LIKE ?', "finance_director").first
      @dauser = User.where('role LIKE ?', "administration_director").first
      @dtuser = User.where('role LIKE ?', "training_director").first
      @paruser = User.where('role LIKE ?', "parliamentarian").first
      @itluser = User.where('role LIKE ?', "training_liaison").first
      @cpruser = User.where('role LIKE ?', "cpr_chair").first
      @emscuser = User.where('role LIKE ?', "ems_coordinator").first
      @ituser = User.where('role LIKE ?', "master").first
    end

    #Renders website info page
    def website_info
    end

    #Renders join info page
    def join_info
    end

    #Renders itl page and shows class open/close status
    def itl
        @openclose = StaticContent.find_by_sc_key('class-open')
    end

    #Handles toggling the class open/close status
    def classtoggle
        @openclose = StaticContent.find_by_sc_key('class-open')
        if @openclose.sc_value == 'closed' then @openclose.sc_value = 'open' else @openclose.sc_value = 'closed' end
        if @openclose.save
            flash[:notice] = 'Regestration is now open.'
        else
            flash[:notice] = 'There is an error, email Todd.'
        end
        redirect_to '/class_info'
    end

    #Handles downloading of class registration form
    def download_registration_form
        send_file(
            "#{Rails.root}/public/Forms/Registration_Form.pdf",
            filename: "Registration Form.pdf",
            type: "application/pdf"
            )
    end

    #Handles downloading of charter
    def download_charter
        send_file(
            "#{Rails.root}/public/Forms/Charter.pdf",
            filename: "UmassEMS Charter.pdf",
            type: "application/pdf"
            )
    end

    #Handles downloading CPR schedule
    def download_cpr_schedule
      send_file(
          "#{Rails.root}/public/Documents/CPR_Schedule_Spring_2016.docx",
          filename: "UmassEMS CPR Schedule Spring 2016.docx",
          type: "application/msword"
          )
    end
end
