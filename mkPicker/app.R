library(shiny)
library(shinydashboard)

load("C:/Users/Derek/Google Drive/bootcamp/Project2/mk/mkPicker/mkItem.rdata")
# load("~/mkItem.rdata")

ui <- dashboardPage(
    # dashboard header
    dashboardHeader(title = "mkPicker"),
    
    # dashboard sidebar
    dashboardSidebar(
        sidebarMenu(
            menuItem("Introduction", tabName = "intro", icon = icon("home")),
            menuItem("Picker", tabName = "picker", icon = icon("th")),
            menuItem("Recommender", tabName = "recommender", icon = icon("th")),
            menuItem("About", tabName = "about", icon = icon("user"))
        )
    ),
    
    # dashboard body
    dashboardBody(
        includeCSS("C:/Users/Derek/Google Drive/bootcamp/Project2/mk/mkPicker/www/custom.css"),
        # tags$head(includeCSS("~/www/custom.css")),
        tabItems(
            # intro
            tabItem(tabName = "intro",
                    fluidRow(
                        column(width = 1),
                        column(width = 5,
                               h2("Pre-built Mechanical Keyboard Picker/Recommender"),
                               a(href = "https://github.com/siyuanligit/mk", "Github link for this project"),
                               h3("Introduction:"),
                               p("Getting into the world of Mechanical Keyboard can be daunting, so many choices, so many brands, switch types, lightings, etc. This app is designed to help you pick a mechanical keyboard of your preference."),
                               h3("Data:"),
                               p('Data is scraped from mechanicalkeyboards.com, using Scrapy in Python.'),
                               p("Product specifications are spanned using different switches available and their corresponding prices."),
                               h3("How to use this webApp:"),
                               p("First part is a simple filtering picker. Provide you with a list of choices based on your answer to each question."),
                               p("Second part is a recommendation system which will give you a top 5 pick of mechanical keyboards based on your choice."),
                               h3("Future Works:"),
                               p("Some NLP analysis using the product reviews. ")),
                        column(width = 5))),
            
            # picker/filter
            tabItem(tabName = "picker"),
            
            # recommender
            tabItem(tabName = "recommender"),
            
            # about
            tabItem(tabName = "about",
                    column(width = 1),
                    column(width = 11,
                           h2("About Author:"),
                           img(src = "face.jpg"),
                           h3("Siyuan Li, Derek"),
                           h4("Data Science Fellow at NYC Data Science Academy"),
                           h4("Volunteer at DataKind.org"),
                           br(),
                           h4("Master of Applied Statisitcs, UCLA 2016 - 2018"),
                           h4("Bachelor of Financial Mathematics and Statistics, UCSB 2011 - 2015"),
                           br(),
                           h4("Rental Real Estate Broker Assistant, Underwriting 2018"),
                           h4("Quantitative Analyst Intern, Mingshi Investment Management, Shanghai, China 2016"),
                           h4("Investment Analyst Intern, Soochow Securities, Suzhou, Jiangsu, China 2015"),
                           br(),
                           a(href="www.linkedin.com/in/siyuan-derek-li-b4663a49", "LinkedIn"),
                           br(),
                           a(href="github.com/siyuanligit", "Github")))
        )
    )
)

# server functionality
server <- function(input, output) {
    
}

shinyApp(ui = ui, server = server)

