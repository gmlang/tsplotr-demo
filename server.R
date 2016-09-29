server = function(input, output) {
        # implement data upload
        datafile = callModule(choose_file, "datafile")
        
        # implement data display
        source(file.path(server_path, "data-display.R"), local = T)
        
        # implement variable selections
        source(file.path(server_path, "vars-selection.R"), local = T)
        
        # implement data prep (NA removal and etc.)
        source(file.path(server_path, "data-prep.R"), local = T)
        
        
        observeEvent(input$show_ts, {
                dat = rm_NAs()
                x = pick_x() 
                y = pick_y()
                gp = pick_gp()
                trans_y = pick_trans_y()
                
                # plot raw time series plots
                output$gg_ts = renderPlot({
                        # plt_ts is defined in R/helper
                        plt_ts(dat, x, y, gp, trans_y) 
                })
        })
        
        
        observeEvent(input$show_trend, {
                # remove seasonality
                source(file.path(server_path, "rm-seasonality.R"), local = T)
                
                # get user selected vars
                x = pick_x() 
                gp = pick_gp()
                
                # plot general trend of the residuals after removing seasonality
                dat_resid = df_resid()
                output$gg_ts = renderPlot({
                        # plt_trend is defined in R/helper
                        plt_trend(dat_resid, x, y="residuals", gp)
                })
                
                # plot r-squared by gp var
                dat_rsqrd = df_rsqrd()
                output$gg_rsqrd = renderPlot({
                        # plt_dotplot is defined in R/helper
                        plt_dotplot(dat_rsqrd, x="r.squared", gp)
                })
                
                dat_maxcoef = df_maxcoef()
                output$gg_maxcoef = renderPlot({
                        # plt_dotplot is defined in R/helper
                        plt_dotplot(dat_maxcoef, x="max_coef", gp)
                })
        })
}

shinyServer(server)