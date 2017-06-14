# frozen_string_literal: true
class UploadsController < ApplicationController
  before_action :authenticate_user!

  def new
    @upload = Upload.new(user_id: current_user.id, user_type: "User").tap(&:save)
  end

  def create
    @upload = Upload.new(upload_params)

    # Add bang after save will throw exception
    if @upload.save
      redirect_to :back, notice: 'File was successfully uploaded.'
    else
      redirect_to :back, alert: 'Failed to upload file.'
    end
  end

  def download
    @upload = Upload.find(params[:id])
    redirect_to @upload.file.expiring_url(url_expire_in_seconds)
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    flash[:notice] = "File has been deleted."
    redirect_to(:back)
  end

  private

  def url_expire_in_seconds
    10
  end

  def upload_params
    params.require(:upload).permit(:category, :file, :file_file_name, :user_id, :user_type)
  end
end
