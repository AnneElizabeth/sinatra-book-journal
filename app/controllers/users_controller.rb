class UsersController < ApplicationController

    #routes needed for login
    get '/login' do #renders the login page/form
      if logged_in?
        redirect "/users/#{current_user.id}"
      else
        erb :login
      end
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
        redirect 'signup'
      end
    end

    #this route renders sign up form
    get '/signup' do
      erb :signup
    end

    #creates new user and persists data to db
    post '/users' do
      #only want to persist user with username, email, password
      if params[:name] != "" && params[:email] != "" && params[:password] != ""
        @user = User.create(params)
        session[:user_id] = @user.id #logging user in
        #use redirect v. render because redirect
        #sends get request, separation of concerns,
        #job isn't to show new user but send to route that does that
        #get route, not post route
        redirect "/users/#{@user.id}"
        erb :'/users/show'
      else
        #not valid input
        redirect '/signup' #should include an error msg or create a failure/error page
      end
    end

    #user landing page route
    get '/users/:id' do
      @user = User.find_by(id: params[:id])
      erb :'/users/show'
    end

    #logout route
    get '/logout' do
      session.clear #logs user out
      redirect '/' #redirect to home page
    end
  end
