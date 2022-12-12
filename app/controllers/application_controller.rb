
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/login/:name/:password" do
    user = User.where("name = ? AND password = ?", params[:name], params[:password])
    user.to_json
  end

  

  

  

end
