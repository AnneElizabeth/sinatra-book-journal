class JournalEntriesController < ApplicationController
    
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

    #dynamic route for journal entries
    get '/journal_entries/:id' do
        @journal_entry = JournalEntry.find(params[:id])
        erb :'journal_entries/show'
    end

    #index route for all journal entries
end