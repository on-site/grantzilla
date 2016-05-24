module Pdf
  class GrantApplication < Prawn::Document
    def initialize(grant, view)
      super()
      @grant = grant
      @view = view
      title
      partner_agency
    end

    def partner_agency
      move_down 20
      table([[{ content: "PARTNER AGENCY INFORMATION", colspan: 2 }],
             ["Caseworker Name: #{@grant.user}", "Phone #: #{@grant.user.agency.phone}"],
             ["Referring Agency: #{@grant.user.agency}", "Email Address: #{@grant.user.email}"]],
            column_widths: [220, 220]) do
        row(0).background_color = "CCCCCC"
        row(0).font_style = :bold
        rows(1..-1).size = 10
      end
    end

    def title
      image "#{Rails.root}/public/images/hif_logo.png", at: [450, 730], width: 80
      move_down 50
      text "Housing Industry Foundation", align: :center, size: 16, style: :bold
      text "EMERGENCY HOUSING FUND APPLICATION", align: :center, size: 16, style: :bold
    end
  end
end
