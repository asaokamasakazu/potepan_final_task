require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }
    let(:taxonomy) { create(:taxonomy) }

    before do
      product.images << image
      get potepan_category_path(taxon.id)
    end

    it "200レスポンスを返すこと" do
      expect(response).to have_http_status(:success)
    end

    it "商品情報が表示されていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
    end

    it "商品カテゴリとしてtaxonomy.nameが表示されていること" do
      expect(response.body).to include taxonomy.name
    end

    it "商品カテゴリとしてtaxon.nameが表示されていること" do
      expect(response.body).to include taxon.name
    end
  end
end
