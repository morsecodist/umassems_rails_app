class VolUserShift < ActiveRecord::Base
    belongs_to :volunteer, class_name: 'User', foreign_key: 'user_id'
    belongs_to :volunteer_shift, class_name: 'Shift', foreign_key: 'shift_id'
end
