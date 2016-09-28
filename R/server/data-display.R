# display the structure of the uploaded data
output$datastruct = renderPrint({
        str(datafile()) 
})

# implement multi-select 
output$column = renderUI({
        selectizeInput("column", "Select columns to highlight", 
                       names(datafile()), multiple = T)
})

# get the 1st 100 rows
first100rows = reactive({
        show_nrows = 100
        dat = datafile()
        if (nrow(dat) > show_nrows) dat[1:show_nrows, ]
        else dat
})

# display data
output$first100rows = renderDataTable(
        datatable(first100rows(), extensions = "Buttons", style = 'bootstrap',
                  options = list(pageLength = input$n)
                  ) %>% formatStyle(input$column, color = 'black',
                                    backgroundColor = 'yellow', fontWeight ='bold')
        )


