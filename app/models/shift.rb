class Shift < ActiveRecord::Base
    validates_presence_of :event
    validates_presence_of :venue_name

    has_many :one_user_shifts, dependent: :destroy
    has_many :ones, through: :one_user_shifts, class_name: 'User'
    
    has_many :two_user_shifts, dependent: :destroy
    has_many :twos, through: :two_user_shifts, class_name: 'User'
    
    has_many :vol_user_shifts, dependent: :destroy
    has_many :volunteers, through: :vol_user_shifts, class_name: 'User'
    
    def status
        final_class = "completed"
        self.volunteers.each do |volunteer|
            if volunteer.id == 1 then final_class = "pending" end
        end
        self.ones.each do |one|
            if one.id == 1 then return "failed" end
        end
        self.twos.each do |two|
            if two.id == 1 then return "failed" end
        end
        final_class
    end
end
