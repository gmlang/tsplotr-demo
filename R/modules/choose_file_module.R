choose_file_ui = function(id) {
        ns = NS(id)
        selectInput(ns('file'), "Choose RDS file",
                    list.files(path="data", pattern="\\.rds$"))
}

choose_file = function(input, output, session) {
        # Returns a reactive expression that will return user-uploaded data as a 
        #       data frame when called.
        
        user_file = reactive({
                # if no file is selected, don't do anything
                req(input$file)
        })
        
        # parse user uploaded data into a data frame
        reactive({
                readRDS(file.path("data", user_file()))
        })
}