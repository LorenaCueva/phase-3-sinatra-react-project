class TopicsController < Sinatra::Base

    get "/topics" do
        topics = Topic.all.order(created_at: :desc)
        format_to_json(topics)
    end
    
    get "/topics/open" do
        topics = Topic.where("open = ?", true).order(created_at: :desc)
        format_to_json(topics, "open2")
    end
    
    get "/topics/closed" do
        topics = Topic.where("open = ?", false).order(updated_at: :desc)
        format_to_json(topics, "closed")
    end

    get "/topic/:id" do
        topics = Topic.where("id = ?", params[:id])
        format_to_json(topics)
    end

    get "/topic/:id/close" do
        topic = Topic.find(params[:id])
        topic.to_json(only: [:id],
                    include: {
                    ideas: {only: [:id, :user_id],
                            :methods => [:author, :likes_count]}})
    end

    patch "/topic/:id/close" do
        topic = Topic.find(params[:id])
        topic.update(
            open: false,
            winner_idea: params[:winner_idea]
        )
        format_to_json(topic, "closed")
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
                only: [:id , :title, :created_at, :user_id],
                :methods => [:closed_on , :ideas_count, :winner, :author, :winner_likes, :winner_author]
                )
        elsif type == "open2"
                topics.to_json(only: [:id, :created_at, :title, :user_id], :methods => [:ideas_count, :author])
    
        elsif type == ""
            topics.to_json(
                only: [:id , :title, :created_at, :updated_at], 
                include: 
                    {ideas: {:methods => [:author, :likes_count, :liked_by]}}, 
                :methods => [:author, :ideas_count]
            )
        end
    end

end