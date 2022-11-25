# Import R packages needed for the app here:
library(shiny)
library(stringr)
library("readxl")
library(dplyr)

# Begin app server
shinyServer(function(input, output) {

    # ------------------ App server logic (Edit anything below) --------------- #

    output_path = "output_file/"
    original_data_avg = str_c(output_path, "avg_original_data.csv")
    original_data_sd = str_c(output_path, "sd_original_data.csv")
    predicted_data_avg = str_c(output_path, "avg_predicted_data.csv")
    predicted_data_sd = str_c(output_path, "sd_predicted_data.csv")
    output_zip_path = str_c(output_path, "stat_summary_results.zip")

    # preview uploaded file
    output$contents <- renderTable({
        file <- input$file1
        data = file$datapath
        ext <- tools::file_ext(file$datapath)

        req(file)
        validate(need(ext == "xlsx", "Please upload an excel(.xlsx) file"))

        read_xlsx(file$datapath)
    })

    # computation step
    cal <- eventReactive(input$confirm, {
        file <- input$file1
        data = file$datapath
        source('computation_source.R')
        computations(data)
        "Computations done. Please download your results."

    })

    output$caption <- renderText({
        cal()
    })

    output_files = c(original_data_avg,
                     original_data_sd,
                     predicted_data_avg,
                     predicted_data_sd)

    output$downloadData1 <- downloadHandler(
        filename = 'stat_summary_results.zip',
        content = function(file) {
            zip(file,output_files)
        }

    )
})
