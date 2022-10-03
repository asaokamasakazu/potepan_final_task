require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  describe "#show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }

    before do
      product.images << image
      visit potepan_category_path(taxon.id)
    end

    it "navbarのHOMEをクリックするとトップページに遷移すること" do
      within ".navbar" do
        click_link "Home"
        expect(page).to have_current_path potepan_path
      end
    end

    it "パンくずのHOMEをクリックするとトップページに遷移すること" do
      within ".pageHeader" do
        click_link "Home"
        expect(page).to have_current_path potepan_path
      end
    end

    it "商品をクリックすると商品詳細ページに遷移すること" do
      click_link product.name
      expect(page).to have_current_path potepan_product_path(product.id)
    end

    it "商品カテゴリーメニューからカテゴリー一覧に遷移すること" do
      click_link taxon.name
      expect(page).to have_current_path potepan_category_path(taxon.id)
    end
  end
end
