# -*- coding: utf-8 -*-

import scrapy


class MkItem(scrapy.Item):
    name = scrapy.Field()
    img = scrapy.Field()
    switch = scrapy.Field()
    sku = scrapy.Field()
    price = scrapy.Field()
    keycap = scrapy.Field()
    spec = scrapy.Field()
    averating = scrapy.Field()
    nreviews = scrapy.Field()
    user = scrapy.Field()
    datetime = scrapy.Field()
    rating = scrapy.Field()
    review = scrapy.Field()