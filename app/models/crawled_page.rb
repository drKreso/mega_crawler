class CrawledPage < ApplicationRecord
  serialize :content

  def as_json(options)
    super(:only => [:url, :content])
  end
end
