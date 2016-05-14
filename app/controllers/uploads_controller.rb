class UploadsController < ApplicationController
  before_action :authenticate_user!

  def index
    @uploads = Upload.all
  end

  def new
    @upload = Upload.new(user_id: current_user.id, user_type: "User").tap(&:save)
  end

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      redirect_to uploads_path, notice: 'Document was successfully uploaded.'
    else
      render action: 'new'
    end
  end

  def download
    @upload = Upload.find(params[:id].to_i)
    extension = File.extname(@upload.file_file_name)
    send_data open("#{@upload.file.expiring_url(3600, :original)}").read,
              filename: "original_#{@upload.id}#{extension}",
              type: @upload.file_content_type
  end

  private

  def upload_params
    params.require(:upload).permit(:file, :file_file_name, :user_id, :user_type)
  end
end

#s3 = Aws::S3::Resource.new
#bucket = s3.bucket('grants.hifinfo.org')
#bucket.objects({prefix: 'uploads/files/000/000/009/original/'}).each do |obj|
#  puts "#{obj.presigned_url(:get, expires_in: 3600)}"
#end
