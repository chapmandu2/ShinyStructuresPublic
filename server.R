
source('helper.R')


shinyServer(function(input, output) {
    
    output$test_text <- renderText({input$col_select})
    
    import_data <- reactive({
            out <- try( readr::read_tsv(input$data_file$datapath), silent=TRUE )
            if('data.frame' %in% class(out)) {
                return(out)
            } else {
                return(getData())
            }
    })
    
    process_data <- reactive({
        
        dat <- import_data()
        structure_col <- input$col_select
        
        if (!is.null(structure_col)) {
            if(structure_col != 'none') {
                dat <- dat %>% 
                    dplyr::rename_(sel_col=structure_col) %>%
                    dplyr::mutate(structure=makeChemDoodleMolfile(sel_col, row_number())) %>%
                    dplyr::select(-sel_col)
        }}
        return(dat)
    })
    
    output$dt <- DT::renderDataTable({
        dat <- process_data()
        DT::datatable(dat, escape=which(colnames(dat)!='structure'))  #need to ensure that columns containing HTML/Javascript aren't escaped
            })
    
    output$col_select <- renderUI({
        selectInput('col_select', 'Select Molfile Column', choices=c('none', colnames(import_data())), selected='none')
        
    })
    
})
