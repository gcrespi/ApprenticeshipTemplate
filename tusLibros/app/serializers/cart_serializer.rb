class CartSerializer < ActiveModel::Serializer
  include WithBooksListSerializer
  attributes :id, :content
end
