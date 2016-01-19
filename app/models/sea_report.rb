class SeaReport < ActiveRecord::Base

  belongs_to :sea_port
  has_many :passage_plans
  has_many :operating_conditions
end
