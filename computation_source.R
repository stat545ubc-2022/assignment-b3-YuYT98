library("readxl")
library(stringr)
library(shiny)
library(dplyr)
library(caret)
library(kernlab)


# PATH variables
output_path = "output_file/"

# output files
original_data_avg = str_c(output_path, "avg_original_data.csv")
original_data_sd = str_c(output_path, "sd_original_data.csv")
predicted_data_avg = str_c(output_path, "avg_predicted_data.csv")
predicted_data_sd = str_c(output_path, "sd_predicted_data.csv")
output_zip_path = str_c(output_path, "stat_summary_results.zip")
output = str_c(output_path, "stat_summary.csv")


computations = function(datapath){

    data = read_excel(datapath)
    data = data.frame(data)
    original_avg = mean(data[,2])
    original_sd = sd(data[,2])
    predicted_avg = mean(data[,3])
    predicted_sd = sd(data[,3])
    print('finish calculation')
    summary <- c("original_avg", "original_sd", "predicted_avg", "predicted_sd")
    stat <- c(original_avg, original_sd, predicted_avg, predicted_sd)

    df <- data.frame(summary, stat)

    write.csv(df, output)
    write.csv(original_avg,original_data_avg)
    write.csv(original_sd,original_data_sd)
    write.csv(predicted_avg,predicted_data_avg)
    write.csv(predicted_sd,predicted_data_sd)

    output_files = c(original_data_avg,
                     original_data_sd,
                     predicted_data_avg,
                     predicted_data_sd
    )
}
