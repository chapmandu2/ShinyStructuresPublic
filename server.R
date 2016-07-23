
source('helper.R')


shinyServer(function(input, output) {
    
    output$test_text <- renderText({input$col_select})
    
    import_data <- reactive({
            out <- try( readr::read_tsv(input$data_file$datapath), silent=TRUE )
            if('data.frame' %in% class(out)) {
                return(out)
            } else {
                return(NULL)
            }
    })
    
    data <- reactive({
        if(!is.null(import_data())){
            import_data()  
        } else {
            getData() 
        }  
    })
    
    process_data <- reactive({
        
        #do we have custom data? 
        custom_data_lgl <- !is.null(import_data())  
        #either import the custom data or get the example data
        dat <- data()
        #consider NULL and none the same
        structure_col <- ifelse(is.null(input$col_select), 'none', input$col_select) 
        #if we don't have custom data, and no col is selected, specify MOLFILE as structure col
        structure_col <- ifelse(!custom_data_lgl & structure_col == 'none', 'MOLFILE', structure_col) 
 
        if(structure_col != 'none') {
            dat <- dat %>% 
                dplyr::rename_(sel_col=structure_col) %>%
                dplyr::mutate(structure=makeChemDoodleMolfile(sel_col, row_number())) %>%
                dplyr::select(-sel_col)
    }
    return(dat)
    })
    
    output$dt <- DT::renderDataTable({
        dat <- process_data()
        DT::datatable(dat, escape=which(colnames(dat)!='structure'))  #need to ensure that columns containing HTML/Javascript aren't escaped
            })
    
    output$col_select <- renderUI({
        selectInput('col_select', 'Select Molfile Column', choices=c('none', colnames(data())), selected='none')
        
    })
    
})
