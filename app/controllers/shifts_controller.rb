class ShiftsController < ApplicationController
    
    #This handles creation of shifts
    def create
        @shift = Shift.new(shift_params)
        @shift.shift_time = DateTime.strptime(params[:shift_date] + " " + params[:time], "%m/%d/%Y %H:%M")
        @shift.save
        params[:ones].to_i.times do OneUserShift.create(:user_id => 1, :shift_id => @shift.id) end
        params[:twos].to_i.times do TwoUserShift.create(:user_id => 1, :shift_id => @shift.id) end
        params[:volunteers].to_i.times do VolUserShift.create(:user_id => 1, :shift_id => @shift.id) end
        
        @shifts = Shift.select { |shift| shift.shift_time > Time.now }.sort_by!{ |shift| shift.shift_time }
        
        respond_to do |format|
            format.html 
            format.json
            format.js
        end
    end
    
    #This creates a chronological index of future shifts
    def index
        @shifts = Shift.select { |shift| shift.shift_time > Time.now }.sort_by!{ |shift| shift.shift_time }
        @shift = Shift.new
        
        respond_to do |format|
            format.html # index.html.erb
            format.json
            format.js 
        end
    end
    
    #This creates a chronological index of past shifts
    def archive
        @shifts = Shift.select { |shift| shift.shift_time < Time.now }.sort_by!{ |shift| shift.shift_time }
    end
    
    #This handles assigning a number one to a shift
    def assign_one
        @one_position = OneUserShift.find_by_id(params[:id])
        if params[:name] == 'None'
            @one_position.update_attribute(:user_id, 1)
        else
            name = params[:name].split(" ")
            @user = User.where(:first => name[0], :last => name[1]).first
            @one_position.update_attribute(:user_id, @user.id)
        end
    end
    
    #This handles assigning a number two to a shift
    def assign_two
        @two_position = TwoUserShift.find_by_id(params[:id])
        if params[:name] == 'None'
            @two_position.update_attribute(:user_id, 1)
        else
            name = params[:name].split(" ")
            @user = User.where(:first => name[0], :last => name[1]).first
            @two_position.update_attribute(:user_id, @user.id)
        end
    end
    
    #This handles assigning a volunteer to a shift
    def assign_volunteer
        @volunteer_position = VolUserShift.find_by_id(params[:id])
        if params[:name] == 'None'
            @volunteer_position.update_attribute(:user_id, 1)
        else
            name = params[:name].split(" ")
            @user = User.where(:first => name[0], :last => name[1]).first
            @volunteer_position.update_attribute(:user_id, @user.id)
        end
    end
    
    #This handles destroying shifts
    def destroy
        @shift = Shift.find(params[:id])
        @shift.destroy

        respond_to do |format|
            format.html
            format.json { head :no_content }
            format.js   { render :layout => false }
        end
    end
    
    #This renders a json object for venue autocomplete
    def shifts_venue_autocomplete
        @venues = Shift.all.map(&:venue_name).uniq
        respond_to do |format|
            format.json { render :json => @venues.to_json }
        end
    end
    
    #This renders a json object for event autocomplete
    def shifts_event_autocomplete
        @events = Shift.all.map(&:event).uniq
        respond_to do |format|
            format.json { render :json => @events.to_json }
        end
    end
    
    private
    def shift_params
        params.require(:shift).permit(:venue_name, :event)
    end
end
