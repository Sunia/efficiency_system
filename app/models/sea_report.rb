class SeaReport < ActiveRecord::Base

  belongs_to :sea_port
  has_many :passage_plans
end
