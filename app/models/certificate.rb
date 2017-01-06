class Certificate < ActiveRecord::Base
    belongs_to :user
    
    has_attached_file :front,
    :path => ":rails_root/app/assets/images/certs/:id/front/:basename.:extension",
    :url => "certs/:id/front/:basename.:extension"
    
    has_attached_file :back,
    :path => ":rails_root/app/assets/images/certs/:id/back/:basename.:extension",
    :url => "certs/:id/back/:basename.:extension"
    
    validates_attachment_size :front, :less_than => 5.megabytes
    validates_attachment_content_type :front, :content_type => ['image/jpeg', 'image/png', 'image/pdf']
    
    validates_attachment_size :back, :less_than => 5.megabytes
    validates_attachment_content_type :back, :content_type => ['image/jpeg', 'image/png', 'image/pdf']
    
    def status
        return "failed" unless self.front_file_name && self.back_file_name
        return "failed" unless self.expiration_date
        if self.expiration_date < DateTime.now then return "failed" end
        return "pending" if self.approved == nil
        if self.approved then return "completed" else return "failed" end
    end
end
