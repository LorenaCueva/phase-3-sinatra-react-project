class Idea < ActiveRecord::Base
    belongs_to :topic
    belongs_to :user
    has_many :likes

    def likes_count
        self.likes.count
    end

    def liked_by
        arr = []
        self.likes.each {|i| arr << i.user.name}
        arr
    end

end