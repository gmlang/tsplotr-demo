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
                        p = plt_ts(dat, x, y, gp, trans_y) 
                        web_display(p)
                })
        })
        
        
        observeEvent(input$show_trend, {
                # remove seasonality
                source(file.path(server_path, "rm-seasonality.R"), local = T)
                
                # get residuals and r-squared for lm(the response ~ seasonality)
                withProgress(message = 'Removing Seasonality...', value = 0.4, {
                        dat_resid = df_resid()
                        incProgress(0.2)
                        Sys.sleep(0.5)
                        
                        dat_rsqrd = df_rsqrd()
                        incProgress(0.2)
                        Sys.sleep(0.5)
                        
                        dat_maxcoef = df_maxcoef()
                        incProgress(0.2)
                        Sys.sleep(0.5)
                })
                
                # get user selected vars
                x = pick_x() 
                gp = pick_gp()
                
                withProgress(message = 'Plotting ', value = 0.4, {
                        
                        # plot general trend of the residuals 
                        output$gg_ts = renderPlot({
                                p = plt_trend(dat_resid, x, y="residuals", gp)
                                web_display(p)
                        })
                        
                        incProgress(0.2, detail = "trend")
                        Sys.sleep(2)
                        
                        # plot r-squared by gp var
                        output$gg_rsqrd = renderPlot({
                                plt_dotplot(dat_rsqrd, x="r.squared", gp)
                        })
                        
                        incProgress(0.2, detail = "R-squared")
                        Sys.sleep(1)
                        
                        # plot max coef by gp var
                        output$gg_maxcoef = renderPlot({
                                plt_dotplot(dat_maxcoef, x="max_coef", gp)
                        })
                        
                        incProgress(0.2, detail = "Max Coef. Est.")
                        Sys.sleep(1)
                })
        })
}

shinyServer(server)