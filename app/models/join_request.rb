class JoinRequest < ActiveRecord::Base
    validates_presence_of :first, :message => "Missing First Name"
    
    def status
        if self.approved == nil
            return "pending"
        elsif self.approved
            return "completed"
        else
            return "failed"
        end
    end
end
