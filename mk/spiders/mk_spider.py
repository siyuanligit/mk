# -*- coding: utf-8 -*-

from scrapy import Spider
from scrapy import Request
from mk.items import MkItem
from mk.items import MkReview
import re

class mkSpider(Spider):

    name = 'mk_spider'
    allowed_urls = ['https://mechanicalkeyboards.com/']
    start_urls = ['https://mechanicalkeyboards.com/shop/index.php?l=product_list&c=1&show=100']

    ### parse for result links ###
    def parse(self, response):

        pagination = int(response.xpath('//div[@class="blog-pagination"]/span/text()').extract_first().split()[-1])
        resultUrl = ['https://mechanicalkeyboards.com/shop/index.php?pg={}&l=product_list&c=1&show=100'.format(n) for n in range(1, pagination+1)]

        print("*"*10)
        print(resultUrl)
        print("*"*10)

        for url in resultUrl[:1]:
            yield Request(url=url, callback=self.parse_result_page)

    ### parse detail links ###
    def parse_result_page(self, response):

        detailUrl = response.xpath('//div[@class="product-name"]/a/@href').extract()

        for url in detailUrl[:11]:
            yield Request(url=url, callback=self.parse_detail_page)

    ### parse detail page information ###
    def parse_detail_page(self, response):

        # product listing name
        name = response.xpath('//h4[@class="name"]/text()').extract_first()
        # product img
        productimg = "".join(["https://mechanicalkeyboards.com/shop/", response.xpath('//a[@class="zoom"]/img/@src').extract_first()])
        # switch available
        switches = response.xpath('//td[@class="switch"]/a/text()').extract()
        # sku - id
        sku = response.xpath('//td[@class="switch"]/div/text()').extract()
        # price for specific switch
        sprice = response.xpath('//td[@class="price"]/text()').extract()
        # keycap spec
        keycap = "".join(response.xpath('//ul[@class="acc_features"]/li//text()').extract()[:3])
        # spec list
        specname = response.xpath('//td[@class="field"]/text()').extract()
        specvalue = response.xpath('//td[@class="value"]/text()').extract()
        spec = {}
        for n,v in zip(specname, specvalue):
            spec[n] = v
        # number of rating for the product and average rating
        if response.xpath('//div[@class="rating"]/text()').extract_first() == None:
            nreview = 0
            averating = None
        else:
            nreview = re.findall(r'\d+', response.xpath('//div[@class="rating"]/text()').extract_first())[2]
            averating = response.xpath('//div[@class="rating"]/img/@alt').extract_first().split()[0]
            # review sections
            # reviewer
            reviewers = response.xpath('//div[@class="review-metadata"]/div[@class="name"]/text()').extract()
            reviewers = list(map(lambda x: re.sub('(\\t|\\n|\\r| - )','', x), reviewers))[::2]
            # time of review
            reviewtime = response.xpath('//div[@class="review-metadata"]/div[@class="name"]/span/text()').extract()
            # review rating
            reviewrating = response.xpath('//div[@class="review-metadata"]/div[@class="queue"]/img/@src').extract()
            # review text
            review = response.xpath('//div[@class="review-content"]/p').extract()
            review = list(map(lambda x: re.sub('(\\t|\\n|\\r|<br>|<p>|</p>)','', x), review))

        print("*"*50)
        print(name)
        print(productimg)
        print("*"*10)
        print(averating)
        print(nreview)
        print("*"*10)
        print(switches)
        print(sku)
        print(sprice)
        print("*"*10)
        print(keycap)
        print("*"*10)
        for key, value in spec.items():
            print(key, ":", value)
        print("*"*10)
        print(reviewers)
        print(reviewtime)
        print(reviewrating)
        print(review)
        print("*"*50)