class AddSurveyToGrant < ActiveRecord::Migration[5.0]
  def change
    add_column :grants, :grant_survey, :boolean
  end
end
