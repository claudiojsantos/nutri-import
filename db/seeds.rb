include FactoryBot::Syntax::Methods

require 'logger'
logger = Logger.new('log/seed.log')

logger.info 'Seeding database...'

10.times do |i|
  product = create(:product)
  logger.info "Product #{i + 1} created with ID: #{product.id}"
end

logger.info 'Seeding complete!'
