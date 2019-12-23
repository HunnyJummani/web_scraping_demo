class WebScrappersController < ApplicationController
  def index
  end

  def new
    WebScrapper.crawl! 
    redirect_to root_path, notice: 'Results stored in results.json file.'
  end

  def download
    send_file(
      "#{Rails.root}/results.json",
      filename: "scraping_data.json",
      type: "application/json"
    )
  end
end
