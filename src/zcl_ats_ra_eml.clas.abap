CLASS zcl_ats_ra_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: lv_opr TYPE c VALUE 'R'.
    INTERFACES if_oo_adt_classrun.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ats_ra_eml IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    CASE lv_opr.
        when 'R'.

            READ ENTITIES OF zats_ra_travel
            ENTITY TRAVEL
*            ALL FIELDS WITH
            FIELDS ( TravelId AgencyId ) WITH
            VALUE #( ( TravelId = '01' )
                     ( TravelId = '02' )
                     ( TravelId = '03' )
            )
            RESULT data(lt_result)
            FAILED data(lt_failed)
            REPORTED data(lf_messages).

            out->write(
              EXPORTING
                data   = lt_result
            ).

           out->write(
              EXPORTING
                data   = lt_failed
            ).



        when 'C'.
        when 'U'.
        when 'D'.
    ENDCASE.




  ENDMETHOD.


ENDCLASS.
