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
    # <0657381f-a9cf-4fc6-bc80-f3fc38e1e8e3> | <UUDDLRLRBA>
    # <6cfda964-3bdb-4dc2-a10c-28127c8064ad> | <UUDDLRLRBA>
    # <352f0202-01de-4769-909e-c16b1a805d2c> | <Space Invaders>
    # <efb9fe33-19f1-4128-ac61-a9d1e7354312> | <Charizard>
    # <285016de-0324-4e75-a3da-3db8f5c36d79> | <Pizza>
    # <39fa40d9-3c5c-4b2e-8f0f-a740cb05aae9> | <Red Shell>
    # <7344337f-a1d3-4ed3-a672-8a282045a374> | <Bo Jackson>
    # <d207324e-cdf8-413d-a630-3824b7fdb548> | <Banana Peel>
    # <b3023897-aec2-41df-b08b-c42119b97692> | <Red Shell>
    # <d321cb18-bed9-481e-b5fc-4c51015c85c1> | <Red Shell>
    # <34a56dca-f5b4-408b-bd54-364f16c6ddc3> | <UUDDLRLRBA>
    # <c7752d40-d33a-4f71-b84d-3c8a3246f17c> | <Wedge>
    # <0cc7d989-f52e-4a91-b761-2ca91847e85f> | <Moogle>
    # <c3e23d35-9931-40cb-9d0d-d57aac571019> | <Crowbar>
    # <dc06622c-f711-4687-bc2d-8c8eec2fbab5> | <Leeroy Jenkins>
    # <5d5e750e-5459-4fea-bd4c-2e40adfc5b4a> | <UUDDLRLRBA>
    # <5806a782-191e-4287-8817-afa77a2326bc> | <Space Invaders>
    # <f7164e88-ac98-4732-9628-1e5b88d75539> | <Cardboard Box>
    # <64c927be-65f9-4118-8218-8560812021c3> | <Box of Bees>
    # <0bd1f2b3-62b6-4969-ae3d-a1bfe19294d1> | <Skinny Guys>
    # <06f15394-4633-4369-8d10-ebbcb4830bed> | <UUDDLRLRBA>
    # <d8f22fe6-d928-4ed1-95b9-eee72a785518> | <Bo Jackson>
    # <d4fcb5e5-e63c-44c8-b673-4c9b710c678f> | <Bo Jackson>
    # <e7140cfd-291a-42fc-8840-7edb2ca786d8> | <Hard Knuckle>
    # <34a56dca-f5b4-408b-bd54-364f16c6ddc3> | <UUDDLRLRBA>
    # <1988a4e8-8486-4005-8e83-d0e9504c6c87> | <Holy Water>
    #
    # '***REMOVED***'


    API_KEY = ENV["API_KEY"] or raise 'set your api key!'
    Rails.logger.level = 0
    api = TheGame::Api.new(Rails.logger, API_KEY)

    counter = 40

    Thread.new do
      loop do
        exit if gets.chomp == 'q'
      end
    end

    loop do
      begin
        points = api.points

        unless points[:Item].nil?
          Item.from_json(points[:Item]).save
        end

        counter += 1

        if counter == 60
          Rails.logger.info "====== using an item ========"

          counter = 0

          item = Item.oldest.unused.first
          result = TheGame::ItemThingDoer.new(item, api).do
          Rails.logger.info result

          if result.is_a? String
            Rails.logger.info "====== trying another ========"
            item = Item.oldest.unused.first
            result = TheGame::ItemThingDoer.new(item, api).do

            Rails.logger.info result
          end
        end

        sleep 1
      rescue Curl::Err::RecvError
        Rails.logger.error "*"*20 + '  Rescuing from a timeout  ' + "*"*20
        sleep 120
      end
    end

  end

end
