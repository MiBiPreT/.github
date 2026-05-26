workspace "MibiPreT" "Micro Bioremediation Toolbox" {

    !identifiers hierarchical

    model {
        rd = person "Researcher Developer"
        ex = person "Experimentalist"
        gu = person "General User"
        
        
        mbp = softwareSystem "Mibipret" {
            ui = container "Mibipret Web" {
                description ""
                tags WebBrowser
            }
            jl = container "Jupyter Lab" {
                description "Notebook interface to create workflows using "
                tags WebBrowser
                technology "Python, .pynb"
            }
            
            
            uib = container "UI Backend" {
                                
            }
            
            jlb = container "Backend" {
                description "Backend to run workflows"
                technology "Python, R"
            }
            

            mbs = container "Mibiscreen"{
                description "Analyse sample data, status quo, of non-biological factors "
                technology "Python"
            }

            mbt = container "Mibitrans"{
                description "Groundwater transport model library"
                technology "Python"

                sls = component SemiLagSolver1D {
                    description "One-dimensional numerical transport model"
                    technology "Python"
                }
                mbt = component Mibitrans {
                    description "Three dimensional semi-analytical transport model"
                    technology "Python"
                }
                bsc = component Bioscreen {
                    description "Three dimensional semi-analytical transport model"
                    technology "Python"
                }
                mf = component ModFlow {
                    description "Interface to Three dimensional numerical transport model MODFLOW"
                    technology "Python"
                }
            }

            mbr = container "Mibiremo" {
                description "Coupling transport models in mibitrans with PhreeqCRM"
                technology "Python"
            }

            mbb = container "Mibibio" {
                description "Analyse and visualize biological (qPCR) data"
                technology "R"
            }
            
            rdb = container "MIBIREM Reaction Database" {
                description "Storage for chemical and biological reactions and their rates"
                tags "Database"
                technology ""
            }
            
            yos = container "YODA object store" {
                description "Research data object store by SURF"
                tags "ObjectStore"
                technology "YODA"
            }
            
        }

        mf = softwareSystem "ModFlow"{
            description "Three dimensional numerical transport model"
            # technology "C++, Python"
            
            fp = container "FloPy"{
                description "Python interface to ModFlow"
                technology "python"
    
            }
    
            mf = container "ModFlow"{
                description "ModFlow transport model core"
                technology "C++"
    
            }
        }
        
        pcr = softwareSystem "PhreeqCRM"{
            description "PhreeqC Chemical Reaction Model in C++ including a Python interface"
            # technology "C++, Python"
        }
        
        
        rd -> mbp.jl "Composes workflow using"
        gu -> mbp.ui "Uses"
        
        mbp.ui -> mbp.uib "Uses"
        mbp.jl -> mbp.jlb "Uses"
        
        mbp.jlb -> mbp.mbs "Uses screening functionality from"
        mbp.jlb -> mbp.mbt "Uses transport models from"
        mbp.jlb -> mbp.mbr "Uses coupled chemical reaction and transport models from"
        mbp.jlb -> mbp.mbb "Uses microbiome analysis from"
        mbp.jlb -> mbp.yos "Loads fieldsite data from"
        
        mbp.mbt.mf -> mf.fp "Uses numerical 3D transport model from"
        
        mbp.mbr -> mbp.mbt "Uses transport models from"
        mbp.mbr -> pcr "Uses chemical reaction models from"
        mbp.mbr -> mbp.rdb "Reads chemical reactions from"
        
        mf.fp -> mf.mf "Uses transport models from"
        


    }

    views {
        systemContext mbp {
            include *
        }

        container mbp {
            include *
        }
        
        component mbp.mbt {
            include *
        }
        
        container mf {
            include *
        }
        
        styles {
            element "WebBrowser" {
                shape webbrowser
                color #380339
                stroke #380339
                strokeWidth 7
            }
            element "Folder" {
                color #380339
                stroke #380339
                strokeWidth 7
                shape folder
            }
            element "Container" {
                color #380339
                stroke #380339
                strokeWidth 7
                shape roundedbox
            }

            element "Software System" {
                color #009DDD
                stroke #009DDD
                strokeWidth 5
                shape box
            }
            element "Person" {
                color #FFB213
                stroke #FFB213
                strokeWidth 7
                shape person
            }
            element "Database" {
                color #380339
                stroke #380339
                strokeWidth 7
                shape cylinder
            }            
            element "ObjectStore" {
                color #380339
                stroke #380339
                strokeWidth 7
                shape folder
            }
            element "Boundary" {
                color #009DDD
                stroke #009DDD
                strokeWidth 5
            }
            relationship "Relationship" {
                thickness 4
            }
        }
    }
    

    configuration {
        scope landscape
        # visibility
        # users
        # properties
    }

}