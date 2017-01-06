class TwoUserShift < ActiveRecord::Base
    belongs_to :two, class_name: 'User', foreign_key: 'user_id'
    belongs_to :two_shift, class_name: 'Shift', foreign_key: 'shift_id'
end
