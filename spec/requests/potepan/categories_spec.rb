require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:other_taxon) { create(:taxon, name: "Pants", taxonomy: taxonomy, parent: taxonomy.root) }
    let(:product1) { create(:product, taxons: [taxon]) }
    let(:product2) { create(:product, taxons: [taxon]) }
    let(:other_product) { create(:product, taxons: [other_taxon]) }
    let(:image1) { create(:image) }
    let(:image2) { create(:image) }
    let(:other_image) { create(:image) }

    before do
      product1.images << image1
      product2.images << image2
      other_product.images << other_image
      get potepan_category_path(taxon.id)
    end

    it "200レスポンスを返すこと" do
      expect(response).to have_http_status(:success)
    end

    it "taxonに紐づくproductだけ表示されていること" do
      expect(response.body).to include product1.name
      expect(response.body).to include product2.name
      expect(response.body).not_to include other_product.name
    end

    it "商品価格が表示されていること" do
      expect(response.body).to include product1.display_price.to_s
      expect(response.body).to include product2.display_price.to_s
    end

    it "商品カテゴリーとしてtaxonomy.nameが表示されていること" do
      expect(response.body).to include taxonomy.name
    end

    it "商品カテゴリーとしてtaxon.nameとother_taxon.nameが表示されていること" do
      expect(response.body).to include taxon.name
      expect(response.body).to include other_taxon.name
    end

    it "カテゴリーに商品数が表示されていること" do
      within ".side-nav" do
        expect(response.body).to include taxon.products.count.to_s
        expect(response.body).to include other_taxon.products.count.to_s
      end
    end
  end
end
