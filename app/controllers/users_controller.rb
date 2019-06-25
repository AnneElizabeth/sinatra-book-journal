class UsersController < ApplicationController

    #routes needed for login
    get '/login' do #renders the login page/form
      erb :login
    end

    post '/login' do #creating session: receiving login form, find user, and log user in
      #params look like: {email: "user@user.com", password: "password"}
      #find user
      @user = User.find_by(email: params[:email])
      #authenticate user (returns false when authentication fails, true when it's successful)
      if @user.authenticate(params[:password])
        #log user in (create their session)
        session[:user_id] = @user.id #logging user in
        #redirect to user's show page
        puts session
        redirect "users/#{@user.id}"
      else
        #tell user credentials are invalid
        #redirect them to login page
      end
    end

    get '/signup' do

    end

    #user SHOW route
    get '/users/:id' do
      'This is the user show route.'
    end

end
