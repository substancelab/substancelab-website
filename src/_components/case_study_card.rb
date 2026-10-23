# frozen_string_literal: true

class CaseStudyCard < Bridgetown::Component
  def initialize(case_study:, lazy: false)
    @case_study = case_study
    @lazy = lazy
  end

  def image_attributes
    attributes = {alt: @case_study["name"], width: 740, height: 600}
    attributes[:loading] = "lazy" if @lazy
    attributes
  end
end
