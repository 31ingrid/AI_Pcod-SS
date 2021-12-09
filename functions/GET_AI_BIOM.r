# adapted/generalized from Steve Barbeaux' files for
# generating SS files for EBS/AI Greenland Turbot
# ZTA, 2013-05-08, R version 2.15.1, 32-bit

GET_AI_BIOM <- function(srv_sp_str="21720")
{
    test<-paste("SELECT AI.BIOMASS_TOTAL.YEAR as YEAR,\n ",
                "AI.BIOMASS_TOTAL.TOTAL_BIOMASS as BIOM,\n ",
                "AI.BIOMASS_TOTAL.TOTAL_POP as POP,\n ",
                "AI.BIOMASS_TOTAL.BIOMASS_VAR as BIOMVAR,\n ",
                "AI.BIOMASS_TOTAL.POP_VAR as POPVAR,\n ",
                "AI.BIOMASS_TOTAL.HAUL_COUNT as NUMHAULS,\n ",
                "AI.BIOMASS_TOTAL.CATCH_COUNT as NUMCAUGHT\n ",
                "FROM AI.BIOMASS_TOTAL\n ",
                "WHERE AI.BIOMASS_TOTAL.SPECIES_CODE in (",srv_sp_str,")\n ",
                "ORDER BY AI.BIOMASS_TOTAL.YEAR",sep="")

    biom <- sqlQuery(AFSC,test)

    # this calculation assumes that YEAR is the first column for biom
    sum.biom <- aggregate(biom[,-1],by=list(YEAR=biom$YEAR),FUN=sum)
    sum.biom

}

