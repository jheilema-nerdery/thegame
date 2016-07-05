require 'spec_helper'
require 'the_game/holding_pattern'

describe TheGame::HoldingPattern do
  it "needs a url to initialize" do
    expect { TheGame::HoldingPattern.new }.to raise_error(ArgumentError)
  end
end
