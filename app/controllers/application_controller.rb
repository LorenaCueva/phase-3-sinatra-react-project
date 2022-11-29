
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

  

  

  

end
