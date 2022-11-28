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
    topics.to_json(only: [:id , :title, :user_id, :created_at, :edited_at], include: {ideas: {:methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count])
  end

  get "/topics/open" do
    topics = Topic.where("open = ?", true).order(created_at: :desc)
    topics.to_json(only: [:id , :title, :user_id, :created_at, :edited_at], include: {ideas: {:methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count])
  end

  get "/topics/open/:user_id" do
    topics = Topic.where("user_id = ? AND open = ?",  params[:user_id], true)
    topics.to_json(only: [:id , :title, :created_at, :edited_at], include: {ideas: {:methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count])
  end

  get "/topics/closed" do
    topics = Topic.where("open = ?", false).order(created_at: :desc)
    topics.to_json(only: [:id , :title, :user_id, :created_at], :methods => [:closed_on, :ideas_count, :winner])
  end

  get "/topics/closed/:user_id" do
    topics = Topic.where("user_id = ? AND open = ?", params[:user_id], false).order(edited_at: :desc)
    topics.to_json(only: [:id , :title, :created_at], :methods => [:closed_on, :ideas_count, :winner])
  end

  get "/topic/:id" do
    topics = Topic.where("id = ?", params[:id])
    topics.to_json(only: [:id, :title, :user_id, :created_at, :edited_at, :winner_idea], include: {ideas: {:methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count])
  end

  


end
