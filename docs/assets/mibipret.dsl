workspace "MibiPreT" "Micro Bioremediation Toolbox" {

    !identifiers hierarchical

    model {
        jpl = person "Scientist"
        co = person "Consultant"

        # jpl = softwareSystem "Jupyter Lab"

        mbp = softwareSystem "Mibipret" {
            mbs = container "Mibiscreen"
            mbt = container "Mibitrans"
            mbr = container "Mibiremo"
            mbb = container "Mibibio"
            ui = container "UI"

            db = container "Database Schema" {
                tags "Database"
            }
        }


        # sc -> jpl "Uses"
        co -> mbp.ui "Uses"
        mbp.ui -> mbp.mbs "Uses"
        mbp.ui -> mbp.mbt "Uses"
        jpl -> mbp.mbt "Uses"
        jpl -> mbp.mbr "Uses"
        jpl -> mbp.mbs "Uses"
        jpl -> mbp.mbb "Uses"


        mbp.mbt -> mbp.db "Reads from and writes to"
    }

    views {
        systemContext mbp {
            include *
        }

        container mbp {
            include *
        }


        styles {
            element "Element" {
                color #380339
                stroke #380339
                strokeWidth 7
                shape roundedbox
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
            element "Boundary" {
                color #009DDD
                stroke #009DDD
                strokeWidth 7
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