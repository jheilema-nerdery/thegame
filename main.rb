require 'rubygems'
require 'json'
require 'curb'
require './itemdothings'
require './fileReadAndClearer'

# /items/use/{itemid}?target={target-userid}
# You found a bonus item! <f160599a-8d17-4b7f-b923-03866b5d3ed5> | <Roger Wilco>


API_KEY = '***REMOVED***'

counter = 50
item_counter = 0

Thread.new do
  loop do
    exit if gets.chomp == 'q'
  end
end


loop do
  begin
    http = Curl.post("http://thegame.nerderylabs.com/points") do |http|
      http.headers['apikey'] = API_KEY
    end

    open('log', 'a') do |f|
      f.puts http.body_str
    end

    result = JSON.parse(http.body_str, symbolize_names: true)

    unless result[:Item].nil?
      ItemThingDoer.new(result[:Item]).save
      last_item = result[:Item]
      puts http.body_str
    end

    counter += 1

    if counter == 60
      item = FileReadAndClearer.new('items.list').get[item_counter]
      result = ItemThingDoer.new(item).do

      open('log', 'a') do |f|
        f.puts result
      end
      puts result
      item_counter += 1
      puts "********* Item counter: #{item_counter}"
      counter = 0

      if result.is_a? String
        puts "====== trying another ===================="
        item = FileReadAndClearer.new('items.list').get[item_counter]
        result = ItemThingDoer.new(item).do

        open('log', 'a') do |f|
          f.puts result
        end
        puts result
        item_counter += 1
        puts "********* Item counter: #{item_counter}"
      end
    end

    sleep 1
  rescue Curl::Err::RecvError
    open('log', 'a') do |f|
      f.puts 'Rescuing from a timeout'
    end
    puts 'Rescuing from a timeout'
    sleep 120
  end
end


