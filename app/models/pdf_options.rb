# frozen_string_literal: true
module PdfOptions
  def footer_options
    {
      html: {
        template: "shared/footer.pdf.erb"
      }
    }
  end

  def pdf_options(options)
    {
      pdf: options[:file_name] || "file",
      layout: "pdf.pdf.erb",
      footer: footer_options,
      margin: margins,
      page_size: "Letter",
      show_as_html: options[:debug]
    }
  end

  def margins
    {
      bottom: "0.5in",
      left:   "0.5in",
      right:  "0.5in",
      top:    "0.5in"
    }
  end
end
