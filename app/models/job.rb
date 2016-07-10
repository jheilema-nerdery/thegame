class Job < ActiveRecord::Base
  scope :oldest, ->{ order(:updated_at) }
  scope :newest, ->{ order(:updated_at => :desc) }

  def self.build(target, item)
    create!(target: target, item_name: item)
  end
end
