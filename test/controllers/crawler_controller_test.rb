require 'test_helper'

class CrawlerControllerTest < ActionDispatch::IntegrationTest

  test "the truth" do
    assert true
  end

  test "can we crawl existing page" do
    post "/api/v1/crawl.json", params: {url: 'https://kodius.io'}
    assert_response :success
    assert_equal({'message':'https://kodius.io crawled succesfully'}.to_json, @response.body)
  end

  test "can we handle a nonexistant page" do
    post "/api/v1/crawl.json", params: {url: 'https://kodiuss.io'}
    assert_response 500
    assert_equal({'error_message':'getaddrinfo: nodename nor servname provided, or not known'}.to_json, @response.body)
  end

  test "do we store data in database" do
    assert_equal 0, CrawledPage.count
    post "/api/v1/crawl.json", params: {url: 'https://kodius.io'}
    post "/api/v1/crawl.json", params: {url: 'https://kodius.io'}
    assert_equal 2, CrawledPage.count
  end

  test "we crawl correct data" do
    VCR.use_cassette("kodius-page") do
      post "/api/v1/crawl.json", params: {url: 'https://kodius.io'}
    end

    expected = [{"url"=>"https://kodius.io",
                "content"=>{"links"=>
                	["https://blog.kodius.io",
                    "#hire-us",
                    "https://blog.kodius.io",
                    "#hire-us",
                    "https://platiplus.krokodil.hr/users/login"
                  ],
                "inside_content_tags"=>
                		["to help companies build awesome products",
                		 "Web, Mobile and Design",
                	   "BlaBlaMeeter", "GymTrainer", "PayPlus",
                     "What We Can Do For You", "Hire us"]
                     }
                }]

    get "/api/v1/index.json"

    assert_equal(expected.to_json, @response.body)
  end

end
