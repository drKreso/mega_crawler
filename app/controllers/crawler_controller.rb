class CrawlerController < ApplicationController
  respond_to :json

  def crawl
    begin
      page = Nokogiri::HTML(open(params[:url]))

      links = page.css('a').map{|link| link['href']}.compact.reject(&:blank?).reject{|link| '#' == link}
      #depending on choice this can be combined or separate
      #opting for combined approach
      inside_content_tags = page.css('h1, h2, h3').map(&:text).map{|item| item.gsub("\n",'')}.map(&:strip).compact.reject(&:blank?)

      CrawledPage.new({
        url: params[:url],
        content: {
          links:links,
          inside_content_tags:inside_content_tags
        }
      }).save
      render status: 200, json: { message: "#{params[:url]} crawled succesfully" }
    rescue => e
      render status: 500, json: { error_message: e }
    end

  end

  def index
    @crawled_pages = CrawledPage.all.order(:created_at)

    respond_with @crawled_pages
  end

end
