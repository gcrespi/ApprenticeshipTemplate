class SaleSerializer < ActiveModel::Serializer
  include WithBooksListSerializer
  attributes :id, :content, :total_price
end
