require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:related_products) do
      5.times.collect do
        create(:product, price: "#{rand(1.00..99.99)}", taxons: [taxon])
      end
    end
    let(:related_images) { create_list(:image, 5) }

    before do
      related_products.zip(related_images) do |related_product, related_image|
        related_product.images << related_image
      end
      get potepan_product_path(product.id)
    end

    it "正常なレスポンスを返すこと" do
      expect(response).to have_http_status(:success)
    end

    it "商品情報を取得できていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end

    it "関連商品を4つのみ取得していること" do
      related_products.first(4).all? do |related_product|
        expect(response.body).to include related_product.name
        expect(response.body).to include related_product.display_price.to_s
      end
      expect(response.body).not_to include related_products.last.name
      expect(response.body).not_to include related_products.last.display_price.to_s
    end
  end
end
