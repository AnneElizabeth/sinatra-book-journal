class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|

      t.timestamps null: false
    end
  end
end
