namespace :products do
  task :pull => [ :environment ] do
    def get_products
      puts 'Starting getting products'
      json = open('data/products.json').read
      hash = JSON.parse(json)
      puts 'End getting products'
      hash['products']
    end

    def save_products
      products = get_products
      puts 'Starting saving products'
      products.each do |product|
        Product.find_or_create_by(product)
      end
      puts 'End saving products'
    end

    save_products
  end
end
