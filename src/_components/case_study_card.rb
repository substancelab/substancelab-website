# frozen_string_literal: true

class CaseStudyCard < Bridgetown::Component
  def initialize(case_study:)
    @case_study = case_study
  end
end
