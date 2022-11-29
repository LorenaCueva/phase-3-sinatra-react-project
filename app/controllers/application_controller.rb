
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/login" do
    user = User.where("name = ?", params[:name])
    if user[0]
      if user.auth(params[:email])
        user.to_json
      end
    end
  end

  post "/register" do
    user = User.where("name = ? AND email = ?", params[:name], params[:email])
    if user[0]
      newUser = User.create(name: params[:name], email: params[:email])
      newUser.to_json
    end
  end

  get "/topics" do
    topics = Topic.all.order(created_at: :desc)
    topics.to_json(only: [:id , :title, :created_at, :updated_at], include: {ideas: {except: [:user_id], :methods => [:author, :likes_count, :liked_by]}}, :methods => [:ideas_count, :author])
  end

  get "/topics/open" do
    topics = Topic.where("open = ?", true).order(created_at: :desc)
    topics.to_json(only: [:id , :title, :created_at, :updated_at], include: {ideas: {only: [:id, :body, :created_at, :updated_at], :methods => [:author, :likes_count, :liked_by]}}, :methods => [:ideas_count, :author])
  end

  get "/topics/open/:user_id" do
    topics = Topic.where("user_id = ? AND open = ?",  params[:user_id], true)
    topics.to_json(only: [:id , :title, :created_at, :updated_at], include: {ideas: {only: [:id, :body, :created_at, :updated_at], :methods => [:author, :likes_count, :liked_by]}}, :methods => [:ideas_count, :author])
  end

  get "/topics/closed" do
    topics = Topic.where("open = ?", false).order(created_at: :desc)
    topics.to_json(only: [:id , :title, :created_at], :methods => [:closed_on, :ideas_count, :winner, :author])
  end

  get "/topics/closed/:user_id" do
    topics = Topic.where("user_id = ? AND open = ?", params[:user_id], false).order(updated_at: :desc)
    topics.to_json(only: [:id , :title, :created_at], :methods => [:closed_on, :ideas_count, :winner, :author])
  end

  get "/topic/:id" do
    topics = Topic.where("id = ?", params[:id])
    topics.to_json(only: [:id, :title, :created_at, :updated_at, :winner_idea, :open], include: {ideas: {:methods => [:likes_count, :liked_by]}}, :methods => [:ideas_count, :author])
  end

  get "/ideas/:user_id/have_likes" do
    res = []
    ideas = Idea.where("user_id = ?" , params[:user_id]).each do |i|
      if i.liked?
        res << i
      end
    end
    res.to_json(except: [:user_id], :methods => [:topic_name, :likes_count])


  end

  patch "/topic/:id" do
      topic = Topic.find(params[:id])
      topic.update(params)
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
    ideas = Idea.where("topic_id = ?", params[:id]).order(created_at: :desc)
    ideas.to_json(only: [:id, :body, :created_at, :updated_at], :methods => [:likes_count, :liked_by])
  end

  delete "/idea/:id" do
    idea = Idea.find(params[:id])
    idea.destroy
    idea.to_json
  end

  post "/topic/:id/ideas" do
    idea = Idea.create(
      topic_id: params[:id],
      body: params[:body],
      user_id: params[:user_id],
    )
    idea.to_json
  end

  patch "/idea/:id" do
    idea = Idea.find(params[:id])
    idea.update(params)
    idea.to_json
  end


end
