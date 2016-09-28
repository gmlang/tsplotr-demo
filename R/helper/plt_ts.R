plt_ts = function(dat, xvar, yvar, gpvar="1", trans_y="none") {
        # Plots a time series (or line) plot. 
        #
        # dat: a data frame that contains xvar and yvar
        # xvar, yvar: strings, names of two continuous variables from dat
        # gpvar: string, name of grouping var from dat
        # trans_y: string, name of the transformation to be applied
        #       to yvar. Possible values are "log", "log1p", "log10"
        
        # define color-blind friendly blue
        blue = "#0072B2" 
        
        # define line size and transparency
        alpha = 0.5
        size = 0.7
        
        # plot
        p = ggplot2::ggplot(dat, ggplot2::aes_string(xvar, yvar)) + 
                ggplot2::geom_line(ggplot2::aes_string(group = gpvar), 
                                   alpha = alpha, size = size, color = blue) +
                # ggplot2::geom_point(color = blue, size = size) +
                ggplot2::theme_minimal() 
        
        # apply comma style to x-axis
        p = scale_axis(p, "y", scale = "comma")
        
        # apply transformation to y-axis
        p = switch(trans_y,
               none = p,
               log = scale_axis(p, "y", scale = "log"),
               log1p = scale_axis(p, "y", scale = "log1p"),
               log10 = scale_axis(p, "y", scale = "log10")
        )
        
        # return 
        p
}