class SessionsController < ApplicationController
  def new
  end
    #If user login data are valid it will return the access_token so the
    #client app can use it for future request for the specific user.
  def create
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        render :json => user.access_token, status: 200
      else
        render json: "Email and password combination are invalid", status: 422
      end
  end
    #Verifies the access_token so the client app would know if to login the user.
  def verify_access_token
    user = User.find_by(access_token: params[:session][:access_token])
      if user
        render json: "verified", status: 200
      else
        render json: "Token failed verification", status: 422
      end
  end
end
