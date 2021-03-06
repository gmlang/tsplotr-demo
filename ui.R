navbarPage(title=div(a(href="http://cabaceo.com", 
                       img(src="Logo_01.png", id = "logo")), "tsPlotR - demo"),
           windowTitle = "tsPlotR - demo",
           theme = "darkly2.css",

           tabPanel('Upload Data',
                    sidebarLayout(
                            sidebarPanel(
                                    h4("This app uses a data set and some R code from Hadley's", 
                                       a("talk,", href="https://www.rstudio.com/resources/webinars/pipelines-for-data-analysis-in-r/",
                                         target="_blank"), 
                                       "which I highly recommend you to watch."),
                                    br(),br(),
                                    choose_file_ui("datafile"),
                                    # insert google ads
                                    tags$script(async="async", src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"),
                                    includeHTML("www/google-ads-size-auto.html"),
                                    tags$script("(adsbygoogle = window.adsbygoogle || []).push({});")
                                    ),
                            
                            mainPanel(id = "upload",
                                    verbatimTextOutput("datastruct"),
                                    fluidRow(column(5, 
                                                    sliderInput("n", "Slide me to change the number of rows on display", 10, 100, 10)
                                                    ),
                                    column(5, offset = 2, 
                                           uiOutput("column")
                                           )
                                    ),
                                    dataTableOutput("first100rows")
                                    )
                            
                            )
                    ),
           
           tabPanel("Trend",
                    sidebarLayout(
                            sidebarPanel(
                                    choose_var_ui("y"),
                                    choose_var_ui("x"),
                                    choose_var_ui("gp"),
                                    choose_transformation_ui("trans_y"),
                                    actionButton("show_ts", "Show Plot"),
                                    br(), br(), br(),
                                    choose_var_ui("seasonality"),
                                    actionButton("show_trend", "Remove Seasonality"),
                                    br(), br(), br(),
                                    
                                    # insert google ads
                                    tags$script(async="async", src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"),
                                    includeHTML("www/google-ads-size-fixed.html"),
                                    tags$script("(adsbygoogle = window.adsbygoogle || []).push({});")
                                    ),
                            
                            mainPanel(id = "plot",
                                    plotOutput("gg_ts", height="500", width="1025"), 
                                    # br(),
                                    # plotOutput("gg_trend", height="450", width="800"), 
                                    br(), 
                                    fluidRow(column(5, plotOutput("gg_rsqrd", height="500", width="500")),
                                             column(5, 
                                                    plotOutput("gg_maxcoef", height="500", width="500"))),
                                    br(), br()
                                    )
                            
                            )
                    )
           )

