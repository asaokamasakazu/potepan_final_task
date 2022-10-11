require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "#show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }
    let(:related_products) do
      5.times.collect do
        create(:product, price: "#{rand(1.00..99.99)}", taxons: [taxon])
      end
    end
    let(:related_images) { create_list(:image, 5) }

    before do
      product.images << image
      related_products.zip(related_images) do |related_product, related_image|
        related_product.images << related_image
      end
      visit potepan_product_path(product.id)
    end

    it "「一覧ページへ戻る」で一覧ページへ遷移すること" do
      click_link "一覧ページへ戻る"
      expect(page).to have_current_path potepan_category_path(taxon.id)
    end

    it "商品情報が表示されていること" do
      within ".media-body" do
        expect(page).to have_content product.name
        expect(page).to have_content product.display_price.to_s
        expect(page).to have_content product.description
      end
    end

    it "4つ目までの関連商品が全て表示されていること" do
      within ".productsContent" do
        related_products.first(4).all? do |related_product|
          expect(page).to have_content related_product.name
          expect(page).to have_content related_product.display_price.to_s
        end
      end
    end

    it "5つ目の関連商品が表示されていないこと" do
      within ".productsContent" do
        expect(page).not_to have_content related_products.last.name
        expect(page).not_to have_content related_products.last.display_price.to_s
      end
    end

    it "クリックした関連商品の商品詳細ページへ遷移すること" do
      within ".productsContent" do
        related_products.first(4).all? do |related_product|
          click_link related_product.name
          expect(page).to have_current_path potepan_product_path(related_product.id)
        end
      end
    end
  end
end
