require 'rails_helper'

RSpec.describe "Ingredients", type: :request do
  let(:ingredient) { create(:ingredient) }
  let(:admin) { create(:admin) }

  describe 'public' do
    context "index" do
      before do
        visit public_ingredients_path
      end
      it 'リクエストは200 OKとなること' do
        get public_ingredients_path
        expect(response.status).to eq 200
      end
      it '材料名が表示される' do
        visit public_ingredients_path
  			expect(page).to have_content ingredient.name
      end
      it '材料種別が表示される' do
        visit public_ingredients_path
        Ingredient.type_names.keys.each do |type_name|
          expect(page).to have_content type_name
        end
      end
    end
    context "search" do
      it '材料検索結果が表示される' do
        Ingredient.type_names.keys.each do |type_name|
          post search_public_ingredients_path(:name => type_name)
          expect(response.status).to eq 200
        end
      end
    end
  end

end
