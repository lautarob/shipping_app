require 'swagger_helper'

RSpec.describe 'api/v1/products', type: :request do

  path '/api/v1/products' do
    get('list products') do
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object,
          properties: {
            collection: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  _id: { type: :string },
                  created_at: { type: :string },
                  updated_at: { type: :string },
                  name: { type: :string },
                  type: { type: :string },
                  length: { type: :integer },
                  width: { type: :integer },
                  height: { type: :integer },
                  weight: { type: :integer }
                }
              }
            }
          }
        let(:product) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4) }
        run_test!
      end
    end

    post('create product') do
      consumes "application/json"
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          type: { type: :string },
          length: { type: :integer },
          width: { type: :integer },
          height: { type: :integer },
          weight: { type: :integer }
        },
        required: %w[name type length width height weight]
      }

      response(201, 'product created') do
        let(:product) { { name: "Small Package", type: "Golf", length: 48, width: 14, height: 12, weight: 42 } }
        run_test!
      end

      response(422, 'invalid request') do
        let(:product) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}' do
    get('show product') do
      produces 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id'

      response(200, 'product found') do
        schema type: :object,
          properties: {
            _id: { type: :string },
            created_at: { type: :string },
            updated_at: { type: :string },
            name: { type: :string },
            type: { type: :string },
            length: { type: :integer },
            width: { type: :integer },
            height: { type: :integer },
            weight: { type: :integer }
          },
          required: %w[id name type length width height weight]

        let(:id) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4).id }
        run_test!
      end

      response(404, 'product not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch('update product') do
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          type: { type: :string },
          length: { type: :integer },
          width: { type: :integer },
          height: { type: :integer },
          weight: { type: :integer }
        }
      }

      response(200, 'updated product successfully') do
        let(:product) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4) }
        let(:id) { product.id }
        run_test!
      end

      response(404, 'product not found') do
        let(:product) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4) }
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put('update product') do
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          type: { type: :string },
          length: { type: :integer },
          width: { type: :integer },
          height: { type: :integer },
          weight: { type: :integer }
        }
      }

      response(200, 'updated product successfully') do
        let(:product) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4) }
        let(:id) { product.id }
        run_test!
      end

      response(404, 'product not found') do
        let(:product) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4) }
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete('delete product') do
      parameter name: 'id', in: :path, type: :string, description: 'id'

      response(204, 'no content') do
        let(:product) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4) }
        let(:id) { product.id }
        run_test!
      end

      response(404, 'no product found') do
        let(:product) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4) }
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/products/{length}/{width}/{height}/{weight}' do
    get('show product best fit') do
      produces 'application/json'
      parameter name: 'length', in: :path, type: :string, description: 'length'
      parameter name: 'width', in: :path, type: :string, description: 'width'
      parameter name: 'height', in: :path, type: :string, description: 'height'
      parameter name: 'weight', in: :path, type: :string, description: 'weight'

      response(200, 'product found') do
        schema type: :object,
          properties: {
            _id: { type: :string },
            created_at: { type: :string },
            updated_at: { type: :string },
            name: { type: :string },
            type: { type: :string },
            length: { type: :integer },
            width: { type: :integer },
            height: { type: :integer },
            weight: { type: :integer }
          },
          required: %w[id name type length width height weight]

        let(:id) { Product.create(name: 'foo', type: 'bar', length: 1, width: 2, height: 3, weight: 4).id }
        run_test!
      end

      response(404, 'product not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
