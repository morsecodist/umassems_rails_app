class OneUserShift < ActiveRecord::Base
    belongs_to :one, class_name: 'User', foreign_key: 'user_id'
    belongs_to :one_shift, class_name: 'Shift', foreign_key: 'shift_id'
end
