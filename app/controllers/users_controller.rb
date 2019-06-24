class UsersController < ApplicationController

    #routes needed for login
    get '/login' do #renders the login page/form
      erb :login
    end

    get '/signup' do

    end

end
