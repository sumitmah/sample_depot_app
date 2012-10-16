class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :image_url, type: String
  field :price, type: Float

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true

  private
  def ensure_not_referenced_by_any_line_item
    return true if line_items.empty?
    errors.add(:base, 'Line Items present')
    false
  end
end