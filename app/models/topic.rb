class Topic < ActiveRecord::Base
    belongs_to :user
    has_many :ideas, :dependent => :destroy
    has_many :likes, through: :ideas

    def ideas_count
       self.ideas.count
    end

    def closed_on
        self.updated_at
    end

    def winner
        Idea.find(winner_idea).body
    end

    def author
        self.user.name
    end

    def winner_author
        Idea.find(winner_idea).author
    end

    def winner_likes
        Idea.find(winner_idea).likes_count
    end

    
end