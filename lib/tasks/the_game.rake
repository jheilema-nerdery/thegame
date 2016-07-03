namespace :the_game do
  desc "Do things"
  task points: :environment do

    # /items/use/{itemid}?target={target-userid}
    # You found a bonus item!
    # <f160599a-8d17-4b7f-b923-03866b5d3ed5> | <Roger Wilco>
    # <f8e87c0a-5d8b-447c-96c2-6f08df974353> | <Space Invaders>
    # <c4ea419c-88a7-4f99-a8e8-576cfcf5ca67> | <Hard Knuckle>
    # <dafdd972-bfe8-4d43-95b4-21042a761d98> | <Da Da Da Da Daaa Da DAA da da>
    # <10db30ce-bbd6-4f4c-8012-93d63a44feed> | <Hard Knuckle>
    # <68fb2207-aaf7-4f88-934f-a5471466c143> | <Charizard>
    # <d8f22fe6-d928-4ed1-95b9-eee72a785518> | <Bo Jackson>
    # <d4fcb5e5-e63c-44c8-b673-4c9b710c678f> | <Bo Jackson>
    # <e7140cfd-291a-42fc-8840-7edb2ca786d8> | <Hard Knuckle>
    # <34a56dca-f5b4-408b-bd54-364f16c6ddc3> | <UUDDLRLRBA>


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
        api = TheGame::Api.new(Rails.logger, API_KEY)
        points = api.post_points

        unless points[:Item].nil?
          TheGame::ItemThingDoer.new(points[:Item]).save
        end
        puts points

        counter += 1

        if counter == 60
          item = TheGame::FileReadAndClearer.new('tmp/items.list').get[item_counter]
          result = TheGame::ItemThingDoer.new(item).do

          open('log/main.log', 'a') do |f|
            f.puts result
          end
          puts result
          item_counter += 1
          puts "********* Item counter: #{item_counter}"
          counter = 0

          if result.is_a? String
            puts "====== trying another ===================="
            item = TheGame::FileReadAndClearer.new('tmp/items.list').get[item_counter]
            result = TheGame::ItemThingDoer.new(item).do

            open('log/main.log', 'a') do |f|
              f.puts result
            end
            puts result
            item_counter += 1
            puts "********* Item counter: #{item_counter}"
          end
        end

        sleep 1
      rescue Curl::Err::RecvError
        open('log/main.log', 'a') do |f|
          f.puts 'Rescuing from a timeout'
        end
        puts 'Rescuing from a timeout'
        sleep 120
      end
    end

  end

end
