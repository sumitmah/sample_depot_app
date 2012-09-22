class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :image_url, type: String
  field :price, type: Float


end
