require 'rails_helper'

RSpec.describe Potepan::ProductDecorator, type: :model do
  describe "#related_produsts" do
    let(:taxon1) { create(:taxon) }
    let(:taxon2) { create(:taxon) }
    let(:unrelated_taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon1, taxon2]) }
    let(:related_products) { create_list(:product, 4, taxons: [taxon1, taxon2]) }
    let(:unrelated_product) { create(:product, taxons: [unrelated_taxon]) }

    it "主商品と関連商品が重複していないこと" do
      expect(product.related_products).not_to include product
    end

    it "関連商品同士が重複していないこと" do
      expect(product.related_products).to match_array related_products
    end

    it "関連した商品のみ取得していること" do
      expect(product.related_products).not_to include unrelated_product
    end
  end
end
