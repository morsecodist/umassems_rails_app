class AddTeamToApprovedAccounts < ActiveRecord::Migration
  def change
    add_column :approved_accounts, :division, :string
    add_column :users, :division, :string
    add_column :users, :phone_number, :string
  end
end
