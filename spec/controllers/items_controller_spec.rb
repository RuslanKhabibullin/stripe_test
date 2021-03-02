require "rails_helper"

describe ItemsController do
  describe "#autocomplete" do
    before(:each) do
      allow(Elasticsearch::ItemsSearch)
        .to receive(:new)
        .with(term)
        .and_return(item_search_double)
    end

    let(:item_search_double) do
      instance_double(Elasticsearch::ItemsSearch, call: items_index_result_double)
    end
    let(:items_index_result_double) { double("ItemsIndexResult", objects: [item]) }
    let(:term) { "term" }
    let!(:item) { create :item }

    it "returns items JSON" do
      get :autocomplete, params: { term: term }

      expect(json_response_body).to eq [{ "id" => item.id, "title" => item.title }]
    end
  end
end
