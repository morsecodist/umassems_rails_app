class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session
    before_filter :prep_mobile

    def current_page
        @current_page ||= request.env['PATH_INFO']
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def executive_director?
        current_user.role == "executive_director" || current_user.role == 'master'
    end

    def ops_director?
        current_user.role == "operations_director" || current_user.role == 'master'
    end

    def admin_director?
        current_user.role == "administration_director" || current_user.role == 'master'
    end

    def training_liason?
        return false unless current_user
        current_user.role == 'training_liaison' || current_user.role == 'master'
    end

    def week_range(date)
        date.beginning_of_week(:sunday).strftime("%m/%d/%Y") + " - " + (date + 6 - ((date.wday) % 7)).strftime("%m/%d/%Y")
    end

    def mobile_device?
        request.user_agent =~ /Mobile|webOS/
    end

    def getrole(role)
      return "Executive Director" if(role == "executive_director")
      return "Director of Operations" if(role == "operations_director")
      return "Director of Finance" if(role == "finance_director")
      return "Director of Administration" if(role == "administration_director")
      return "Director of Training" if(role == "training_director")
      return "Parliamentarian" if(role == "parliamentarian")
      return "Initial Training Liaison" if(role == "training_liaison")
      return "CPR Chair" if(role == "cpr_chair")
      return "EMS Coordinator" if(role == "ems_coordinator")
      return "IT Specialist" if(role == "master")
      return ""
    end

    #FIX THIS! It's an absolute monstrosity
    def office_hours_bandaid(role)
      return ["Monday 3:30 - 4:30", "Tuesday 11:30 - 12:30"] if(role == "executive_director")
      return ["Thursday 3:00 - 5:00", ""] if(role == "operations_director")
      return ["Tuesday 11:30 - 12:30", "Wednesday 1:30 - 2:30"] if(role == "finance_director")
      return ["Monday 4:00 - 5:00", "Wednesday 4:00 - 5:00"] if(role == "administration_director")
      return ["Wednesday 1:00 - 2:00", "Thursday 3:30 - 4:30"] if(role == "training_director")
      return ["",""]
    end

    helper_method :current_page, :current_user, :executive_director?, :ops_director?, :admin_director?, :training_liason?, :week_range, :mobile_device?, :getrole, :office_hours_bandaid

    def authorize
        redirect_to 'member_portal/login' unless current_user
    end

    def require_master
        redirect_to '/' unless current_user.role == 'master'
    end

    def prep_mobile
        prepend_view_path "app/views/mobile" if mobile_device?
    end

end
