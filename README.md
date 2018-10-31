## Webscraping Project on MechanicalKeyboards.com

### Introduction

Personally, I am a mechanical keyboards enthuthiastic, meaning I build my own mechanical keyboard; from buying the components to soldering them together. 

I often introduces my friends into the world of mechanical keyboards. But I have found out that picking the first mechanical keyboard to invest in can be a daunting task. 

There are so many choices, so many information to digest in order to find the perfect one. That is why I have chosen [mechanicalkeyboards.com](https://mechanicalkeyboards.com/shop/) as the website to scrap in order to obtain all the products they have to offer. So that I can build something with the data and make a keyboard picker from the information I scraped.

### Scraping the data

Since mechanicalkeyboards.com uses minimal AJAX, I chose scrapy in Python as the tool to scrap the website.

I collected 797 observations from the online shop site with their:
- product name
- brand
- model
- mechanical switch type
- price
- id
- keycap material
- keycap legend color
- keycap print method
- frame color
- interface
- dimension
- weight
- average rating
- number of reviews

### Some interesting finds

Top 5 highest rated brands are:
1. Leopold
2. Ducky
3. Vortex
4. Mechanical Keyboards Inc
5. KBParadise

Top 5 most reviewed brands are:
1. Ducky
2. Mechanical Keyboards Inc
3. Vortex
4. KBParadise
5. Leopold

Notice these five are the all-star brands from the website.

While keyboards using no lighting or white lighting has the highest average price, keyboards using multi-colored lighting has the lowest average price. 

And while keyboards using blue lighting has the highest overall rating, keyboards using pink lighting has the lowest overall rating.

Using the information on hand, I made a shiny webApp for picking a mechanical keyboard. Link is in my github.

### Future works

Some NLP analysis using the product reviews. Incorporate them into the shiny app.