## Webscraping Project on MechanicalKeyboards.com

### Introduction

I am a mechanical keyboard enthusiastic and I often introduces mechanical keyboards to my friends. However, the mechanical keyboard market is so diverse and finding the perfect keyboard just for the person is quite a daunting task. So I thought, why don’t I find a place with all kinds of keyboards available, use my knowledge on mechanical keyboards, categorize them and make a keyboard picker/recommendation system?

### Scraping the data

I chose [mechanicalkeyboards.com](https://mechanicalkeyboards.com/shop/) as the website to scrape. Based in Tennessee, “mechanicalkeyboards.com” is one of the largest mechanical keyboard vendors in the United States. It offers not only pre-built complete keyboards, but also parts and accessories for mechanical keyboards.

“Mechanicalkeyboards.com” has a simple and efficient architecture. Since it does not use REST API to retrieve the product listings, I decided to use Scrapy in Python to scrape the website.
I collected 797 listings from the online shop, with their:

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

Using the information on hand, I made a [shiny webApp](https://siyuanli.shinyapps.io/mkPicker/) for picking a mechanical keyboard. 

### Future works

Some NLP analysis using the product reviews. Incorporate them into the shiny app.
