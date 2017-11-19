class CreateUserBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.datetime :due_date
      t.boolean :returned, :default => false
    end
  end
end
