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
      e_title("Total Beneficiaries Reached by Implementing Partners (Top 10)", textStyle = list(fontSize = 13, fontWeight="bold"), left="10%") %>% 
      e_grid( top = 30, bottom=40) %>% 
      e_legend(show = FALSE) %>% 
      e_flip_coords() %>%  #To flip your bar chart
      e_y_axis(inverse=TRUE) %>% #To sort your bar chart from highest to lowest
      e_labels(show = TRUE, position = "outside", fontSize = 8, color="#e69058") %>% 
      e_x_axis(axisLabel = FALSE, splitLine = FALSE) %>% 
      e_y_axis(axisLabel = list(fontSize = 10, color = "gray"), axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058"))) %>% 
      e_show_loading()
  })
  
  
  
  #Beneficiaries Reached by Implementing partners
  output$bar_chartPartners <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(imp.acronym) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>% 
      #filter(total_beneficiaries >= 286) %>% 
      arrange(desc(total_beneficiaries)) %>% 
      e_charts(imp.acronym) %>% 
      e_bar(serie = total_beneficiaries, color= "#dd6b20", name = "Total Beneficiaries", fontSize = 7, animation = TRUE, animationThreshold = "4000", animationDuration="1300") %>%
      e_tooltip("item") %>% 
      e_title("Beneficiaries Reached by Implementing Partners", textStyle = list(fontSize = 13, fontWeight="bold"), left="center") %>% 
      e_grid( top = 40, bottom=50) %>% 
      e_legend(show = FALSE) %>% 
      #e_flip_coords() %>%  #To flip your bar chart
      #e_y_axis(inverse=TRUE) %>% #To sort your bar chart from highest to lowest
      #e_labels(show = TRUE, position = "inside", fontSize = 8, color="#e69058") %>% 
      e_y_axis(axisLabel = list(fontSize = 8, color = "gray"), max = "dataMax", splitLine = list(show=TRUE, lineStyle = list(width = "0.7", type= "dashed"))) %>% 
      e_x_axis(axisLabel = list(fontSize = 9, color = "gray", rotate = 45), axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058"))) %>% 
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
      e_title("Number Beneficiaries Reached by LGA", textStyle = list(fontSize = 13, fontWeight="bold"), left="10%") %>% 
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
    
    
    
    #if(input$filterState == 'All') 
    #er
    #else 
    er %>%
      # filter(state == input$filterState) %>% 
      group_by(state) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>%
      arrange(desc(total_beneficiaries)) %>% 
      e_charts(state) %>% 
      e_bar(serie = total_beneficiaries, color= "#dd6b20",  name = "Number of Beneficiaries", fontSize = 7, barWidth ="30%") %>%
      e_tooltip("item") %>% 
      e_title("Number Beneficiaries Reached by State", textStyle = list(fontSize = 13, fontWeight="bold"), left="10%") %>% 
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
      e_title("Reached by Organisation Type", textStyle = list(fontSize = 13, fontWeight="bold"), left="center") %>% 
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
      e_title("Beneficiaries Reached Project Type", textStyle = list(fontSize = 13, fontWeight="bold"), left="center") %>% 
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
      e_title("Total Reached by Beneficiary Status", textStyle = list(fontSize = 13, fontWeight="bold"), left="center") %>% 
      e_grid( top = 50, bottom=30)
    
  })
  
  output$barChartGender <- echarts4r::renderEcharts4r({
    er %>% 
      group_by(state) %>% 
      #summarise(total_beneficiaries = sum(total_beneficiaries)) %>%
      summarise(totalmen = sum(men_18_59, na.rm = TRUE), totalwomen = sum(women_18_59, na.rm = TRUE), 
                totalgirls = sum(girls_6_17, na.rm = TRUE), totalboys = sum(boys_6_17, na.rm = TRUE))%>% 
      e_charts(state) %>% 
      e_bar(totalwomen, name = "Women", color = "#efa482") %>% 
      e_bar(totalmen, name = "Men", color = "#cc661e") %>% 
      e_bar(totalgirls, name = "Girls", color = "#68320d" ) %>% 
      e_bar(totalboys, name ="Boys", color = "#ff9c25") %>% 
      e_tooltip() %>% 
      #e_toolbox_feature("saveAsImage") %>% 
      e_legend(icons = list("circle", "circle", "circle", "circle"), top="bottom") %>% 
      e_title("Beneficiaries Reached by Gender & Age", textStyle = list(fontSize = 13, fontWeight="bold"), left="center") %>% 
      #e_labels(show = TRUE, position = "outside", fontSize = 8, color="#e69058") %>% 
      e_y_axis(axisLabel = list(fontSize = 8, color = "gray"), splitLine = list(show=TRUE, lineStyle = list(width = "0.7", type= "dashed"))) %>% 
      e_x_axis(axisLabel = list(fontSize = 10, color = "gray"),  axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058"))) %>% 
      e_grid( top = 40, bottom=50)
  })
  
  #Beneficiaries Reached by Population Group
  output$bar_chartPop <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(pop_group) %>% 
      summarise(total_beneficiaries =sum(total_beneficiaries)) %>% 
      arrange(desc(total_beneficiaries)) %>% 
      e_charts(pop_group) %>% 
      e_bar(serie = total_beneficiaries, color= "#dd6b20", name = "Number of Beneficiaries", fontSize = 7, barWidth="50%") %>%
      e_tooltip("item") %>% 
      e_title("Beneficiaries Reached By Population Group", textStyle = list(fontSize = 13, fontWeight="bold"), left="10%") %>% 
      e_grid( top = 40, bottom=30) %>% 
      e_legend(show = FALSE) %>% 
      e_labels(show = TRUE, position = "insideBottom", fontSize = 8, color="#dd6b20") %>% 
      e_y_axis(axisLabel = list(fontSize = 8, color = "gray", interval = 0),  splitLine = list(show=TRUE, lineStyle = list(width = "0.7", type= "dashed"))) %>% 
      e_x_axis(axisLabel = list(fontSize = 10, color = "gray", interval =0), axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058"))) %>% 
      e_show_loading()
  })
  
  #Beneficiaries Reached by Donor Project
  output$bar_chartDonors <- echarts4r::renderEcharts4r({
    
    er %>% 
      group_by(fin.partner) %>% 
      summarise(total_beneficiaries = sum(total_beneficiaries)) %>% 
      arrange(desc(total_beneficiaries)) %>% 
      e_charts(fin.partner) %>% 
      e_bar(serie = total_beneficiaries, color= "#dd6b20", name = "Total Beneficiaries", fontSize = 7, animation = TRUE, animationThreshold = "4000", animationDuration="1300") %>%
      e_tooltip("item") %>% 
      e_title("Beneficiaries Reached by Donor Project", textStyle = list(fontSize = 13, fontWeight="bold"), left="center") %>% 
      e_grid( top = 40, bottom=50) %>% 
      e_legend(show = FALSE) %>% 
      #e_flip_coords() %>%  #To flip your bar chart
      #e_y_axis(inverse=TRUE) %>% #To sort your bar chart from highest to lowest
      #e_labels(show = TRUE, position = "inside", fontSize = 8, color="#e69058") %>% 
      e_y_axis(axisLabel = list(fontSize = 8, color = "gray"), max = "dataMax", splitLine = list(show=TRUE, lineStyle = list(width = "0.7", type= "dashed"))) %>% 
      e_x_axis(axisLabel = list(fontSize = 9, color = "gray", rotate = 45), axisTick = list(lineStyle=list(color = "#e69058")), axisLine= list(lineStyle = list(color = "#e69058"))) %>% 
      e_show_loading()
  })
  
}

shinyApp(ui, server)
