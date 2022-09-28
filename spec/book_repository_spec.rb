require 'book_repository'

RSpec.describe BookRepository do
  def reset_books_end
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_books_end
  end

  it 'returns a list of all Book objects' do
    repo = BookRepository.new

    books = repo.all

    expect(books.length).to eq 2
    
    expect(books[0].id).to eq "1"
    expect(books[0].title).to eq "The Memory of Babel"
    expect(books[0].author_name).to eq "Christelle Dabos"
    
    expect(books[1].id).to eq "2"
    expect(books[1].title).to eq "Bunny"
    expect(books[1].author_name).to eq "Mona Awad"
  end

end