#seed data to test associations

anne = User.create(name: "Anne", email: "anne@anne.com", password: "pass1234")
emily = User.create(name: "Emily", email: "emily@emily.com", password: "pass1234")

#Use ActiveRecord to pre-associate data
anne.journal_entries.create(content: "This book seems relevant to present times.", book_title: "The Handmaids Tale")
emilys_entry = emily.journal_entries.build(content: "Another Orwell classic.", book_title: "Animal Farm")
emilys_entry.save
