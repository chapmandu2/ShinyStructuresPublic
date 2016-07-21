
source('helper.R')


shinyServer(function(input, output) {
    
    output$test_text <- renderText({input$data_file$datapath})
    
    import_data <- reactive({

            out <- try( readr::read_tsv(input$data_file$datapath), silent=TRUE ) 
            
            if('data.frame' %in% class(out)) {
                return(out)
            } else {
                return(getData())
            }

    })
    
    output$dt <- DT::renderDataTable({
        dat <- import_data() %>% 
           # dplyr::mutate(structure=makeChemDoodleMolfile(MOLFILE, row_number())) %>%
            dplyr::select(-contains('MOLFILE'))

        DT::datatable(dat)  #need to ensure that columns containing HTML/Javascript aren't escaped
        
            })
    
    output$col_select <- renderUI({
        selectInput('col_select', 'select a column', choices=c('none', colnames(import_data())), selected='none')
        
    })
    
})
