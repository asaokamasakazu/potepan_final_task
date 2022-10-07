require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_product_path(product.id)
    end

    it "200レスポンスを返すこと" do
      expect(response).to have_http_status(:success)
    end

    it "商品が表示されていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end
  end
end
