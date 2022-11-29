class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/login" do
    user = User.find(params[:name])
    if user
      if user.auth(params[:email])
        user.to_json
      end
    end
  end

  get "/topics" do
    topics = Topic.all.order(created_at: :desc)
    topics.to_json(only: [:id , :title, :user_id, :created_at, :updated_at], include: {ideas: {:methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count])
  end

  get "/topics/open" do
    topics = Topic.where("open = ?", true).order(created_at: :desc)
    topics.to_json(only: [:id , :title, :user_id, :created_at, :updated_at], include: {ideas: {only: [:id, :body, :user_id, :created_at, :updated_at], :methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count])
  end

  get "/topics/open/:user_id" do
    topics = Topic.where("user_id = ? AND open = ?",  params[:user_id], true)
    topics.to_json(only: [:id , :title, :created_at, :updated_at], include: {ideas: {only: [:id, :body, :created_at, :updated_at], :methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count])
  end

  get "/topics/closed" do
    topics = Topic.where("open = ?", false).order(created_at: :desc)
    topics.to_json(only: [:id , :title, :user_id, :created_at], :methods => [:closed_on, :ideas_count, :winner])
  end

  get "/topics/closed/:user_id" do
    topics = Topic.where("user_id = ? AND open = ?", params[:user_id], false).order(updated_at: :desc)
    topics.to_json(only: [:id , :title, :created_at], :methods => [:closed_on, :ideas_count, :winner])
  end

  get "/topic/:id" do
    topics = Topic.where("id = ?", params[:id])
    topics.to_json(only: [:id, :title, :user_id, :created_at, :updated_at, :winner_idea], include: {ideas: {:methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count])
  end

  patch "/topic/:id" do
    topic = Topic.find(params[:id])
    topic.update(
      title: params[:title],
      open: params[:open],
      winner_idea: params[:winner_idea]
    )
    topic.to_json
  end

  post "/topics" do
    topic = Topic.create(
      title: params[:title],
      user_id: params[:user_id],
      open: true
    )
    topic.to_json
  end

  delete "/topic/:id" do
    topic = Topic.find(params[:id])
    topic.destroy
    topic.to_json
  end

  get "/topic/:id/ideas" do
    ideas = Idea.where("topic_id = ?", params[:id])
    ideas.to_json(only: [:id, :body, :created_at, :updated_at], :methods => [:likes_count, :liked_by])
  end

  delete "/idea/:id" do
    idea = Idea.find(params[:id])
    idea.destroy
    idea.to_json
  end

  post "/topic/:id/ideas" do
    idea = idea.create(
      topic_id: params[:id],
      body: params[:body],
      user_id: params[user_id],
    )
    idea.to_json
  end



end
