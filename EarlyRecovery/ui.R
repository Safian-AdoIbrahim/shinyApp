library(shiny)
library(dplyr)
library(echarts4r)
library(tidyverse)
library(echarts4r.maps)
library(shinyWidgets)

#Read csv file and assign it to an object

er <- read.csv("earlyrecovery.csv")
prettyNum(er$total_beneficiaries, big.mark = ",", scientific = FALSE)
head(er)



ui <- div( 
  tags$head(src = "https://cdn.tailwindcss.com",
            
            tags$link(
              
              rel = "stylesheet",
              type = "text/css",
              href = "https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css"
              
            )
            
            
            
  ),
  
  
  tags$head(    tags$link(
    
    rel = "stylesheet",
    type = "text/css",
    href = "main.css"
    
  )
  ),
  
  
  
  
  
  HTML('
        <div class="h-full w-full absolute">
            <!-- Navigation starts -->
           
            <nav class="w-full mx-auto bg-white shadow">
                <div class="container px-6 justify-between h-16 flex items-center lg:items-stretch mx-0">
                    <div class="h-full flex items-center">
                        <div aria-label="Home" role="img" class="mr-10 flex items-center">
                            <img src="logo2.png" alt="logo" height="55px" width="55px">
                            <span class="text-2xl font-bold text-orange-600 px-1 tracking-normal leading-tight hidden lg:block">Northeast Nigeria | </span><span><h3 class="text-base text-orange-600 font-semibold tracking-normal leading-tight ml-0 hidden lg:block">Early Recovery Sub-Sector 5Ws Response Dashboard</h3></span>
                        </div>
                       <!-- <ul class="pr-12 xl:flex items-center h-full hidden">
                            <li class="hover:text-indigo-700 cursor-pointer h-full flex items-center text-sm text-indigo-700 tracking-normal border-b-2 border-indigo-700"><a href="javascript:void(0)"> Dashboard</a></li>
                            <li class="hover:text-indigo-700 cursor-pointer h-full flex items-center text-sm text-gry-800 mx-10 tracking-normal" ><a href="javascript:void(0)">Products</a></li>
                            <li class="hover:text-indigo-700 cursor-pointer h-full flex items-center text-sm text-gry-800 mr-10 tracking-normal"><a href="javascript:void(0)">Performance</a></li>
                            <li class="hover:text-indigo-700 cursor-pointer h-full flex items-center text-sm text-gray-800 tracking-normal"><a href="javascript:void(0)">Deliverables</a></li>
                        </ul>-->
                    </div>
                    <div class="h-full xl:flex items-center justify-end hidden">
                        <div class="w-full h-full flex items-center">
                         
                        
                        </div>
                   
                    </div>
                </div>
            </nav>
        
    '), #<!--Navbar ends-->
  
  
  
  #<---Filters--->
  
  div(class = "flex flex-wrap mx-8 rounded-lg item-center justify-center mt-4 pt-3 border-2 border-white shadow-md",
      div(class="flex flex-row mr-5 pt-1 font-normal w-40", 
          
          selectInput   (
            inputId = "filterState",
            label = "",
            choices = c("State", unique(er$state)),
            selected = "All",
          ),
          
      ),
      div(class="flex flex-row mr-5 pt-1 font-normal w-40", 
          
          selectInput   (
            inputId = "filterLGA",
            label = "",
            choices = c("Local Govt. Area", unique(er$lga)),
            selected = "All",
          ),
          
      ),
      
      div(class="flex flex-row mr-5 pt-1 font-normal w-40", 
          
          selectInput   (
            inputId = "filterOrg",
            label = "",
            choices = c("Organisation", unique(er$acronym)),
            selected = "All",
          ),
          
      ), 
      
      
      div(class="flex flex-row mr-5 pt-1 font-normal w-40", 
          
          selectInput   (
            inputId = "filterMonth",
            label = "",
            choices = c("Month", unique(er$reporting_month)),
            selected = "All",
          ),
          
      ), 
      
      
      div(class="flex flex-row mr-5 pt-1 font-normal w-40", 
          
          selectInput   (
            inputId = "filterActivity",
            label = "",
            choices = c("Activity", unique(er$activity_type)),
            selected = "All",
          ),
          
      ), 
      
      
      
      
      
      
      
      
      
  ),
  
  
  
  
  #<!---End of Filters--->
  
  
  
  
  #<!--KPI Cards -->
  
  div(class = "flex flex-wrap mx-4 mt-4",
      
      #Card1
      div(class = "w-full max-w-full px-4 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/5",
          div(class = "flex flex-row shadow-lg p-2 bg-white border-l-4 border-orange-600 rounded-sm bg-clip-border",
              div(class = "flex-auto pt-1",
                  
                  div(p(class = "mb-0 font-sans font-semibold text-orange-700 text-opacity-75",
                        "Beneficiaries Reached",
                        
                        uiOutput("allBen", class="mb-0 font-bold text-orange-600 text-opacity-75 text-2xl text-left"),
                        div (class="px-3 text-right basis-1/3",
                             #div(class = "inline-block w-12 h-12 text-center rounded-full bg-orange-600 bg-opacity-25 pt-1 pl-1",
                             # "logo")
                        )))))),
      
      
      #Card2
      div(class = "w-full max-w-full px-4 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/5",
          div(class = "flex shadow-lg items-center p-2 bg-white border-l-4 border-orange-600 rounded-sm bg-clip-border",
              div(class = "flex-auto pt-1",
                  div(class = "flex flex-row -mx-3",
                      div(class = "flex-none w-2/3 max-w-full px-3",
                          div(p(class = "mb-0 font-sans font-semibold text-orange-700 text-opacity-75",
                                "Women Reached"),
                              uiOutput("women", class="mb-0 font-bold text-orange-600 text-opacity-75 text-2xl text-left"),
                              
                              # span(class = "leading-normal text-size-sm font-weight-bolder text-lime-500",
                              #  "+55%"),
                              # div(class = "inline-block w-12 h-12 text-center rounded-full bg-orange-600 bg-opacity-25 pt-1 pl-1",
                              #  "")
                              
                          )))))),
      
      #Card3
      div(class = "w-full max-w-full px-4 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/5",
          div(class = "flex shadow-lg items-center p-2 bg-white border-l-4 border-orange-600 rounded-sm bg-clip-border",
              div(class = "flex-auto pt-1",
                  div(class = "flex flex-row -mx-3",
                      div(class = "flex-none w-2/3 max-w-full px-3",
                          div(p(class = "mb-0 font-sans font-semibold text-orange-700 text-opacity-75",
                                "Men Reached"),
                              uiOutput("men", class="mb-0 font-bold text-orange-600 text-opacity-75 text-2xl text-left"),
                              
                              # span(class = "leading-normal text-size-sm font-weight-bolder text-lime-500",
                              #  "+55%"),
                              #div(class = "inline-block w-12 h-12 text-center rounded-full bg-orange-600 bg-opacity-25 pt-1 pl-1",
                              #  "")
                              
                          )))))),
      
      
      #Card4
      div(class = "w-full max-w-full px-4 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/5",
          div(class = "flex shadow-lg items-center p-2 bg-white border-l-4 border-orange-600 rounded-sm bg-clip-border",
              div(class = "flex-auto pt-1",
                  div(class = "flex flex-row -mx-3",
                      div(class = "flex-none w-2/3 max-w-full px-3",
                          div(p(class = "mb-0 font-sans font-semibold text-orange-700 text-opacity-75",
                                "Girls Reached"),
                              uiOutput("girls", class="mb-0 font-bold text-orange-600 text-opacity-75 text-2xl text-left"),
                              # span(class = "leading-normal text-size-sm font-weight-bolder text-lime-500",
                              #  "+55%"),
                              #div(class = "inline-block w-12 h-12 text-center rounded-full bg-orange-600 bg-opacity-25 pt-1 pl-1",
                              # "")
                              
                          )))))),
      #Card5
      div(class = "w-full max-w-full px-4 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/5",
          div(class = "flex shadow-lg items-center p-2 bg-white border-l-4 border-orange-600 rounded-sm bg-clip-border",
              div(class = "flex-auto pt-1",
                  div(class = "flex flex-row -mx-3",
                      div(class = "flex-none w-2/3 max-w-full px-3",
                          
                          div(p(class = "mb-0 font-sans font-semibold text-orange-700 text-opacity-75",
                                "Boys Reached"),
                              uiOutput("calboys", class="mb-0 font-bold text-orange-600 text-opacity-75 text-2xl text-left"),
                              # span(class = "leading-normal text-size-sm font-weight-bolder text-lime-500",
                              #  "+55%"),
                              
                              #div(class = "inline-block w-12 h-12 text-center rounded-full bg-orange-600 bg-opacity-25 pt-1 pl-1",
                              # "")
                              
                          ))))))
      
  ),
  #<!--KPI cards end-->
  
  
  
  #<!--First Card for charts-->
  
  
  div (class="flex sm:flex-no-wrap items-center justify-center mx-8  mt-5  border-t-4 border-orange-600 bg-white shadow-md rounded-lg",
       
       div (class="w-full sm:w-1/1 m-2 pt-3",   
            
            echarts4r::echarts4rOutput(outputId = "bar_chart"),
            
       ),
       
       div (class="w-full sm:w-1/1 m-2 pt-3", 
            
            echarts4r::echarts4rOutput(outputId = "bar_chartState"),
       ),
  ), 
  
  #<!--End of First Card for charts-->
  
  
  
  #<!--Second Card for charts-->
  
  
  div (class="flex sm:flex-no-wrap items-center justify-center ml-6 mr-8  mt-10  border-t-4 border-orange-600 bg-white shadow-md rounded-lg",
       
       div (class="flex flex-row w-full sm:w-1/1 m-2 pt-3",   
            
            echarts4r::echarts4rOutput(outputId = "bar_chartLGA"),
            
       ),
       
       div (class="flex flex-row w-full sm:w-1/1 m-2 pt-3", 
            
            echarts4r::echarts4rOutput(outputId = "bar_chartPop"),
       ),
  ), 
  
  
  #<!--End of second Card for charts-->
  
  
  #<!--Third Card for charts-->
  
  
  div (class="flex sm:flex-no-wrap items-center justify-center ml-6 mr-8  mt-10  border-t-4 border-orange-600 bg-white shadow-md rounded-lg",
       
       div (class="w-full sm:w-1/3 m-2 pt-3",   
            
            echarts4r::echarts4rOutput(outputId = "pie_chartOrg"),
            
       ),
       
       div (class="w-full sm:w-1/3 m-2 pt-3", 
            
            echarts4r::echarts4rOutput(outputId = "pie_chartHRP"),
       ),
       
       
       div (class="w-full sm:w-1/3 m-2 pt-3", 
            
            echarts4r::echarts4rOutput(outputId = "pie_chartStatus"),
       ),
  ), 
  #<!--End of Third Card for charts-->
  
  
  
  
  #<!--Fourth Card for charts-->
  
  
  div (class="flex sm:flex-no-wrap items-center justify-center ml-6 mr-8  mt-10  border-t-4 border-orange-600 bg-white shadow-md rounded-lg",
       
       div (class="w-full sm:w-1/3 m-2 pt-3",   
            
            echarts4r::echarts4rOutput(outputId = "bar_chartPartners"),
            
       ),
       
       div (class="w-full sm:w-1/3 m-2 pt-3", 
            
            echarts4r::echarts4rOutput(outputId = "barChartGender"),
       ),
       
       
       div (class="w-full sm:w-1/3 m-2 pt-3", 
            
            echarts4r::echarts4rOutput(outputId = "bar_chartDonors"),
       ),
  ), 
  br(), br(),
  div(class = "divide-y divide-gray-300 ",
      div(), div()),
  br(),
  div(class = "flex item-center justify-center",
      br(), p(class="mr-5 pt-4 font-semibold text-orange-600", "Supported by:"),
      img (src="immap_logo.png", alt="logo", height="55px", width="200px" ),
  ),
  
  br(),
  #<!--End of fourth Card for charts-->
  
  
  
)#<--Body tag ends-->