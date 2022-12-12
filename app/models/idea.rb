class Idea < ActiveRecord::Base
    belongs_to :topic
    belongs_to :user
    has_many :likes, :dependent => :destroy

    def likes_count
        self.likes.count
    end

    def liked_by
        res = []
        self.likes.each {|i| res << i.user_id}
        res
    end

    def author
        self.user.name
    end

    def liked?
        likes_count > 0
    end

    def topic_title
        self.topic.title
    end

end