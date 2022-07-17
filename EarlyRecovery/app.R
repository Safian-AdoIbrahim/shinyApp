library(shiny)
library(dplyr)
library(echarts4r)
library(tidyverse)
library(echarts4r.maps)

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
            <!-- Mobile -->
           <!-- <div id="mobile-nav" class="w-full xl:hidden h-full absolute z-40">
                <div class="bg-gray-800 opacity-50 inset-0 fixed w-full h-full" onclick="sidebarHandler(false)"></div>
                <div class="w-64 z-20 absolute left-0 z-40 top-0 bg-white shadow flex-col justify-between transition duration-150 ease-in-out h-full">
                    <div class="flex flex-col justify-between h-full">
                        <div class="px-6 pt-4 overflow-y-auto">
                            <div class="flex items-center justify-between">
                                <div aria-label="Home" role="img" class="flex items-center">
                                    <img src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg1.svg" alt="logo">
                                    <p class="text-bold md:text2xl text-base pl-3 text-gray-800">The North</p>
                                </div>
                                <button id="cross" class="hidden text-gray-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-800 rounded" onclick="sidebarHandler(false)">
                                    <img src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg2.svg" alt="cross">
                                </button>
                            </div>
                            <ul class="f-m-m">
                                <li class="text-white pt-8">
                                    <div class="flex items-center">
                                        <div class="md:w-6 md:h-6 w-5 h-5">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none">
                                                <path d="M7.16667 3H3.83333C3.3731 3 3 3.3731 3 3.83333V7.16667C3 7.6269 3.3731 8 3.83333 8H7.16667C7.6269 8 8 7.6269 8 7.16667V3.83333C8 3.3731 7.6269 3 7.16667 3Z" stroke="#667EEA" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                                <path d="M7.16667 11.6667H3.83333C3.3731 11.6667 3 12.0398 3 12.5V15.8333C3 16.2936 3.3731 16.6667 3.83333 16.6667H7.16667C7.6269 16.6667 8 16.2936 8 15.8333V12.5C8 12.0398 7.6269 11.6667 7.16667 11.6667Z" stroke="#667EEA" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                                <path d="M16.1667 11.6667H12.8333C12.3731 11.6667 12 12.0398 12 12.5V15.8334C12 16.2936 12.3731 16.6667 12.8333 16.6667H16.1667C16.6269 16.6667 17 16.2936 17 15.8334V12.5C17 12.0398 16.6269 11.6667 16.1667 11.6667Z" stroke="#667EEA" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                                <path d="M16.1667 3H12.8333C12.3731 3 12 3.3731 12 3.83333V7.16667C12 7.6269 12.3731 8 12.8333 8H16.1667C16.6269 8 17 7.6269 17 7.16667V3.83333C17 3.3731 16.6269 3 16.1667 3Z" stroke="#667EEA" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                            </svg>
                                        </div>
                                        <a href="javascript:void(0)" class="text-indigo-500 ml-3 text-lg">Dashboard</a>
                                    </div>
                                </li>
                                <li class="text-gray-700 pt-8">
                                    <div class="flex items-center">
                                        <div class="flex items-center">
                                            <div class="md:w-6 md:h-6 w-5 h-5">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 18 18" fill="none">
                                                    <path
                                                        d="M2.33333 4.83333H4.83333C5.05435 4.83333 5.26631 4.74554 5.42259 4.58926C5.57887 4.43298 5.66667 4.22101 5.66667 4V3.16667C5.66667 2.72464 5.84226 2.30072 6.15482 1.98816C6.46738 1.67559 6.89131 1.5 7.33333 1.5C7.77536 1.5 8.19928 1.67559 8.51184 1.98816C8.8244 2.30072 9 2.72464 9 3.16667V4C9 4.22101 9.0878 4.43298 9.24408 4.58926C9.40036 4.74554 9.61232 4.83333 9.83333 4.83333H12.3333C12.5543 4.83333 12.7663 4.92113 12.9226 5.07741C13.0789 5.23369 13.1667 5.44565 13.1667 5.66667V8.16667C13.1667 8.38768 13.2545 8.59964 13.4107 8.75592C13.567 8.9122 13.779 9 14 9H14.8333C15.2754 9 15.6993 9.17559 16.0118 9.48816C16.3244 9.80072 16.5 10.2246 16.5 10.6667C16.5 11.1087 16.3244 11.5326 16.0118 11.8452C15.6993 12.1577 15.2754 12.3333 14.8333 12.3333H14C13.779 12.3333 13.567 12.4211 13.4107 12.5774C13.2545 12.7337 13.1667 12.9457 13.1667 13.1667V15.6667C13.1667 15.8877 13.0789 16.0996 12.9226 16.2559C12.7663 16.4122 12.5543 16.5 12.3333 16.5H9.83333C9.61232 16.5 9.40036 16.4122 9.24408 16.2559C9.0878 16.0996 9 15.8877 9 15.6667V14.8333C9 14.3913 8.8244 13.9674 8.51184 13.6548C8.19928 13.3423 7.77536 13.1667 7.33333 13.1667C6.89131 13.1667 6.46738 13.3423 6.15482 13.6548C5.84226 13.9674 5.66667 14.3913 5.66667 14.8333V15.6667C5.66667 15.8877 5.57887 16.0996 5.42259 16.2559C5.26631 16.4122 5.05435 16.5 4.83333 16.5H2.33333C2.11232 16.5 1.90036 16.4122 1.74408 16.2559C1.5878 16.0996 1.5 15.8877 1.5 15.6667V13.1667C1.5 12.9457 1.5878 12.7337 1.74408 12.5774C1.90036 12.4211 2.11232 12.3333 2.33333 12.3333H3.16667C3.60869 12.3333 4.03262 12.1577 4.34518 11.8452C4.65774 11.5326 4.83333 11.1087 4.83333 10.6667C4.83333 10.2246 4.65774 9.80072 4.34518 9.48816C4.03262 9.17559 3.60869 9 3.16667 9H2.33333C2.11232 9 1.90036 8.9122 1.74408 8.75592C1.5878 8.59964 1.5 8.38768 1.5 8.16667V5.66667C1.5 5.44565 1.5878 5.23369 1.74408 5.07741C1.90036 4.92113 2.11232 4.83333 2.33333 4.83333"
                                                        stroke="currentColor"
                                                        stroke-width="1"
                                                        stroke-linecap="round"
                                                        stroke-linejoin="round"
                                                    />
                                                </svg>
                                            </div>
    
                                            <a href="javascript:void(0)" class="text-gray-700 ml-3 text-lg">Products</a>
                                        </div>
                                        <button id="chevronup" onclick="listHandler(true)" class="ml-4 focus:outline-none focus:ring-2 focus:ring-gray-500 rounded">
                                            <img src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg4.svg" alt="up">
                                        </button>
                                        <button id="chevrondown" onclick="listHandler(false)" class="hidden ml-4 focus:outline-none focus:ring-2 focus:ring-gray-500 rounded ">
                                            <img class="transform rotate-180" src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg4.svg" alt="down">
                                        </button>
                                    </div>
                                    <div id="list" class="hidden">
                                        <ul class="my-3">
                                            <li class="text-sm text-indigo-500 py-2 px-6"><a href="javascript:void(0)"> Best Sellers </a></li>
                                            <li class="text-sm text-gray-800 hover:text-indigo-500 py-2 px-6"><a href="javascript:void(0)"> Out of Stock</a></li>
                                            <li class="text-sm text-gray-800 hover:text-indigo-500 py-2 px-6"><a href="javascript:void(0)"> New Products</a></li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="text-gray-800 pt-8">
                                    <div class="flex items-center">
                                        <div class="md:w-6 md:h-6 w-5 h-5">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none">
                                                <path d="M6.66667 13.3333L8.33334 8.33334L13.3333 6.66667L11.6667 11.6667L6.66667 13.3333Z" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                                <path d="M10 17.5C14.1421 17.5 17.5 14.1421 17.5 10C17.5 5.85786 14.1421 2.5 10 2.5C5.85786 2.5 2.5 5.85786 2.5 10C2.5 14.1421 5.85786 17.5 10 17.5Z" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                            </svg>
                                        </div>
                                        <a href="javascript:void(0)" class="text-gray-800 ml-3 text-lg">Performance</a>
                                    </div>
                                </li>
                                <li class="text-gray-800 pt-8">
                                    <div class="flex items-center">
                                        <div class="flex items-center">
                                            <div class="md:w-6 md:h-6 w-5 h-5">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none">
                                                    <path d="M5.83333 6.66667L2.5 10L5.83333 13.3333" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                                    <path d="M14.1667 6.66667L17.5 10L14.1667 13.3333" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                                    <path d="M11.6667 3.33333L8.33333 16.6667" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" />
                                                </svg>
                                            </div>
                                            <a href="javascript:void(0)" class="text-gray-800 ml-3 text-lg">Deliverables</a>
                                        </div>
                                        <div>
                                            <button id="chevronup2" onclick="listHandler2(true)" class="ml-4 focus:outline-none focus:ring-2 focus:ring-gray-500 rounded">
                                                <img src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg4.svg" alt="up">
                                            </button>
                                            <button id="chevrondown2" onclick="listHandler2(false)" class="hidden ml-4 focus:outline-none focus:ring-2 focus:ring-gray-500 rounded">
                                                <img class="transform rotate-180" src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg4.svg" alt="down">
                                            </button>
                                        </div>
                                    </div>
                                    <div id="list2" class="hidden">
                                        <ul class="my-3">
                                            <li class="text-sm text-indigo-500 py-2 px-6"><a href="javascript:void(0)"> Best Sellers </a></li>
                                            <li class="text-sm text-gray-800 hover:text-indigo-500 py-2 px-6"><a href="javascript:void(0)"> Out of Stock</a></li>
                                            <li class="text-sm text-gray-800 hover:text-indigo-500 py-2 px-6"><a href="javascript:void(0)"> New Products</a></li>
                                        </ul>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="w-full">
                            <div class="flex justify-center mb-4 w-full px-6">
                                <div class="relative w-full">
                                    <div class="text-gray-600 absolute ml-4 inset-0 m-auto w-4 h-4">
                                        <img src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg3.svg" alt="search">
                                    </div>
                                    <input class="bg-gray-100 focus:outline-none rounded w-full text-sm text-gray-500 placeholder-gray-600 bg-gray-100 pl-10 py-2" type="text" placeholder="Search" />
                                </div>
                            </div>
                            <div class="border-t border-gray-300">
                                <div class="w-full flex items-center justify-between px-6 pt-1">
                                 
                                    <ul class="flex">
                                        <li class="cursor-pointer text-white pt-5 pb-3">
                                            <a href="javascript:void(0)"> 
                                                <img src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg5.svg" alt="message">
                                            </a>
                                        </li>
                                        <li class="cursor-pointer text-white pt-5 pb-3 pl-3">
                                            <a href="javascript:void(0)"> 
                                                <img src="https://tuk-cdn.s3.amazonaws.com/can-uploader/light_with_Grey_background-svg6.svg" alt="notifications">
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>-->
            <!-- Mobile -->
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
  
        #<!--KPI Cards -->
 
  div(class = "flex flex-wrap mx-3 mt-6",
      
      #Card1
      div(class = "w-full max-w-full px-4 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/5",
          div(class = "flex flex-row shadow-lg p-2 bg-white border-l-4 border-orange-600 rounded-sm bg-clip-border",
              div(class = "flex-auto pt-1",
                 
                          div(p(class = "mb-0 font-sans font-semibold text-orange-700 text-opacity-75",
                                "Beneficiaries Reached",
                             
                                 uiOutput("allBen", class="mb-0 font-bold text-orange-600 text-opacity-75 text-2xl text-left"),
                                div (class="px-3 text-right basis-1/3",
                                #div(class = "inline-block w-12 h-12 text-center rounded-full bg-orange-600 bg-opacity-25 pt-1 pl-1 text-right",
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


  div (class="flex sm:flex-no-wrap items-center justify-center ml-6 mr-8  mt-10  border-t-4 border-orange-600 bg-white shadow-md rounded-lg",
   
       div (class="w-full sm:w-1/2 m-2 pt-3",   
            
            echarts4r::echarts4rOutput(outputId = "bar_chart"),
            
            ),
       
       div (class="w-full sm:w-1/2 m-2 pt-3", 
            
            echarts4r::echarts4rOutput(outputId = "bar_chartState"),
            ),
  ), 
  
#<!--End of First Card for charts-->



#<!--Second Card for charts-->


div (class="flex sm:flex-no-wrap items-center justify-center ml-6 mr-8  mt-10  border-t-4 border-orange-600 bg-white shadow-md rounded-lg",
     
     div (class="w-full sm:w-1/2 m-2 pt-3",   
          
          echarts4r::echarts4rOutput(outputId = "bar_chartLGA"),
          
     ),
     
     div (class="w-full sm:w-1/2 m-2 pt-3", 
          
          echarts4r::echarts4rOutput(outputId = "bar_chart2"),
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

br(), br(),
#<!--End of Third Card for charts-->




)#<--Body tag ends-->

server <- function(input, output, session) {
  
  
  # Render the Bar Chart
  output$bar_chart <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(imp.acronym) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>% 
      filter(total_beneficiaries >= 286) %>% 
      arrange(desc(total_beneficiaries)) %>% 
      e_charts(imp.acronym) %>% 
      e_bar(serie = total_beneficiaries, color= "#dd6b20", name = "Total Beneficiaries", fontSize = 7) %>%
      e_tooltip("item") %>% 
      e_title("Total Beneficiaries Reached by Implementing Partners (Top 10)", textStyle = list(fontSize = 13, fontWeight="normal"), left="10%") %>% 
      e_grid( top = 30, bottom=40) %>% 
      e_legend(show = FALSE) %>% 
      e_flip_coords() %>%  #To flip your bar chart
      e_y_axis(inverse=TRUE) %>% #To sort your bar chart from highest to lowest
      e_labels(show = TRUE, position = "outside", fontSize = 8, color="#e69058") %>% 
      e_x_axis(axisLabel = FALSE, splitLine = FALSE) %>% 
      e_y_axis(axisLabel = list(fontSize = 10, color = "gray"), axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058"))) %>% 
      e_show_loading()
  })
  
  
  
  
  output$bar_chart2 <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(imp.acronym) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>% 
      filter(total_beneficiaries >= 286) %>% 
      arrange(desc(total_beneficiaries)) %>% 
      e_charts(imp.acronym) %>% 
      e_bar(serie = total_beneficiaries, color= "#dd6b20", name = "Total Beneficiaries", fontSize = 7, animation = TRUE, animationThreshold = "4000", animationDuration="1300") %>%
      e_tooltip("item") %>% 
      e_title("Beneficiaries Reached by Implementing Partners (Top 10)", textStyle = list(fontSize = 13, fontWeight="normal"), left="10%") %>% 
      e_grid( top = 50, bottom=40) %>% 
      e_legend(show = FALSE) %>% 
      #e_flip_coords() %>%  #To flip your bar chart
      #e_y_axis(inverse=TRUE) %>% #To sort your bar chart from highest to lowest
      e_labels(show = TRUE, position = "inside", fontSize = 8, color="#e69058") %>% 
      e_y_axis(axisLabel = list(fontSize = 8, color = "gray"), max = "dataMax", splitLine = list(show=TRUE, lineStyle = list(width = "0.7", type= "dashed"))) %>% 
      e_x_axis(axisLabel = list(fontSize = 10, color = "gray"), axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058"))) %>% 
      e_show_loading()
  })
  
  output$calboys <- renderUI({
    cal <- er %>% 
      summarise(sumBoys = sum(boys_6_17, na.rm = TRUE))
      format(cal$sumBoys, big.mark = ",", scientific = FALSE)
    
    })
 
  
  output$allBen <- renderUI({
    totalBen <- er %>% 
      summarise(allBeneficiaries = sum(total_beneficiaries, na.rm = TRUE))
      format(totalBen$allBeneficiaries, big.mark = ",", scientific = FALSE)
    
  }) 
  
  
  output$women <- renderUI({
    totalWomen <- er %>% 
      summarise(allWomen = sum(women_18_59, na.rm = TRUE)) 
      format(totalWomen$allWomen, big.mark = ",", scientific = FALSE)
    
  }) 
  
  
  output$men <- renderUI({
    totalMen <- er %>% 
      summarise(allMen = sum(men_18_59, na.rm = TRUE))
    format(totalMen$allMen, big.mark = ",", scientific = FALSE)
    
  }) 
  
  
  output$girls <- renderUI({
    totalGirls <- er %>% 
      summarise(allGirls = sum(girls_6_17, na.rm = TRUE))
      format(totalGirls$allGirls, big.mark = ",", scientific = FALSE)
  }) 

  
  output$bar_chartLGA <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(lga) %>% 
      summarise(total_beneficiaries =sum(total_beneficiaries)) %>% 
      filter(total_beneficiaries >= 601) %>% 
      arrange(desc(total_beneficiaries)) %>% 
      e_charts(lga) %>% 
      e_bar(serie = total_beneficiaries, color= "#dd6b20", name = "Number of Beneficiaries", fontSize = 7) %>%
      e_tooltip("item") %>% 
      e_title("Number Beneficiaries Reached by LGA", textStyle = list(fontSize = 13, fontWeight="normal"), left="10%") %>% 
      e_grid( top = 30, bottom=30) %>% 
      e_legend(show = FALSE) %>% 
      e_flip_coords() %>%  #To flip your bar chart
      e_y_axis(inverse=TRUE) %>% #To sort your bar chart from highest to lowest
      e_labels(show = TRUE, position = "outside", fontSize = 8, color="#e69058") %>% 
      e_x_axis(axisLabel = list(fontSize = 8, color = "gray"), max = "dataMax", splitLine = list(show=TRUE, lineStyle = list(width = "0.7", type= "dashed"))) %>% 
      e_y_axis(axisLabel = list(fontSize = 10, color = "gray"), axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058"))) %>% 
      e_show_loading()
  })
  
  
  
  output$bar_chartState <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(state) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>%
      arrange(desc(total_beneficiaries)) %>% 
      e_charts(state) %>% 
      e_bar(serie = total_beneficiaries, color= "#dd6b20",  name = "Number of Beneficiaries", fontSize = 7, barWidth ="40%") %>%
      e_tooltip("item") %>% 
      e_title("Number Beneficiaries Reached by State", textStyle = list(fontSize = 13, fontWeight="normal"), left="10%") %>% 
      e_grid( top = 50, bottom=30) %>% 
      e_legend(show = FALSE) %>% 
      #e_flip_coords() %>%  #To flip your bar chart
      #e_y_axis(inverse=TRUE) %>% #To sort your bar chart from highest to lowest
      e_labels(show = TRUE, position = "inside", fontSize = 8, color="#e69058") %>% 
      e_y_axis(axisLabel = list(fontSize = 8, color = "gray"), splitLine = list(show=TRUE, lineStyle = list(width = "0.7", type= "dashed"))) %>% 
      e_x_axis(axisLabel = list(fontSize = 10, color = "gray"),  axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058")))

  })
  
  
  output$pie_chartOrg <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(org_category) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>% 
      e_charts(org_category) %>% 
      e_pie(total_beneficiaries, name = "Total Beneficiaries", radius = c("50%", "70%"), color = list("#cc661e", "#efa482", "#a65017")) %>% 
      e_labels(show = TRUE,
               formatter = "{b}\n {d}%",
               position = "outside") %>% 
      e_legend(top = "bottom")%>%
      e_tooltip("item") %>% 
      e_title("Reached by Organisation Type", textStyle = list(fontSize = 13, fontWeight="normal"), left="center") %>% 
      e_grid( top = 50, bottom=30)

  })
  
  
  output$pie_chartHRP <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(HRP) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>% 
      e_charts(HRP) %>% 
      e_pie(total_beneficiaries, name = "Number of Beneficiaries", roseType= "area", color = list("#cc661e", "#efa482")) %>% 
      e_labels(show = TRUE,
               formatter = "{d}%",
               position = "outside") %>% 
      e_legend(top = "bottom")%>%
      e_tooltip("item") %>% 
      e_title("Beneficiaries Reached Project Type", textStyle = list(fontSize = 13, fontWeight="normal"), left="center") %>% 
      e_grid( top = 50, bottom=30)
    
  })
  
  output$pie_chartStatus <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(ben_status) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>% 
      e_charts(ben_status) %>% 
      e_pie(total_beneficiaries, name = "Beneficiaries", radius = c("50%", "70%"), roseType= "area", color = list("#cc661e", "#efa482")) %>% 
      e_labels(show = TRUE,
               formatter = "{d}%",
               position = "outside") %>% 
      e_legend(top = "bottom")%>%
      e_tooltip("item") %>% 
      e_title("Total Reached by Beneficiary Status", textStyle = list(fontSize = 13, fontWeight="normal"), left="center") %>% 
      e_grid( top = 50, bottom=30)
    
  })
  
  
  
  
}

shinyApp(ui, server)