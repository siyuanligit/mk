# -*- coding: utf-8 -*-

import scrapy


class MkItem(scrapy.Item):
    name = scrapy.Field()
    img = scrapy.Field()
    switch = scrapy.Field()
    sku = scrapy.Field()
    price = scrapy.Field()
    keycap = scrapy.Field()
    averating = scrapy.Field()
    nreviews = scrapy.Field()
    # user = scrapy.Field()
    # datetime = scrapy.Field()
    # rating = scrapy.Field()
    # review = scrapy.Field()
    brand = scrapy.Field()
    model = scrapy.Field()
    size = scrapy.Field()
    dimension = scrapy.Field()
    weight = scrapy.Field()
    frcolor = scrapy.Field()
    logilayout = scrapy.Field()
    physlayout = scrapy.Field()
    led = scrapy.Field()
    interface = scrapy.Field()
    rollover = scrapy.Field()

