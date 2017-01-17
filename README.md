# MegaCrawler

The best ever crawler. Putting Google to shame.

##Installation

Clone the repository from GitHub.

```
git clone git@github.com:drKreso/mega_crawler.git
```

Execute in terminal:

```
cd mega_crawler
bundle install
rake db:create
rake db:migrate
rails s
```

##Crawling Page API

Send post request with url parameter that needs to be crawled.

```
curl --form "url=https://kodius.io" localhost:3000/api/v1/crawl
```

or use Postman as shown below

<img width="827" alt="screen shot 2017-01-17 at 11 19 05" src="https://cloud.githubusercontent.com/assets/32063/22016640/4711d06a-dca7-11e6-8f0e-bcd02e7ee73b.png">

Each crawl is separately recorded (even for same urls).

##Fetched Data Index API

To access fetched data use get request:

```
curl localhost:3000/api/v1/index.json
```

or use Postman as shown below

<img width="918" alt="screen shot 2017-01-17 at 11 20 29" src="https://cloud.githubusercontent.com/assets/32063/22016643/4a319474-dca7-11e6-869b-0b6a8d7ef022.png">

Currently only .json response is supported


##Testing

To run tests

```
rails test
```
