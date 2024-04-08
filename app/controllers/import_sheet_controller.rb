class ImportSheetController < ApplicationController
  def show
    file_path = ENV['IMPORTED_EXCEL_FILE_PATH']
    @spreadsheet = Roo::Excelx.new(file_path)
  end
end
