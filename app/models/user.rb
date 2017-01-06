class User < ActiveRecord::Base
    has_secure_password
    has_many :shift, through: :position
    
    has_attached_file :photo,
    :path => ":rails_root/app/assets/images/profile_photos/:id/:style/:basename.:extension",
    :url => "profile_photos/:id/:style/:basename.:extension",
    :styles => {
        standardized: "230x300#"
    },
    :default_url => "profile_photos/:style/default.png"
    
    validates_attachment_size :photo, :less_than => 5.megabytes
    validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
    
    has_many :one_user_shifts
    has_many :one_shifts, through: :one_user_shifts, class_name: 'Shift'
    
    has_many :two_user_shifts
    has_many :two_shifts, through: :two_user_shifts, class_name: 'Shift'
    
    has_many :vol_user_shifts
    has_many :volunteer_shifts, through: :vol_user_shifts, class_name: 'Shift'
    
    has_many :certificates
end
