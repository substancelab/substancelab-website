# frozen_string_literal: true

class Gallery < Bridgetown::Component
  def initialize(case_studies:)
    @case_studies = case_studies
  end
end
