&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          smndsy           PROGRESS
*/
&Scoped-define WINDOW-NAME wWin
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES lectures

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 lectures.lectures-code ~
lectures.lectures-date-txt lectures.sub-count lectures.lectures-title ~
lectures.lectures-spoken-language lectures.lectures-country ~
lectures.lectures-city lectures.lectures-duration lectures.http-link ~
lectures.lectures-filename 
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


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS wsearch BtnSearch BROWSE-1 BtnOpenHttp ~
wfilename 
&Scoped-Define DISPLAYED-OBJECTS wsearch wfilename 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnOpenHttp 
     LABEL "Open Http" 
     SIZE 15 BY 1.12.

DEFINE BUTTON BtnSearch 
     LABEL "<?>" 
     SIZE 4.5 BY .81.

DEFINE VARIABLE wfilename AS CHARACTER FORMAT "X(256)":U 
     LABEL "File" 
     VIEW-AS FILL-IN 
     SIZE 58.83 BY .81 NO-UNDO.

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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      lectures.lectures-code FORMAT "->,>>>>>9":U WIDTH 5
      lectures.lectures-date-txt FORMAT "x(10)":U WIDTH 11.5
      lectures.sub-count COLUMN-LABEL "Sub" FORMAT "x(8)":U WIDTH 7
      lectures.lectures-title FORMAT "x(100)":U WIDTH 43
      lectures.lectures-spoken-language COLUMN-LABEL "Lang" FORMAT "x(20)":U
            WIDTH 7
      lectures.lectures-country FORMAT "x(50)":U WIDTH 16.83
      lectures.lectures-city FORMAT "x(50)":U
      lectures.lectures-duration FORMAT "->,>>>,>>9":U
      lectures.http-link FORMAT "x(200)":U WIDTH 50
      lectures.lectures-filename FORMAT "x(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS NO-TAB-STOP SIZE 118.83 BY 12.27
         FONT 4
         TITLE "Lectures List" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wsearch AT ROW 1.27 COL 8.5 COLON-ALIGNED WIDGET-ID 4
     BtnSearch AT ROW 1.27 COL 31.5 WIDGET-ID 6
     BROWSE-1 AT ROW 2.35 COL 2.5 WIDGET-ID 200
     BtnOpenHttp AT ROW 14.85 COL 2.33 WIDGET-ID 2
     wfilename AT ROW 14.92 COL 27.33 COLON-ALIGNED WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 123 BY 15.31 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert SmartWindow title>"
         HEIGHT             = 15.31
         WIDTH              = 123
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 146.17
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 146.17
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-1 BtnSearch fMain */
ASSIGN 
       BROWSE-1:NUM-LOCKED-COLUMNS IN FRAME fMain     = 2
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       wfilename:READ-ONLY IN FRAME fMain        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

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
     _FldNameList[3]   > smndsy.lectures.sub-count
"sub-count" "Sub" ? "character" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > smndsy.lectures.lectures-title
"lectures-title" ? ? "character" ? ? ? ? ? ? no ? no no "43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > smndsy.lectures.lectures-spoken-language
"lectures-spoken-language" "Lang" ? "character" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > smndsy.lectures.lectures-country
"lectures-country" ? ? "character" ? ? ? ? ? ? no ? no no "16.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   = smndsy.lectures.lectures-city
     _FldNameList[8]   = smndsy.lectures.lectures-duration
     _FldNameList[9]   > smndsy.lectures.http-link
"http-link" ? ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   = smndsy.lectures.lectures-filename
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* <insert SmartWindow title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* <insert SmartWindow title> */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 wWin
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Lectures List */
DO:
  IF available lectures THEN do:
     assign wfilename:screen-value = lectures.lectures-filename + ".txt".
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnOpenHttp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnOpenHttp wWin
ON CHOOSE OF BtnOpenHttp IN FRAME fMain /* Open Http */
DO:
    MESSAGE lectures.http-link
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
  os-command no-wait value(lectures.http-link). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearch wWin
ON CHOOSE OF BtnSearch IN FRAME fMain /* <?> */
DO:
  assign wsearch = "*" + wsearch:screen-value + "*".
  {&OPEN-QUERY-BROWSE-1}
  APPLY "value-changed" TO browse-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearch wWin
ON ANY-PRINTABLE OF wsearch IN FRAME fMain /* Search */
DO:
     APPLY "Choose" TO BtnSearch.
     APPLY LAST-EVENT:LABEL TO SELF.
     return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
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
  DISPLAY wsearch wfilename 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wsearch BtnSearch BROWSE-1 BtnOpenHttp wfilename 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  VIEW wWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject wWin 
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

