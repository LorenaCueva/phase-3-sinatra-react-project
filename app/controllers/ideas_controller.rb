class IdeasController < Sinatra::Base

    get "/ideas/:user_id/have_likes" do
        res = []
        ideas = Idea.where("user_id = ?" , params[:user_id]).each do |i|
          if i.liked?
            res << i
          end
        end
        format_to_json(res)
    end

    get "/ideas/user/:user_id" do
        ideas = Idea.where("user_id = ?" , params[:user_id]).order(created_at: :desc)
        format_to_json(ideas)
    end
    
    get "/ideas/:topic_id" do
        ideas = Idea.where("topic_id = ?", params[:topic_id]).order(created_at: :desc)
        format_to_json(ideas)
    end
    
    post "/ideas/:topic_id" do
        idea = Idea.create(
          topic_id: params[:topic_id],
          body: params[:body],
          user_id: params[:user_id],
        )
        Like.create(
            idea_id: idea.id,
            user_id: idea.user_id
        )
        newIdea = Idea.find(idea.id)
        format_to_json(newIdea)
    end
    
    get "/idea/:id" do
        idea = Idea.find(params[:id])
        format_to_json(idea)
    end
    
    patch "/idea/:id" do
        idea = Idea.find(params[:id])
        idea.update(params)
        idea.to_json
    end
    
    delete "/idea/:id" do
        idea = Idea.find(params[:id])
        idea.destroy
        idea.to_json
    end

    delete "/idea/:id/:user_id/unlike" do
        like = Like.where("idea_id = ? AND user_id = ?", params[:id], params[:user_id])
        like[0].destroy
        idea = Idea.find(params[:id]);
        idea.to_json(:methods => [:likes_count, :liked_by])
    end

    post "/idea/:id/:user_id/like" do
        like = Like.create(
            user_id: params[:user_id],
            idea_id: params[:id]
        )
        idea = Idea.find(params[:id]);
        idea.to_json(:methods => [:likes_count, :liked_by])
    end

    private

    def format_to_json(ideas)
        ideas.to_json(:methods => [:author, :topic_title, :likes_count, :liked_by])
    end

end
