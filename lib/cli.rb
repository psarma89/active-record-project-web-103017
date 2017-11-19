class Cli

  def greeting
    puts "Welcome!"
  end

  def ask_name
    puts "Please give us your fullname:"
  end

  def get_input
    gets.chomp
  end

  def get_user(fullname)
    User.find_by(name: fullname)
  end

  def list_categories
    Category.all.each_with_index{|category, index| puts "#{index+1}. #{category.name}"}
    puts ""
    puts "Please pick a category by name to see all books"
  end

  def show_books(category)
    instance = Category.find_by(name: category)
    if instance
      instance.books.each_with_index{|book, index| puts "#{index+1}. #{book.title}"}
      puts "Please select a book by name to check out"
      check_out_book(get_input)
    else
      puts "We could not find your category, please provide an appropriate category name"
      sleep(3)
      system('clear')
      list_categories
      show_books(get_input)
    end
  end

  def check_out_book(book_name)
    instance = Book.find_by(title: book_name)
    if instance
      @user.check_out_book(instance, DateTime.now)
      puts "You've checked out #{instance.title}"
      puts ""
      puts "
      If you would like to return the book, enter Y
      If you would like to checkout more books, enter N
      To exit press any other key
      "
      case get_input
      when "Y"
        @user.return_book(instance)
        puts "#{instance.title} has been returned"
        puts "Taking you back to categories"
        sleep(3)
        system('clear')
        list_categories
        show_books(get_input)
      when "N"
        puts "Taking you back to categories"
        sleep(3)
        system('clear')
        list_categories
        show_books(get_input)
      else
        goodbye
      end
    else
      puts "We could not find your book, please provide an appropriate book name"
      sleep(3)
      system('clear')
      list_categories
      show_books(get_input)
    end
  end

  def goodbye
    puts "Goodbye!"
    sleep(2)
    exit
  end

  def runner
    system('clear')
    greeting
    ask_name
    username = get_input
    if get_user(username)
      @user = get_user(username)
      list_categories
      show_books(get_input)
      check_out_book(get_input)
    else
      puts "Sorry Could not find your user, enter a valid user"
      sleep(3)
      runner
    end
  end
end
