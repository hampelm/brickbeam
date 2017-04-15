require 'csv'
namespace :contractors do
  task :import => :environment do
    csv_text = File.read('data/contractors.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      contractor = row.to_hash
      contractor.delete('fields')
      contractor['approved'] = true
      begin
        Contractor.create!(contractor)
      rescue 
        puts "Couldn't create contractor #{contractor.to_s}"
      end
    end
  end
end 
