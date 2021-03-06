This project is a toy example of a shiny app that depicts compound structures (from MOL files) using the [ChemDoodle web components framework](https://web.chemdoodle.com/) in a data table generated by the [DT R package](https://rstudio.github.io/DT/).  It was inspired by the [chemdoodle HTMLwidget](https://github.com/zachcp/chemdoodle) written by Zach Charlop-Powers and described in [this blog post](http://zachcp.org/blog/2016/sketcher_gadget/).

A nice implentation of this would be as a shiny widget that is an extension of DT for datatables.  This would allow R users to easily visualise tables of data that contain chemical information including the compound structure.  What isn't clear is how to implement a widget within a widget - ie a ChemDoodle widget within a datatable widget?

The shiny app can be downloaded and run by cloning the git repository, or it can be viewed here:
https://cruk-mi-ddu.shinyapps.io/ShinyStructuresPublic/

Select 'MOLFILE' from the 'Select Molfile Column' dropdown.
