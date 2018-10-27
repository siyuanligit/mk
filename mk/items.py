# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class MkItem(scrapy.Item):
    # define the fields for your item here like:
    name = scrapy.Field()
    price = scrapy.Field()
    nreviews = scrapy.Field()
    switch = scrapy.Field()
    keycap = scrapy.Field()
    spec = scrapy.Field()