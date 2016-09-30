choose_transformation_ui = function(id, head = "Select a transformation") {
        ns = NS(id)
        selectInput(ns("trans"), label = head, 
                    choices = list("none"="none", "log"="log", 
                                   "log plus 1" = "log1p", "log10"="log10"), 
                    selected = "none")
}

choose_transformation = function(input, output, session) {
        # Returns a reactive expression that will return the name of the user 
        #       selected variable transformation when called.
        
        reactive({
                input$trans
        })
}

