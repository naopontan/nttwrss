class Feed < ActiveRecord::Base
  belongs_to :my_request
  attr_accessible :content, :description, :link, :pub_date, :title
end
