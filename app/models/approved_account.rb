class ApprovedAccount < ActiveRecord::Base
    validates :email, :uniqueness => true
end
