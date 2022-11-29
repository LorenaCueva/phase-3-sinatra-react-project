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
    
    get "/ideas/topic/:id" do
        ideas = Idea.where("topic_id = ?", params[:id]).order(created_at: :desc)
        format_to_json(ideas)
    end
    
    post "/ideas/topic/:id" do
        idea = Idea.create(
          topic_id: params[:id],
          body: params[:body],
          user_id: params[:user_id],
        )
        idea.to_json
    end
    
    get "/idea/:id" do
        idea = Idea.find(params[:id])
        Idea.to_json(idea)
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

    private

    def format_to_json(ideas)
        ideas.to_json(except: [:user_id], :methods => [:author, :topic_title, :likes_count, :liked_by])
    end

end