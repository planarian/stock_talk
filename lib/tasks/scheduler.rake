desc "This task is called by the Heroku scheduler add-on"
task :query_twitter => :environment do
    RetrieveTweets.get_all
  end


desc "This task is called by the Heroku scheduler add-on"
task :daily => :environment do
  Day.add(1)
  RetrieveQuotes.get_yesterday
end