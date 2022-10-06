require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  describe "#show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }
    let!(:other_taxon) do
      create(:taxon, name: "other_taxon", taxonomy: taxonomy, parent: taxonomy.root)
    end

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

    it "現在のカテゴリー名が表示されていること" do
      within ".page-title" do
        expect(page).to have_content taxon.name
      end
    end

    it "サイドバーに全てのカテゴリーが表示されていること" do
      within ".side-nav" do
        expect(page).to have_content taxonomy.name
        expect(page).to have_content taxon.name
        expect(page).to have_content other_taxon.name
      end
    end

    it "サイドバーの各カテゴリーに商品数が表示されていること" do
      within "#taxon-#{taxon.id}" do
        expect(page).to have_content taxon.products.count
      end
      within "#taxon-#{other_taxon.id}" do
        expect(page).to have_content other_taxon.products.count
      end
    end

    it "商品情報が全て表示されていること" do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price.to_s
    end

    it "サイドバーの個数と表示している商品の個数が一致していること" do
      expect(page.all('.productBox').count).to eq taxon.products.count
    end

    it "商品をクリックすると商品詳細ページに遷移すること" do
      click_link product.name
      expect(page).to have_current_path potepan_product_path(product.id)
    end

    it "商品カテゴリーメニューからカテゴリー一覧に遷移すること" do
      click_link other_taxon.name
      expect(page).to have_current_path potepan_category_path(other_taxon.id)
    end
  end
end
