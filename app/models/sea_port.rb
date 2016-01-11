class SeaPort < ActiveRecord::Base
  has_many :sea_reports
  has_many :passage_plans
end
