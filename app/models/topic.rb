class Topic < ActiveRecord::Base
    belongs_to :user
    has_many :ideas
    has_many :likes, through: :ideas
end