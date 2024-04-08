class ImportWorker
  include Sidekiq::Worker
  require 'roo'

  def perform(file_path)
    spreadsheet = Roo::Excelx.new(file_path)
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      product = Product.find_by(name: row['name'])
      if product
        Rails.logger.info "Product #{product.name} already exists. Skipping import."
      else
        product = Product.new(name: row['name'], amount: row['amount'])
        Rails.logger.info "Product #{product.name} imported successfully!" if product.save
      end
    end

    Rails.logger.info 'Products imported successfully!'
  rescue StandardError => e
    Rails.logger.error "Error importing products: #{e.message}"
  end
end
