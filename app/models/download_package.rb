# frozen_string_literal: true
# This class creates the download package as a PDF file
class DownloadPackage
  require "prawn"

  def initialize(grant_id, pdf_filename_hash)
    @grant = Grant.find(grant_id)
    @pdf_filename_hash = pdf_filename_hash
  end

  def create_in_pdf
    create_download_package
  end

  private

  attr_reader :grant, :pdf_filename_hash

  def create_download_package
    one_pdf = Magick::ImageList.new(pdf_filename_hash[:application])

    add_uploaded_documents_from_aws(one_pdf)
    add_comments_to_pdf(one_pdf)

    write_pdf(one_pdf)
  end

  def add_uploaded_documents_from_aws(one_pdf)
    # Example of how to add images
    #   one_pdf.read("filename_with_path")
    Upload.where(user_id: grant.id).find_each do |uploaded_file|
      uploaded_filename = uploaded_file.file_file_name
      filename_path = Tempfile.new("grant_#{@grant.id}.#{uploaded_filename}").path
      uploaded_file.file.copy_to_local_file :original, filename_path
      one_pdf.read(filename_path)
      File.delete(filename_path)
    end
  end

  def grant_comments
    comments = Comment.where(grant_id: grant.id)
    return "" unless comments.present?

    comments_in_text = "Comments for Grant #{grant.id}\n\n"
    comments.each do |comment|
      comments_in_text += "Last Update at #{comment.updated_at.strftime('%Y-%m-%d %l:%M %p')}\n#{comment.body}\n\n"
    end

    comments_in_text
  end

  def add_comments_to_pdf(one_pdf)
    comments = grant_comments
    return unless comments.present?

    pdf_filename = pdf_filename_hash[:comments]
    Prawn::Document.generate(pdf_filename) do
      text comments
    end
    comment_pdf = one_pdf.open(pdf_filename)
    one_pdf.read(comment_pdf)
  end

  def write_pdf(one_pdf)
    one_pdf.write("pdf:" + pdf_filename_hash[:package])
  end
end
