class JournalEntriesController < ApplicationController
    
    #form for new journal entry/get requests show something that exists
    get '/journal_entries/new' do
        erb :'/journal_entries/new'
    end

    #post new journal entry
    post 'journal_entries' do
    
    end

    #show route for journal page

    #index route for all journal entries
end