# Book Store Model and Repository Classes Design Recipe

## 1. Design and create the Table

## 2. Create Test SQL seeds

TRUNCATE TABLE books RESTART IDENTITY;

INSERT INTO books (title, author_name) VALUES('The Memory of Babel', 'Christelle Dabos');
INSERT INTO books (title, author_name) VALUES('Bunny', 'Mona Awad');

## 3. Define the class names

class Book
end

class BookRepository
end

## 4. Implement the Model class

class Book

  attr_accessor: :id, :title, :author_name
end

## 5. Define the Repository Class interface

require 'book'

class BookRepository
  def all
    books = []

    sql = 'SELECT id, title, author_name;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      book = Book.new
      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']
      books << book
    end
    return books
  end
end

## 6. Write Test Examples

repo = BookRepository.new

books = repo.all

books.length # => 2

books[0].id # => "1"
books[0].title # => "The Memory of Babel"
books[0].author_name # => "Christelle Dabos"

books[1].id # => "2"
books[1].title # => "Bunny"
books[1].author_name # => "Mona Awad"

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

