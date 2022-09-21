require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /show" do
    let(:product) { create(:product) }

    before do
      get potepan_product_url(product.id)
    end

    it "レスポンスを返すこと" do
      expect(response).to have_http_status(:success)
    end

    it "商品が表示されていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end
  end
end
