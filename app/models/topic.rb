class Topic < ActiveRecord::Base
    belongs_to :user
    has_many :ideas
    has_many :likes, through: :ideas

    def ideas_count
       self.ideas.count
    end

    def closed_on
        if !open
            updated_at
        end 
    end

    def winner
        Idea.find(winner_idea).body
    end

    def author
        self.user.name
    end

    
end