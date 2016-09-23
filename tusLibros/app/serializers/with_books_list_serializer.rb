module WithBooksListSerializer
  def content
    object.books.group_by { |a_book| a_book }.map do |a_book, book_list|
      {
          book: ActiveModelSerializers::SerializableResource.new(a_book, {}).serializable_hash,
          quantity: book_list.size
      }
    end
  end
end