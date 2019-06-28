class JournalEntriesController < ApplicationController

    #display all journal entries
    get '/journal_entries' do
        @journal_entries = JournalEntry.all
        erb :'journal_entries/index'
    end
    
    #form for new journal entry/get requests show something that exists
    get '/journal_entries/new' do
        erb :'/journal_entries/new'
    end

    #post new journal entry
    post '/journal_entries' do
        #create new entry and save to database (if it has content and user logged in)
        if !logged_in? 
            redirect '/'
        else
            if params[:content] || params[:book_title] != ""
                @journal_entry = JournalEntry.create(content: params[:content], book_title: params[:book_title], user_id: current_user.id)
                redirect "/journal_entries/#{@journal_entry.id}"
            else
                redirect '/journal_entries/new'
            end
        end
    end

    #dynamic show route for journal entries
    get '/journal_entries/:id' do
        find_entry
        erb :'/journal_entries/show'
    end

    #edit routes
    get '/journal_entries/:id/edit' do
        find_entry
        if logged_in?
            if @journal_entry.user == current_user
                erb :'/journal_entries/edit'
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect "/"
        end
    end

    patch '/journal_entries/:id' do
        find_entry
        if logged_in?
            if @journal_entry.user == current_user
                @journal_entry.update(book_title: params[:book_title], content: params[:content]) 
                redirect "/journal_entries/#{@journal_entry.id}"
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect "/"
        end
    end

    delete '/journal_entries/:id' do
        find_entry
        if @journal_entry.user == current_user
            @journal_entry.destroy
            redirect '/journal_entries'
        else
            redirect '/journal_entries'
        end
    end

    #helper method to prevent code duplication
    private #this method will only be used here
    def find_entry
        @journal_entry = JournalEntry.find(params[:id])
    end

end