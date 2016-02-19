class SeaReport < ActiveRecord::Base

  belongs_to :sea_port
  has_many :passage_plans
  has_many :operating_conditions
  has_many :power_fuels
  has_many :weather_distances
end
