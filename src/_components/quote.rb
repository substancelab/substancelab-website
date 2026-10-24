# frozen_string_literal: true

# A quote from a client or someone else worth listening to.
#
# The quote itself is given as the block. The author can be given either as a
# string or, when it needs markup, as a slot:
#
#   <%= render Quote.new(author: "Caroline Meldgaard, Børn i byen") do %>
#     <p>I hjælper os til at undgå at bruge penge på unødvendig kode</p>
#   <% end %>
#
#   <%= render Quote.new do |quote| %>
#     <p>Efter få uger havde jeg et faktisk produkt</p>
#     <% quote.slot :author do %>
#       Steen Iver Andersen, <a href="https://www.patentact.company">PatentAct</a>
#     <% end %>
#   <% end %>
class Quote < Bridgetown::Component
  def initialize(author: nil, additional_classes: [])
    @author = author
    @additional_classes = additional_classes
  end

  def classes
    ["ui-quote", *@additional_classes].join(" ")
  end

  def before_render
    content # Evaluate the block so slots defined in it are available
  end

  def author
    slotted(:author, @author)
  end

  def author?
    slotted?(:author) || !@author.to_s.strip.empty?
  end
end
