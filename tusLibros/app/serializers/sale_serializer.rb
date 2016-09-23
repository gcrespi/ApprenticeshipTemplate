class SaleSerializer < ActiveModel::Serializer
  include WithBooksListSerializer
  attributes :id, :content
end
