# frozen_string_literal: true

# A tile linking to one of our own products, styled like a case study tile.
class ProductCard < Bridgetown::Component
  def initialize(product:, lazy: false)
    @product = product
    @lazy = lazy
  end

  def image_attributes
    attributes = {alt: @product["name"], width: 1500, height: 600}
    attributes[:loading] = "lazy" if @lazy
    attributes
  end
end
