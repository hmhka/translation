&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          smndsy           PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME gDialog
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS gDialog 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrdlg.w - ADM2 SmartDialog Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{src/adm2/widgetprto.i}

def shared var plectures-code1 like lectures.lectures-code.
def var plectures-code2 like lectures.lectures-code.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME gDialog
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES lectures

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 lectures.lectures-code ~
lectures.lectures-date-txt lectures.lectures-filename lectures.sub-count ~
lectures.lectures-title lectures.lectures-country lectures.lectures-city ~
lectures.lectures-duration lectures.http-link 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH lectures ~
      WHERE lectures.lectures-date-txt MATCHES wsearch  ~
 OR lectures.lectures-title MATCHES wsearch ~
 OR lectures.lectures-country MATCHES wsearch ~
 OR lectures.lectures-city MATCHES wsearch ~
 OR STRING(lectures.lectures-code) MATCHES wsearch NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH lectures ~
      WHERE lectures.lectures-date-txt MATCHES wsearch  ~
 OR lectures.lectures-title MATCHES wsearch ~
 OR lectures.lectures-country MATCHES wsearch ~
 OR lectures.lectures-city MATCHES wsearch ~
 OR STRING(lectures.lectures-code) MATCHES wsearch NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 lectures
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 lectures


/* Definitions for DIALOG-BOX gDialog                                   */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS wsearch BtnSearch BROWSE-1 
&Scoped-Define DISPLAYED-OBJECTS wsearch 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnSearch 
     LABEL "<?>" 
     SIZE 4.5 BY .81.

DEFINE VARIABLE wsearch AS CHARACTER FORMAT "X(256)":U 
     LABEL "Search" 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      lectures SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 gDialog _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      lectures.lectures-code FORMAT "->,>>>>>9":U WIDTH 5
      lectures.lectures-date-txt FORMAT "x(10)":U WIDTH 11.5
      lectures.lectures-filename FORMAT "x(50)":U WIDTH 13.17
      lectures.sub-count COLUMN-LABEL "Sub" FORMAT "x(8)":U WIDTH 7
      lectures.lectures-title FORMAT "x(100)":U WIDTH 43
      lectures.lectures-country FORMAT "x(50)":U WIDTH 16.83
      lectures.lectures-city FORMAT "x(50)":U
      lectures.lectures-duration FORMAT "->,>>>,>>9":U
      lectures.http-link FORMAT "x(200)":U WIDTH 50
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS NO-TAB-STOP SIZE 80.17 BY 12.27
         FONT 4
         TITLE "Lectures List" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME gDialog
     wsearch AT ROW 1.27 COL 8.5 COLON-ALIGNED WIDGET-ID 4
     BtnSearch AT ROW 1.27 COL 31.5 WIDGET-ID 6
     BROWSE-1 AT ROW 2.31 COL 1.5 WIDGET-ID 200
     SPACE(1.32) SKIP(1.33)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "<insert SmartDialog title>" WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB gDialog 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX gDialog
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-1 BtnSearch gDialog */
ASSIGN 
       FRAME gDialog:SCROLLABLE       = FALSE
       FRAME gDialog:HIDDEN           = TRUE.

ASSIGN 
       BROWSE-1:NUM-LOCKED-COLUMNS IN FRAME gDialog     = 2
       BROWSE-1:COLUMN-RESIZABLE IN FRAME gDialog       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME gDialog         = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "smndsy.lectures"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "lectures.lectures-date-txt MATCHES wsearch 
 OR lectures.lectures-title MATCHES wsearch
 OR lectures.lectures-country MATCHES wsearch
 OR lectures.lectures-city MATCHES wsearch
 OR STRING(lectures.lectures-code) MATCHES wsearch"
     _FldNameList[1]   > smndsy.lectures.lectures-code
"lectures-code" ? "->,>>>>>9" "integer" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > smndsy.lectures.lectures-date-txt
"lectures-date-txt" ? ? "character" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > smndsy.lectures.lectures-filename
"lectures-filename" ? ? "character" ? ? ? ? ? ? no ? no no "13.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > smndsy.lectures.sub-count
"sub-count" "Sub" ? "character" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > smndsy.lectures.lectures-title
"lectures-title" ? ? "character" ? ? ? ? ? ? no ? no no "43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > smndsy.lectures.lectures-country
"lectures-country" ? ? "character" ? ? ? ? ? ? no ? no no "16.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   = smndsy.lectures.lectures-city
     _FldNameList[8]   = smndsy.lectures.lectures-duration
     _FldNameList[9]   > smndsy.lectures.http-link
"http-link" ? ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX gDialog
/* Query rebuild information for DIALOG-BOX gDialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX gDialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME gDialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL gDialog gDialog
ON WINDOW-CLOSE OF FRAME gDialog /* <insert SmartDialog title> */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 gDialog
ON MOUSE-SELECT-DBLCLICK OF BROWSE-1 IN FRAME gDialog /* Lectures List */
DO:
    IF plectures-code2 > 0 THEN do:
       assign plectures-code1 = plectures-code2.
       APPLY "END-ERROR":U TO SELF.
    END.
    else do:
         assign plectures-code1 = 0.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 gDialog
ON VALUE-CHANGED OF BROWSE-1 IN FRAME gDialog /* Lectures List */
DO:
    
  IF available lectures THEN do:
     assign plectures-code2 = lectures.lectures-code.
  END.
  else do:
       assign plectures-code2 = 0.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearch gDialog
ON CHOOSE OF BtnSearch IN FRAME gDialog /* <?> */
DO:
  assign wsearch = "*" + wsearch:screen-value + "*".
  {&OPEN-QUERY-BROWSE-1}
  APPLY "value-changed" TO browse-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearch gDialog
ON ANY-PRINTABLE OF wsearch IN FRAME gDialog /* Search */
DO:
     APPLY "Choose" TO BtnSearch.
     APPLY LAST-EVENT:LABEL TO SELF.
     return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK gDialog 


/* ***************************  Main Block  *************************** */

{src/adm2/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects gDialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI gDialog  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME gDialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI gDialog  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY wsearch 
      WITH FRAME gDialog.
  ENABLE wsearch BtnSearch BROWSE-1 
      WITH FRAME gDialog.
  VIEW FRAME gDialog.
  {&OPEN-BROWSERS-IN-QUERY-gDialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject gDialog 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */


  DO WITH FRAME {&FRAME-NAME}:
  END.
  assign wsearch = "*".
  APPLY "Choose" TO BtnSearch.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

