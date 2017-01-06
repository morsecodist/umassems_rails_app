require 'csv'
namespace :db do

    task user_transfer: :environment do
        puts Dir.pwd
      CSV.foreach('users.csv', :headers => true) do |row|
          User.create!(row.to_hash)
      end
    end

    task content_transfer: :environment do
        puts Dir.pwd
        CSV.foreach('content.csv', :headers => true) do |row|
            StaticContent.create!(row.to_hash)
        end
    end
end
