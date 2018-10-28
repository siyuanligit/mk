# -*- coding: utf-8 -*-

import scrapy


class MkItem(scrapy.Item):
    name = scrapy.Field()
    img = scrapy.Field()
    price = scrapy.Field()
    averating = scrapy.Field()
    nreviews = scrapy.Field()
    switch = scrapy.Field()
    keycap = scrapy.Field()
    spec = scrapy.Field()

class MkReview(MkItem):
    user = scrapy.Field()
    datetime = scrapy.Field()
    rating = scrapy.Field()
    review = scrapy.Field()