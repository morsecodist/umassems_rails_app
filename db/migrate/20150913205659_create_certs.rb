class CreateCerts < ActiveRecord::Migration
  def change
      User.all.each do |user|
          Certificate.create(:cert_type => "CPR", :user_id => user.id)
          Certificate.create(:cert_type => "Driver's License", :user_id => user.id)
          Certificate.create(:cert_type => "MA EMT", :user_id => user.id)
          Certificate.create(:cert_type => "NREMT", :user_id => user.id)
      end
  end
end
