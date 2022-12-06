class Idea < ActiveRecord::Base
    belongs_to :topic
    belongs_to :user
    has_many :likes, :dependent => :destroy

    # const liked_by_current_user? = false;

    def likes_count
        self.likes.count
    end

    def liked_by
        res = []
        self.likes.each {|i| res << i.user_id}
        res
    end

    # def liked_by_user?(user)
    #     liked_by_current_user? = liked_by.include?(user)
    # end

    # def li?
    #     liked_by_current_user
    # end

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