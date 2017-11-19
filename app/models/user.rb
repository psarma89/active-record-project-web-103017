class User < ActiveRecord::Base
  has_many :user_books
  has_many :books, through: :user_books

  def check_out_book(book, due_date)
    UserBook.create({book_id: book.id, user_id: self.id, due_date: due_date})
  end

  def return_book(book)
    instance = UserBook.find_by(book_id: book.id, user_id: self.id)
    instance.returned = true
    instance.save
  end
end
