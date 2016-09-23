class BookSerializer < ActiveModel::Serializer
  attributes :id, :isbn, :title, :price
end
