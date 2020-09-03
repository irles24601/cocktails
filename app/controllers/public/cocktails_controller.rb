class Public::CocktailsController < ApplicationController
  before_action :set_api_cocktails, only:[:index, :show]

  def index
  end

  def show
    response = open("https://cocktail-f.com/api/v1/cocktails/#{params[:id]}").read
    hash = JSON.parse(response)
    @api_cocktail = hash["cocktail"]
    @recipes = @api_cocktail["recipes"]

    # カクテル名(英語)+alcohol+cocktailで画像検索 100件/1日
    google_url = "https://www.googleapis.com/customsearch/v1?key=#{ENV['API_key']}&cx=#{ENV['Search_Engine_id']}&searchType=image&q=#{@api_cocktail["cocktail_name_english"]}+alcohol+cocktail&lr=lang_ja&safe=off&num=1"
    img_response = open(google_url).read
    hash = JSON.parse(img_response)
    @api_cocktail_imglink = hash["items"][0]["link"]

  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end
  
  def destroy
  end
end

private

  def set_api_cocktails
    response = open("https://cocktail-f.com/api/v1/cocktails").read
    hash = JSON.parse(response)
    @api_cocktails = hash["cocktails"]
  end