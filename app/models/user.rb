class User < ActiveRecord::Base
    has_many :topics
    has_many :ideas
    has_many :likes, through: :ideas
end