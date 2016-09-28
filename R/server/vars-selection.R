# get varnames
yvars = reactive({ c("sales", "volume", "average", "median") })
xvar = reactive({ "date" })
gpvar = reactive({ "city" })
seasonality = reactive({ "month" })
        
# implement variable selections
pick_y = callModule(choose_var, "y", "Select the outcome (y) variable:", yvars)
pick_x = callModule(choose_var, "x", "Select the time (x) variable:", xvar)
pick_gp = callModule(choose_var, "gp", "Select the grouping variable:", gpvar)
pick_seasonality = callModule(choose_var, "seasonality", 
                              "Select the seasonality variable:", seasonality)

# implement variable transformations
pick_trans_y = callModule(choose_transformation, "trans_y", 
                          "Select a transformation for y:")
