require 'roo'
require 'sidekiq'

namespace :import do
  desc "Import products from Excel file"
  task products: :environment do
    file_path = ENV['IMPORTED_EXCEL_FILE_PATH'] 
    ImportWorker.perform_at(2:30 PM, file_path)
  end
end