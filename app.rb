require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "dotenv/load"

get("/") do

  exchange_rate_url= "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_RATE_KEY")

  raw_response= HTTP.get(exchange_rate_url).to_s

  parsed_response= JSON.parse(raw_response)

  @currencies = parsed_response.fetch("currencies").keys

  erb(:homepage)
end

get("/:base_currency") do

  exchange_rate_url= "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_RATE_KEY")

  raw_response= HTTP.get(exchange_rate_url).to_s

  parsed_response= JSON.parse(raw_response)

  @currencies = parsed_response.fetch("currencies").keys
  
  @base_currency= params.fetch("base_currency").to_s

  erb(:flexible)
end 

get("/:base_currency/:result_currency") do

  @base_currency= params.fetch("base_currency").to_s

  @result_currency = params.fetch("result_currency").to_s

  exchange_rate_url= "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}&from=#{@base_currency}&to=#{@result_currency}&amount=1"

  raw_response= HTTP.get(exchange_rate_url).to_s

  parsed_response= JSON.parse(raw_response)

  @result = parsed_response.fetch("result").to_s

  erb(:flexible2)
end 
