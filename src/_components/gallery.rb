# frozen_string_literal: true

class Gallery < Bridgetown::Component
  def initialize(case_studies:, additional_classes: [])
    @case_studies = case_studies
    @additional_classes = additional_classes
  end

  def additional_classes
    @additional_classes.join(" ")
  end
end
