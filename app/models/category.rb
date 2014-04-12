class Category < ActiveRecord::Base
  has_many :factors
  has_many :statistics
end
