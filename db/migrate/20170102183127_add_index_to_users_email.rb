class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
    #Puts an index onto the email column so we can access it more easily, and ensure uniqueness.
    def change
        add_index :users, :email, unique: true
    end
end
