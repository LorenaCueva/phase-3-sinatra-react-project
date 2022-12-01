class TopicsController < Sinatra::Base

    get "/topics" do
        topics = Topic.all.order(created_at: :desc)
        format_to_json(topics)
      end
    
    get "/topics/open" do
        topics = Topic.where("open = ?", true).order(created_at: :desc)
        format_to_json(topics, "open")
    end
    
    get "/topics/open/:user_id" do
        topics = Topic.where("user_id = ? AND open = ?",  params[:user_id], true)
        format_to_json(topics, "open")
    end
    
    get "/topics/closed" do
        topics = Topic.where("open = ?", false).order(created_at: :desc)
        format_to_json(topics, "closed")
    end
    
    get "/topics/closed/:user_id" do
        topics = Topic.where("user_id = ? AND open = ?", params[:user_id], false).order(updated_at: :desc)
        format_to_json(topics, "closed")
    end

    get "/topic/:id" do
        topics = Topic.where("id = ?", params[:id])
        format_to_json(topics)
    end
    
    patch "/topic/:id" do
          topic = Topic.find(params[:id])
          topic.update(
            title: params[:title],
            open: params[:open]
            )
          topic.to_json
    end
    
    post "/topics" do
        topic = Topic.create(
          title: params[:title],
          user_id: params[:user_id],
          open: true
        )
        format_to_json(topic, "open")
    end
    
    delete "/topic/:id" do
        topic = Topic.find(params[:id])
        topic.destroy
        topic.to_json
    end


    private

    def format_to_json(topics, type="")
        if type == "open"
            topics.to_json(
                only: [:id , :title, :created_at, :updated_at, :open, :user_id], 
                include: 
                    {ideas: {only: [:id, :body, :created_at, :updated_at], 
                            :methods => [:author, :likes_count, :liked_by]}},
                :methods => [:author, :ideas_count]
            )
        elsif type == "closed"
            topics.to_json(
                only: [:id , :title, :created_at], 
                :methods => [:closed_on, :ideas_count, :winner, :author]
                )
        elsif type == ""
            topics.to_json(
                only: [:id , :title, :created_at, :updated_at], 
                include: 
                    {ideas: {except: [:user_id], 
                            :methods => [:author, :likes_count, :liked_by]}}, 
                :methods => [:author, :ideas_count]
            )
        end
    end

end