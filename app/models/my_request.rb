class MyRequest < ActiveRecord::Base
  attr_accessible :url

  has_many :feeds
end
