navbarPage(title=div(a(href="http://cabaceo.com",
                       img(src="Logo_01.png", id = "logo")), "tsplotr"),
           theme = "darkly1.css", 

           tabPanel('Upload Data',
                    sidebarLayout(
                            sidebarPanel(
                                    choose_file_ui("datafile")
                                    ),
                            mainPanel(
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
                                    choose_transformation_ui("trans_y", "Select a transformation for y:"),
                                    actionButton("show_ts", "Show Plot"),
                                    br(), br(), br(),
                                    choose_var_ui("seasonality"),
                                    actionButton("show_trend", "Remove Seasonality")
                                    ),
                            mainPanel(
                                    plotOutput("gg_ts", height="450", width="800"), 
                                    br(),
                                    plotOutput("gg_trend", height="450", width="800"), 
                                    br(), br()
                                    )
                            )
                    )
           )

