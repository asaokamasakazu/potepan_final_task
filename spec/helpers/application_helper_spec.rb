require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title(page_title)" do
    subject { full_title(page_title) }

    context "page_titleがemptyの場合" do
      let(:page_title) { "" }

      it "titleが「BIGBAG Store」であること" do
        is_expected.to eq "BIGBAG Store"
      end
    end

    context "page_titleがnilの場合" do
      let(:page_title) { nil }

      it "titleが「BIGBAG Store」であること" do
        is_expected.to eq "BIGBAG Store"
      end
    end

    context "page_titleが存在する場合" do
      let(:page_title) { "sample" }

      it "titleが「page_title - BIGBAG Store」であること" do
        is_expected.to eq "sample - BIGBAG Store"
      end
    end
  end
end
