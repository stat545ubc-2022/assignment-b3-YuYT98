#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinycssloaders)
library(DT)

ui <- fluidPage(

    ## Additional feature 1: added topic picture for the website
    img(src = "sst.png", height="30%", width="30%"),

    sidebarLayout(
        sidebarPanel(

            p('This tool is intended for users who want to compute some basic statistical results based on their original data and predicted data.'),
            p('Statistics summary tool User guide:'),
            p('1. Download our ',
              a('template', href = 'https://github.com/stat545ubc-2022/assignment-b3-YuYT98/raw/main/data_template/data_template.xlsx', style = "color:#E67E22", target="_blank"),
              'and put your subject id or name under the first column, the original data under the second column and predicted data under the third column',
              br(),
              br(),
              '2. Upload your excel file. Your data are ready to compute when you see "Upload complete" in the progress bar. You can also preview your data to ensure they are correct.',
              br(),
              br(),
              '3. Click the',
              strong('"Compute "'),
              'button (',
              strong('please only click ONCE and it may take a few seconds to respond'),
              '). You will see the confirmation message when the computation successfully finished. If an error occurs, please double check your data input.',
              br(),
              br(),
              '4. Download your results by clicking the ',
              strong('"Download Results"'),
              'button.'),
            br(),
            fileInput("file1", "Choose Excel File", accept = ".xlsx"),
            tags$head(tags$script(src = "message-handler.js")),
            actionButton("confirm", "Compute"),
            h4(textOutput("caption", container = span)),
            br(),
            downloadButton("downloadData1", "Download Results")
        ),
        mainPanel(
            tableOutput("contents"),

            ## Additional feature 2: added summary of uploaded data
            textOutput("text"),

            ## Additional feature 3: added correlation plot of uploaded data
            plotOutput("cor_plot")
        )
    )
)

