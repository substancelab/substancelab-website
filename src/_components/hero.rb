# frozen_string_literal: true

# The prominent block at the top of a page.
#
# The lede can be given either as a string or, when it needs markup, as a
# slot:
#
#   <%= render Hero.new(title: "Seed", lede: "From idea to product") %>
#
#   <%= render Hero.new(title: "Seed") do |hero| %>
#     <% hero.slot :lede do %>
#       From idea to <a href="/products/">product</a>
#     <% end %>
#   <% end %>
#
# Any other content in the block is rendered at the end of the hero.
class Hero < Bridgetown::Component
  def initialize(title:, badge: nil, lede: nil)
    @title = title
    @badge = badge
    @lede = lede
  end

  def before_render
    content # Evaluate the block so slots defined in it are available
  end

  def lede
    slotted(:lede, @lede)
  end

  def lede?
    slotted?(:lede) || !@lede.to_s.strip.empty?
  end
end
