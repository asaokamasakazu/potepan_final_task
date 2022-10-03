require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "#show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }

    before do
      product.images << image
      visit potepan_product_path(product.id)
    end

    it "「一覧ページへ戻る」で一覧ページへ遷移すること" do
      click_link "一覧ページへ戻る"
      expect(page).to have_current_path potepan_category_path(taxon.id)
    end
  end
end
