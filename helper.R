#help functions for ShinyStructures app
library(shiny)
library(dplyr)
library(DT)


#function to get compound data from test database for a given user
getData <- function() {
    
    data <- readRDS('data/fdaapproved.RDS')
    
    return(data)
    
}

#generates a text string with the appropriate javascript to construct the ChemDoodle canvas
makeChemDoodleMolfile <- function(molfile, suff) {
    
    out <- sprintf("<canvas class='ChemDoodleWebComponent' id='viewACS%1$s' alt='ChemDoodle Web Component' >This browser does not support HTML5/Canvas.</canvas>
            <script>
            var viewACS%1$s = new ChemDoodle.ViewerCanvas('viewACS%1$s', 100,100);
            viewACS%1$s.specs.bonds_width_2D = .6;
            viewACS%1$s.specs.bonds_saturationWidth_2D = .18;
            viewACS%1$s.specs.bonds_hashSpacing_2D = 2.5;
            viewACS%1$s.specs.atoms_font_size_2D = 10;
            viewACS%1$s.specs.atoms_font_families_2D = ['Helvetica', 'Arial', 'sans-serif'];
            viewACS%1$s.specs.atoms_displayTerminalCarbonLabels_2D = true;
            var molfile%1$s = new String(`%2$s`);
            var mol%1$s = ChemDoodle.readMOL(molfile%1$s);
            viewACS%1$s.loadMolecule(mol%1$s);
            </script>
            ", suff, molfile)
    
}

