class JoinRequestsController < ApplicationController

    #This renders the form page form making a new join request
    def new
        @join_request = JoinRequest.new
        @failed = false
    end

    #This creates the join request upon form submission
    def create
        @join_request = JoinRequest.new(join_request_params)
        if @join_request.save
            redirect_to '/join_request_success'
        else
            @failed = true;
            render :action => 'new'
        end
    end

    #This provides separate indexes for processed and pending join requests
    def index
        @pending_join_requests = JoinRequest.select { |join_request| join_request.approved == nil }
        @processed_join_requests = JoinRequest.select { |join_request| join_request.approved != nil }.reverse!
    end

    #This handles accepting of join requests
    def accept
        @join_request = JoinRequest.find_by_id(params[:id])
        @join_request.update_attribute(:approved,true)
        #add email logic
        respond_to do |format|
            format.js
        end
    end

    def form_complete
    end

    #This handles rejecting of join requests
    def reject
        @join_request = JoinRequest.find_by_id(params[:id])
        @join_request.update_attribute(:approved,false)
        #add email logic
        respond_to do |format|
            format.js
        end
    end

    private
    def join_request_params
        params.require(:join_request).permit(:first,:last,:student_id,:email,:grad_year, :major, :career_goal, :cert_source, :emt_number, :emt_exp_date, :cpr_exp_date, :nremt_number, :other_certs, :none, :ma_ambulance, :ma_fire, :fire_ambulance, :other_experience, :other_info)
    end
end
