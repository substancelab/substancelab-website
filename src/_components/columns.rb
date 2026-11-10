# frozen_string_literal: true

# Lays out its children side by side in equal columns, stacking them when
# there isn't room. Spans the full width of the page.
#
#   <%= render Columns.new do %>
#     <div>
#       <h2>Oplagt til...</h2>
#       <p>Iværksætteren med drømmen om en online tjeneste</p>
#     </div>
#
#     <div>
#       <h2>Det får du</h2>
#       <ul>…</ul>
#     </div>
#   <% end %>
class Columns < Bridgetown::Component
end
