class Job < ActiveRecord::Base
  scope :oldest, ->{ order(:updated_at) }
  scope :newest, ->{ order(:updated_at => :desc) }
end
