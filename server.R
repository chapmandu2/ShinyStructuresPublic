
source('helper.R')


shinyServer(function(input, output) {
    
    output$test_text <- renderText({input$user_name})
    
    output$dt <- DT::renderDataTable({
        dat <- getData() %>% 
           # dplyr::mutate(structure=makeChemDoodleMolfile(MOLFILE, row_number())) %>%
            dplyr::select(-contains('MOLFILE'))

        DT::datatable(dat)  #need to ensure that columns containing HTML/Javascript aren't escaped
        
            })
    
})
