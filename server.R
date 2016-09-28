server = function(input, output) {
        # implement data upload
        datafile = callModule(choose_file, "datafile")
        
        # implement data display
        source(file.path(server_path, "data-display.R"), local = T)
        
        # implement variable selections
        source(file.path(server_path, "vars-selection.R"), local = T)
        
        # implement data prep (NA removal and etc.)
        source(file.path(server_path, "data-prep.R"), local = T)
        
        # plot raw time series plots
        observeEvent(input$show_ts, {
                dat = rm_NAs()
                x = pick_x() 
                y = pick_y()
                gp = pick_gp()
                trans_y = pick_trans_y()
                
                output$gg_ts = renderPlot({
                        # plt_ts is defined in R/helper
                        plt_ts(dat, x, y, gp, trans_y) 
                })
        })
        
        # remove seasonality and plot general trend
        observeEvent(input$show_trend, {
                source(file.path(server_path, "rm-seasonality.R"), local = T)
                dat = df_resid()
                x = pick_x() 
                y = "residuals"
                gp = pick_gp()
                
                output$gg_trend = renderPlot({
                        # plt_trend is defined in R/helper
                        plt_trend(dat, x, y, gp)
                })
        })
}

shinyServer(server)