namespace :data_import do
  desc "Migrate MS Access data from legacy database to new Postgres database"
  task :import_csv_data, [:csv_filename] => [:environment] do |t, args|
    puts "Importing CSV data from '#{args.csv_filename}'"
    DataImportManager.new("args.csv_filename").import_data
  end
end