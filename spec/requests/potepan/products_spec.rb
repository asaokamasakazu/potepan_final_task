require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_product_path(product.id)
    end

    it "200レスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    it "商品情報を取得できていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end
  end
end
