class UploadsController < ApplicationController
  def new
    @upload = Upload.new(user_id: current_user.id).tap(&:save).upload
  end

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      redirect_to @upload, notice: 'Document was successfully uploaded.'
     else
       render action: 'new'
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end
