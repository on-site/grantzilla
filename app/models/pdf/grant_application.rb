module Pdf
  class GrantApplication < Prawn::Document
    def initialize(grant, view)
      super()
      @grant = grant
      @view = view
      text "This is a grant application for #{grant.people.to_sentence}."
    end
  end
end
