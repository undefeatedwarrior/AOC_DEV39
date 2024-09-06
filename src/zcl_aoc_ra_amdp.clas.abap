CLASS zcl_aoc_ra_amdp DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    INTERFACES if_oo_adt_classrun .


    CLASS-METHODS add_numbers IMPORTING VALUE(a)      TYPE  i
                                        VALUE(b)      TYPE i
                              EXPORTING VALUE(result) TYPE i.


    CLASS-METHODS get_customer_by_id IMPORTING VALUE(i_bp_id) TYPE zats_xx_dte_id
                                     EXPORTING VALUE(e_res)   TYPE char40.


    CLASS-METHODS get_product_mrp IMPORTING VALUE(i_tax) TYPE i
                                  EXPORTING VALUE(otab)  TYPE zats_ra_tt_product_mrp.


    CLASS-METHODS get_total_sales FOR TABLE FUNCTION zats_ra_tf.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_aoc_ra_amdp IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    zcl_aoc_ra_amdp=>add_numbers(
      EXPORTING
        a      = 10
        b      = 20
      IMPORTING
        result = DATA(lv_res)
    ).

    out->write(
      EXPORTING
        data   =  | Result : { lv_res } |
    ).




    zcl_aoc_ra_amdp=>get_customer_by_id(
      EXPORTING
        i_bp_id = '46ADCA1FBFDB1EEF9A8DF7C4ABE12336'
      IMPORTING
        e_res   = DATA(lv_cust)
    ).

    out->write(
      EXPORTING
        data   = lv_cust
    ).



    zcl_aoc_ra_amdp=>get_product_mrp(
      EXPORTING
        i_tax = 8
      IMPORTING
        otab  = DATA(out_mrp)
    ).


    out->write(
      EXPORTING
        data   = out_mrp
    ).


  ENDMETHOD.


  METHOD add_numbers BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.

    DECLARE x INTEGER;
    DECLARE y INTEGER;

    x := a;
    y := b;

    result := :x + :y;

  ENDMETHOD.


  METHOD get_customer_by_id BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zats_ra_bpa.

    select company_name into e_res from zats_ra_bpa where bp_id = i_bp_id;

  ENDMETHOD.


  METHOD get_product_mrp BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zats_ra_product.


    declare lv_count integer;
    declare i integer;
    declare lv_mrp bigint;
    declare lv_price_d integer;


*   Get All Product in a table
    lt_prod = select * from zats_ra_product;

*   Get the record count
    lv_count := record_count( :lt_prod );


*   loop at each record one by one and calculate the price after discount (dbtable)
    for i in 1..:lv_count do
*   calculate the MRP based on input tax
        lv_price_d := :lt_prod.price[i] * ( 100 - :lt_prod.discount[i] ) / 100;
        lv_mrp := :lv_price_d * ( 100 + :i_tax ) / 100;
*   if the MRP is more than 15k, an additional 10% discount to be applied
        if lv_mrp > 15000 then
            lv_mrp := :lv_mrp * 0.90;
        END IF ;
*   fill the otab for result (like in abap we fill another internal table with data)
        :otab.insert( (
                          :lt_prod.name[i],
                          :lt_prod.category[i],
                          :lt_prod.price[i],
                          :lt_prod.currency[i],
                          :lt_prod.discount[i],
                          :lv_price_d,
                          :lv_mrp
                      ), i );
    END FOR ;


  ENDMETHOD.



  METHOD get_total_sales BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY
                         USING zats_ra_bpa
                               zats_ra_so_hdr
                               zats_ra_so_item.

    return select
    bpa.client,
    bpa.company_name,
    sum (item.amount) as total_sales,
    item.currency as currency_code,
    rank( ) over ( ORDER BY sum(item.amount) DESC ) as customer_rank
    from zats_ra_bpa as bpa
    inner JOIN zats_ra_so_hdr as sls
    on bpa.bp_id = sls.buyer
    INNER JOIN zats_ra_so_item as item
    on sls.order_id = item.order_id
    group by bpa.client,
             bpa.company_name,
             item.currency;



  ENDMETHOD.

ENDCLASS.
