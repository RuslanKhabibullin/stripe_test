require "rails_helper"

describe Elasticsearch::ItemsSearch, :vcr, chewy: :urgent do
  include_context "chewy indexes"

  let!(:item1) { create :item, title: "Astartes" }
  let!(:item2) { create :item, title: "As one" }
  let!(:item3) { create :item, title: "Boys Band" }

  shared_examples "blank term acceptable" do
    let(:term) { nil }

    it { is_expected.to eq [] }
  end

  shared_examples "no match term acceptable" do
    let(:term) { "no_match" }

    it { is_expected.to eq [] }
  end

  describe "#to_a" do
    subject(:search_object) { described_class.new(term).call.to_a }

    it_behaves_like "blank term acceptable"
    it_behaves_like "no match term acceptable"

    context "when term is match" do
      let(:term) { "as" }

      it "returns entities" do
        expect(search_object.map(&:id)).to eq [item1.id.to_s, item2.id.to_s]
      end
    end
  end

  describe "#objects" do
    subject(:search_object) { described_class.new(term).call.objects }

    it_behaves_like "blank term acceptable"
    it_behaves_like "no match term acceptable"

    context "when term is match" do
      let(:term) { "as" }

      it "returns entities" do
        expect(search_object).to eq [item1, item2]
      end
    end
  end
end
