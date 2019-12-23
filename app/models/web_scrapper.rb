require 'kimurai'

class WebScrapper < Kimurai::Base
  @name = "web_scrapper_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://metaruby.com/"]
  @config = {
      user_agent: "Chrome/68.0.3440.84"
    }

  attr_accessor :blogs

  def parse(response, url:, data: { })
    @blogs = []
    posts_headers_path = "//table[@class='topic-list ember-view']//tbody//tr"
    count = response.xpath(posts_headers_path).count
    
    loop do
      browser.execute_script("window.scrollBy(0,10000)") ; sleep 2
      response = browser.current_response

      new_count = response.xpath(posts_headers_path).count
      if count == new_count
        parse_data(response)
        logger.info "> Pagination is done" and break
      else
        count = new_count
        logger.info "> Continue scrolling, current count is #{count}..."
      end
    end
    
    logger.info "> Data saved to results.json"
  end

  def parse_data(response)
    response.xpath("//table[@class='topic-list ember-view']//tbody//tr").each do |tr|
      scrapped_data = {
                        title: tr.at('td[1]//span').text,
                        category: tr.at('td[1]//div//span').text,
                        date: tr.at('td[3]').text.strip
                      }
      blogs << scrapped_data
      save_to "results.json", scrapped_data.as_json, format: :json
    end
  end
end