require 'spec_helper'
require 'the_game/chillax'

describe TheGame::Chillax do
  let(:strategy) { TheGame::Chillax.new(nil, nil) }

  it 'what was I saying' do
    expect(strategy.time_to_wait).to be_an(Integer)
  end

  it 'chills' do
    expect(strategy.choose_item_and_player([], [])).to eql([])
  end
end
