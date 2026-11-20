# frozen_string_literal: true

class Gallery < Bridgetown::Component
  # eager: How many of the first case studies are visible when the page
  # loads and should load their images right away. The rest load lazily.
  def initialize(case_studies:, additional_classes: [], eager: 0)
    @case_studies = case_studies
    @additional_classes = additional_classes
    @eager = eager
  end

  def additional_classes
    @additional_classes.join(" ")
  end
end
