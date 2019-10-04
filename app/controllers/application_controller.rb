require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "book_journal_app"
  end

  get "/" do
    if !logged_in?
      erb :welcome
    else
      redirect "users/#{@current_user.id}"
    end
  end

  helpers do
    def logged_in?
      !!current_user #returns true if so
    end

    def current_user
      #reduces calls to database
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
