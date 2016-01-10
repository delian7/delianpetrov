desc "Pings PING_URL to keep a dyno alive"
  task :dyno_ping do
    require "net/http"

    if ENV['PING_URL'] && !Time.now.hour.between?(0,4) #don't run this between 12:00am - 4:00am
      uri = URI(ENV['PING_URL'])
      Net::HTTP.get_response(uri)
    end
  end
