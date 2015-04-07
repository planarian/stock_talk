require "#{Rails.root}/app/models/twitter"

desc "This task is called by the Heroku scheduler add-on"
task :query_twitter => :environment do
    Company.each { |co| RetrieveTweets.get(co) }
  end


desc "This task is called by the Heroku scheduler add-on"
task :consolidate => :environment do
  Company.all.each do |company|
    print "Consolidating totals for #{company.name}..."
    company.consolidate
    print "done"
  end 
end