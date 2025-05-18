%let pgm=utl-safest-way-to-deal-with-macro-variables-containing-macro-triggers-and-quotes-sysfunc-dequote;

Safest way to deal with macro variables containing macro triggers and quotes sysfunc(dequote))

Problem: Subset sashelp.class for just males

          CONTENTS

             1 Failed example
             2 Correct example

github
https://tinyurl.com/4vy33zfz
https://github.com/rogerjdeangelis/utl-safest-way-to-deal-with-macro-variables-containing-macro-triggers-and-quotes-sysfunc-dequote

communities.sas
https://tinyurl.com/4zmafcf5
https://communities.sas.com/t5/SAS-Programming/quoted-comma-delimeted-are-argument/m-p/812494#M320584


related repos
https://tinyurl.com/yv4nyb8k
https://github.com/rogerjdeangelis/utl_safest_way_to_deal_with_macro_variables_containing_macro_triggers_and_quotes


SOAPBOX ON

This may seem trivial but %sysfunc(dequote()) has a lot of applications.
It lets you decide exactly when you want macro triggers to take place.
Sometimes sas goes wild with automatic resolution.

Suppose you want to make sure sas does not resolve

THIS DOES NOT WORK (happens at macro time and does not work)

%let res = %unquote('&sysdate &systime');
%put &=res;

RES='&sysdate &systime'

THIS DOES WORK (can control when this happens inside or outside a macro,even in cases of nested macros)

%let res = %sysfunc(dequote('&sysdate &systime'));
%put &=res;

RES=15JAN23 09:17

SOAPBOX OFF

/**************************************************************************************************************************/
/*          PROCESS                            |                             OUTPUT                                       */
/*          =======                            |                             ======                                       */
/*                                             |                                                                          */
/*  1 FAILED EXAMPLE                           |                                                                          */
/*  ================                           |                                                                          */
/*                                             |                                                                          */
/*  %macro generate_data(ds, list);            | NOTE: Table WORK.HAVE created, with 0 rows and 5 columns.                */
/*                                             |                                                                          */
/*    proc sql;                                |                                                                          */
/*      create                                 |                                                                          */
/*         table &ds. as                       |                                                                          */
/*      select                                 |                                                                          */
/*         *                                   |                                                                          */
/*      from                                   |                                                                          */
/*         sashelp.class(obs=5 keep=name sex)  |                                                                          */
/*      where                                  |                                                                          */
/*         sex in (&list)                      |                                                                          */
/*    ;quit;                                   |                                                                          */
/*                                             |                                                                          */
/*  %mend generate_data;                       |                                                                          */
/*                                             |                                                                          */
/*  %generate_data(have,"'M','X'");            |                                                                          */
/*                                             |                                                                          */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                             |                                                                          */
/*  2 CORRECT EXAMPLE                          |                                                                          */
/*  =================                          |                                                                          */
/*                                             |                                                                          */
/*  %macro generate_data(ds, list);            | WORK.HAVE total obs=5                                                    */
/*                                             |                                                                          */
/*    proc sql;                                | Obs    NAME       SEX                                                    */
/*      create                                 |                                                                          */
/*         table &ds. as                       |  1     Alfred      M                                                     */
/*      select                                 |  2     Henry       M                                                     */
/*         *                                   |  3     James       M                                                     */
/*      from                                   |  4     Jeffrey     M                                                     */
/*         sashelp.class(obs=5 keep=name sex)  |  5     John        M                                                     */
/*      where                                  |                                                                          */
/*         sex in (%sysfunc(dequote(&list)));  |                                                                          */
/*    quit;                                    |                                                                          */
/*                                             |                                                                          */
/*  %mend generate_data;                       |                                                                          */
/*                                             |                                                                          */
/*  %generate_data(have,"'M','X'");            |                                                                          */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
