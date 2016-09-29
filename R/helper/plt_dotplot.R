plt_dotplot = function(dat, xvar, gpvar) {
        # Plots a time series (or line) plot. 
        #
        # dat: a data frame that contains xvar and yvar
        # xvar: string, name of the x variable
        # gpvar: string, name of grouping var from dat

        # define color-blind friendly blue
        blue = "#0072B2" 
        
        # define line size and transparency
        size = 1.5
        
        # plot
        dat[[gpvar]] = reorder(dat[[gpvar]], dat[[xvar]])
        p = ggplot2::ggplot(dat, ggplot2::aes_string(xvar, gpvar)) + 
                ggplot2::geom_point(color = blue, size = size) +
                ggplot2::theme_minimal() 
        
        # return 
        p
}