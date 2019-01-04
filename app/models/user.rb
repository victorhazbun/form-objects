class User < ApplicationRecord

  has_many :social_networks

  accepts_nested_attributes_for :social_networks
end
