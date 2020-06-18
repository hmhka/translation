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

DEF NEW SHARED VAR plectures-code as int.
DEF NEW SHARED VAR plectures-code1 as int.
DEF NEW SHARED VAR plectures-filename like lectures.lectures-filename.

DEF NEW SHARED VAR psrc-lang as char.
DEF NEW SHARED VAR pdes-lang as char.

DEF NEW SHARED VAR psrc-folder as char.
DEF NEW SHARED VAR pdes-folder as char.

DEF NEW SHARED VAR psrc-folder-temp as char.
DEF NEW SHARED VAR pdes-folder-temp as char.

DEF NEW SHARED VAR pdes-folder-srt as char.
DEF NEW shared var pdes-file-srt as char.

DEF NEW SHARED VAR psrc-file as char.
DEF NEW SHARED VAR pdes-file as char.

DEF NEW SHARED VAR pspeech-ori-eng-file as char.
DEF NEW SHARED VAR pspeech-ori-hin-file as char.
DEF NEW SHARED VAR pspeech-ori-mar-file as char.

DEF NEW SHARED VAR pprocess-type as int.

def var plectures-spoken-language like lectures.lectures-spoken-language.
def var plectures-title like lectures.lectures-title.

def new shared var pori-corr as char.
def var ptime-from like speech_text.time-from.
def var ptime-to like speech_text.time-to.


def new shared var psrt-type as int.

def new shared var pcons-ini as int.
def new shared var pcons-fin as int.

def var ptranslate-one-line as logical.

def var ptick as int.

def var pdur-ctrl as log.
def var pduration as int.
assign ptick = 0.
    def var pmedia-file as char.

    DEF VAR pcur-pos-ini as int.
    def var pcur-ini as char.

    DEF VAR pcur-pos-fin as int.
    def var pcur-fin as char.
    def var pdur as int.

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
&Scoped-define INTERNAL-TABLES speech_text

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 speech_text.cons ~
speech_text.srt-num speech_text.speech-ori-eng speech_text.speech-ori-hin ~
speech_text.speech-ori-mar speech_text.speech-corr-eng ~
speech_text.speech-corr-hin speech_text.speech-corr-mar ~
speech_text.speech-auto-hin speech_text.speech-auto-guj ~
speech_text.speech-auto-mar speech_text.speech-auto-spa ~
speech_text.speech-auto-tag speech_text.speech-auto-tam ~
speech_text.speech-auto-kan speech_text.speech-auto-chi-cn ~
speech_text.speech-auto-per speech_text.IsEmpty speech_text.IsTimer ~
speech_text.IsTimerNum speech_text.time-from speech_text.time-to ~
speech_text.srt-timing speech_text.lectures-code speech_text.IsText 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 speech_text.speech-ori-eng ~
speech_text.speech-ori-hin speech_text.speech-ori-mar ~
speech_text.speech-corr-eng speech_text.speech-corr-hin ~
speech_text.speech-corr-mar speech_text.speech-auto-hin ~
speech_text.speech-auto-guj speech_text.speech-auto-mar ~
speech_text.speech-auto-spa speech_text.speech-auto-tag ~
speech_text.speech-auto-tam speech_text.speech-auto-kan ~
speech_text.speech-auto-chi-cn speech_text.speech-auto-per 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 speech_text
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 speech_text
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH speech_text ~
      WHERE speech_text.lectures-code = plectures-code AND ~
speech_text.speech-ori-eng matches wsearch ~
 AND speech_text.IsText NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH speech_text ~
      WHERE speech_text.lectures-code = plectures-code AND ~
speech_text.speech-ori-eng matches wsearch ~
 AND speech_text.IsText NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 speech_text
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 speech_text


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BtnAssignSRTInfo RECT-1 RECT-2 RECT-3 RECT-4 ~
wlectures-code wlectures-filename wsearch BtnSearch wsrc-lang wdes-lang ~
BROWSE-1 wenglish whindi wother-lang werror BtnSrtTiming BtnAssignPosition ~
BtnPause BtnPlay btnStop BtnGenerateSrtFile BtnTranslate 
&Scoped-Define DISPLAYED-OBJECTS wlectures-code wlectures-filename wsearch ~
wsrc-lang wdes-lang wenglish whindi wother-lang werror wstart-time ~
wend-time 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Masters 
       MENU-ITEM m_Languages    LABEL "Languages"     
       MENU-ITEM m_Lectures     LABEL "Lectures"      
       MENU-ITEM m_Defaults     LABEL "Defaults"      .

DEFINE SUB-MENU m_Import 
       MENU-ITEM m_Import_-_Source_Lecture_Eng LABEL "Import - Source Lecture English (Original)"
       MENU-ITEM m_Import_-_Source_Lecture_Hin LABEL "Import - Source Lecture Hindi (Original)"
       MENU-ITEM m_Import_-_Source_Lecture_Mar LABEL "Import - Source Lecture Marathi (Original)"
       MENU-ITEM m_Import_-_Source_Lecture_Eng2 LABEL "Import - Source Lecture English (Corrected)"
       MENU-ITEM m_Import_-_Source_Lecture_Hin2 LABEL "Import - Source Lecture Hindi (Corrected)"
       MENU-ITEM m_Import_-_Source_Lecture_Mar2 LABEL "Import - Source Lecture Marathi (Corrected)".

DEFINE MENU MENU-BAR-wWin MENUBAR
       SUB-MENU  m_Masters      LABEL "Masters"       
       SUB-MENU  m_Import       LABEL "Import"        
       MENU-ITEM m_Exit         LABEL "Exit"          .


/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE CtrlFrame-4 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame-4 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnAssignPosition  NO-FOCUS FLAT-BUTTON
     LABEL "Assign Position" 
     SIZE 20.33 BY .81
     FONT 4.

DEFINE BUTTON BtnAssignSRTInfo  NO-FOCUS FLAT-BUTTON
     LABEL "Assign SRT Info" 
     SIZE 20.33 BY .81
     FONT 4.

DEFINE BUTTON BtnGenerateSrtFile  NO-FOCUS FLAT-BUTTON
     LABEL "SRT Files" 
     SIZE 14.33 BY .81.

DEFINE BUTTON BtnPause  NO-FOCUS FLAT-BUTTON
     LABEL "Pause" 
     SIZE 8 BY .81
     FONT 4.

DEFINE BUTTON BtnPlay  NO-FOCUS FLAT-BUTTON
     LABEL "Play" 
     SIZE 8 BY .81
     FONT 4.

DEFINE BUTTON BtnSearch 
     LABEL "<?>" 
     SIZE 4.5 BY .81.

DEFINE BUTTON BtnSrtTiming 
     LABEL "SRT Timing" 
     SIZE 15 BY .81.

DEFINE BUTTON btnStop  NO-FOCUS FLAT-BUTTON
     LABEL "Stop" 
     SIZE 8 BY .81
     FONT 4.

DEFINE BUTTON BtnTranslate  NO-FOCUS FLAT-BUTTON
     LABEL "Translate" 
     SIZE 14.33 BY .81.

DEFINE VARIABLE wdes-lang AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS ""," ",
                     "English-Ori","en_Ori",
                     "Hindi-Ori","hi_Ori",
                     "Marathi-Ori","mr_Ori",
                     "English-Corr","en",
                     "Hindi-Corr","hi",
                     "Marathi-Corr","mr",
                     "Gujrati","gu",
                     "Tamil","ta",
                     "Tagalog","tl",
                     "Kannada","kn",
                     "Spanish","es",
                     "Persian","fa",
                     "Chinese","zh-CN"
     DROP-DOWN-LIST
     SIZE 16 BY .81
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsrc-lang AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS ""," ",
                     "English-Ori","en_Ori",
                     "Hindi-Ori","hi_Ori",
                     "Marathi-Ori","mr_Ori",
                     "English-Corr","en",
                     "Hindi-Corr","hi",
                     "Marathi-Corr","mr",
                     "Gujrati","gu",
                     "Tamil","ta",
                     "Tagalog","tl",
                     "Kannada","kn",
                     "Spanish","es",
                     "Persian","fa",
                     "Chinese","zh-CN"
     DROP-DOWN-LIST
     SIZE 16 BY .81
     FONT 4 NO-UNDO.

DEFINE VARIABLE wend-time AS CHARACTER FORMAT "X(256)":U 
     LABEL "End" 
     VIEW-AS FILL-IN 
     SIZE 10.33 BY .81 NO-UNDO.

DEFINE VARIABLE wenglish AS CHARACTER FORMAT "X(256)":U 
     LABEL "English" 
     VIEW-AS FILL-IN 
     SIZE 167.83 BY 1
     BGCOLOR 22 FONT 9 NO-UNDO.

DEFINE VARIABLE werror AS CHARACTER FORMAT "X(256)":U 
     LABEL "error" 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1 NO-UNDO.

DEFINE VARIABLE whindi AS CHARACTER FORMAT "X(256)":U 
     LABEL "Hindi" 
     VIEW-AS FILL-IN 
     SIZE 167.83 BY 1 TOOLTIP "Hindi Corrected"
     BGCOLOR 19 FONT 9 NO-UNDO.

DEFINE VARIABLE wlectures-code AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Lecture Code" 
     VIEW-AS FILL-IN 
     SIZE 8.67 BY .81 TOOLTIP "942 / 321 / 270" NO-UNDO.

DEFINE VARIABLE wlectures-filename AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "File" 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY .81 NO-UNDO.

DEFINE VARIABLE wother-lang AS CHARACTER FORMAT "X(256)":U 
     LABEL "Marathi" 
     VIEW-AS FILL-IN 
     SIZE 167.83 BY 1
     BGCOLOR 21 FONT 9 NO-UNDO.

DEFINE VARIABLE wsearch AS CHARACTER FORMAT "X(256)":U 
     LABEL "Search" 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY .81 NO-UNDO.

DEFINE VARIABLE wstart-time AS CHARACTER FORMAT "X(256)":U 
     LABEL "Start" 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY .81 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30.83 BY 1.31.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 19 BY 1.31.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16 BY 1.31.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16 BY 1.31.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      speech_text SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      speech_text.cons FORMAT "->>>>>>9":U WIDTH 6.67 COLUMN-FONT 4
      speech_text.srt-num FORMAT "->,>>>,>>9":U WIDTH 7.67 COLUMN-FONT 4
      speech_text.speech-ori-eng FORMAT "x(100)":U WIDTH 34.33
      speech_text.speech-ori-hin FORMAT "x(1000)":U WIDTH 34.33
      speech_text.speech-ori-mar FORMAT "x(8)":U WIDTH 34.33
      speech_text.speech-corr-eng FORMAT "x(1000)":U WIDTH 34.33
      speech_text.speech-corr-hin FORMAT "x(1000)":U WIDTH 34.33
            COLUMN-FGCOLOR 9
      speech_text.speech-corr-mar FORMAT "x(1000)":U WIDTH 34.33
      speech_text.speech-auto-hin FORMAT "x(1000)":U WIDTH 40
      speech_text.speech-auto-guj FORMAT "x(1000)":U WIDTH 48.33
            COLUMN-FGCOLOR 3
      speech_text.speech-auto-mar COLUMN-LABEL "Auto Marathi" FORMAT "x(1000)":U
            WIDTH 48.33
      speech_text.speech-auto-spa FORMAT "x(1000)":U WIDTH 48.33
      speech_text.speech-auto-tag COLUMN-LABEL "Auto Tagalog" FORMAT "x(1000)":U
            WIDTH 48.33
      speech_text.speech-auto-tam FORMAT "x(1000)":U WIDTH 48
      speech_text.speech-auto-kan FORMAT "x(1000)":U WIDTH 48
      speech_text.speech-auto-chi-cn FORMAT "x(1000)":U WIDTH 40
      speech_text.speech-auto-per FORMAT "x(1000)":U WIDTH 40
      speech_text.IsEmpty FORMAT "yes/no":U
      speech_text.IsTimer FORMAT "yes/no":U
      speech_text.IsTimerNum FORMAT "yes/no":U
      speech_text.time-from FORMAT "x(15)":U
      speech_text.time-to FORMAT "x(15)":U
      speech_text.srt-timing FORMAT "x(30)":U
      speech_text.lectures-code FORMAT "->,>>>,>>9":U WIDTH 6.67
      speech_text.IsText FORMAT "yes/no":U
  ENABLE
      speech_text.speech-ori-eng
      speech_text.speech-ori-hin
      speech_text.speech-ori-mar
      speech_text.speech-corr-eng
      speech_text.speech-corr-hin
      speech_text.speech-corr-mar
      speech_text.speech-auto-hin
      speech_text.speech-auto-guj
      speech_text.speech-auto-mar
      speech_text.speech-auto-spa
      speech_text.speech-auto-tag
      speech_text.speech-auto-tam
      speech_text.speech-auto-kan
      speech_text.speech-auto-chi-cn
      speech_text.speech-auto-per
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 113.83 BY 9.85
         FONT 5
         TITLE "Speech" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BtnAssignSRTInfo AT ROW 13.04 COL 62.5 WIDGET-ID 94
     wlectures-code AT ROW 1.54 COL 16.17 COLON-ALIGNED WIDGET-ID 88
     wlectures-filename AT ROW 1.54 COL 30.83 COLON-ALIGNED WIDGET-ID 92
     wsearch AT ROW 1.54 COL 66 COLON-ALIGNED WIDGET-ID 12
     BtnSearch AT ROW 1.54 COL 89 WIDGET-ID 10
     wsrc-lang AT ROW 1.54 COL 94.83 COLON-ALIGNED NO-LABEL WIDGET-ID 96
     wdes-lang AT ROW 1.54 COL 125.5 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     BROWSE-1 AT ROW 3.08 COL 62.67 WIDGET-ID 200
     wenglish AT ROW 14.12 COL 9 COLON-ALIGNED WIDGET-ID 60
     whindi AT ROW 15.54 COL 9 COLON-ALIGNED WIDGET-ID 56
     wother-lang AT ROW 17.08 COL 9 COLON-ALIGNED WIDGET-ID 58
     werror AT ROW 19.12 COL 58.67 COLON-ALIGNED WIDGET-ID 86
     BtnSrtTiming AT ROW 19.27 COL 163.83 WIDGET-ID 98
     wstart-time AT ROW 19.31 COL 9 COLON-ALIGNED WIDGET-ID 22
     wend-time AT ROW 19.35 COL 27.17 COLON-ALIGNED WIDGET-ID 24
     BtnAssignPosition AT ROW 13.04 COL 27 WIDGET-ID 84
     BtnPause AT ROW 13.04 COL 19 WIDGET-ID 8
     BtnPlay AT ROW 13.04 COL 3.33 WIDGET-ID 4
     btnStop AT ROW 13.04 COL 11.17 WIDGET-ID 6
     BtnGenerateSrtFile AT ROW 1.54 COL 161.5 WIDGET-ID 80
     BtnTranslate AT ROW 1.54 COL 145.67 WIDGET-ID 18
     "Target Lang." VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 1 COL 127.17 WIDGET-ID 64
          FONT 4
     "Source Lang." VIEW-AS TEXT
          SIZE 11.33 BY .62 AT ROW 1 COL 96.33 WIDGET-ID 62
          FONT 4
     RECT-1 AT ROW 1.27 COL 95.83 WIDGET-ID 66
     RECT-2 AT ROW 1.27 COL 126.17 WIDGET-ID 68
     RECT-3 AT ROW 1.27 COL 144.83 WIDGET-ID 70
     RECT-4 AT ROW 1.27 COL 160.5 WIDGET-ID 82
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 179.33 BY 19.54 WIDGET-ID 100.


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
         HEIGHT             = 19.54
         WIDTH              = 179.33
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 200.17
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 200.17
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = yes
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = yes
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

ASSIGN {&WINDOW-NAME}:MENUBAR    = MENU MENU-BAR-wWin:HANDLE.
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
/* BROWSE-TAB BROWSE-1 wdes-lang fMain */
ASSIGN 
       BROWSE-1:NUM-LOCKED-COLUMNS IN FRAME fMain     = 2
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       speech_text.speech-auto-hin:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       speech_text.speech-auto-guj:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       speech_text.speech-auto-mar:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       speech_text.speech-auto-spa:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       speech_text.speech-auto-tag:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE.

/* SETTINGS FOR FILL-IN wend-time IN FRAME fMain
   NO-ENABLE                                                            */
ASSIGN 
       wenglish:READ-ONLY IN FRAME fMain        = TRUE.

ASSIGN 
       whindi:READ-ONLY IN FRAME fMain        = TRUE.

ASSIGN 
       wlectures-filename:READ-ONLY IN FRAME fMain        = TRUE.

ASSIGN 
       wother-lang:READ-ONLY IN FRAME fMain        = TRUE.

/* SETTINGS FOR FILL-IN wstart-time IN FRAME fMain
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "smndsy.speech_text"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "speech_text.lectures-code = plectures-code AND
speech_text.speech-ori-eng matches wsearch
 AND speech_text.IsText"
     _FldNameList[1]   > smndsy.speech_text.cons
"cons" ? "->>>>>>9" "integer" ? ? 4 ? ? ? no ? no no "6.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > smndsy.speech_text.srt-num
"srt-num" ? ? "integer" ? ? 4 ? ? ? no ? no no "7.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > smndsy.speech_text.speech-ori-eng
"speech-ori-eng" ? ? "character" ? ? ? ? ? ? yes ? no no "34.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > smndsy.speech_text.speech-ori-hin
"speech-ori-hin" ? ? "character" ? ? ? ? ? ? yes ? no no "34.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > smndsy.speech_text.speech-ori-mar
"speech-ori-mar" ? ? "character" ? ? ? ? ? ? yes ? no no "34.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > smndsy.speech_text.speech-corr-eng
"speech-corr-eng" ? ? "character" ? ? ? ? ? ? yes ? no no "34.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > smndsy.speech_text.speech-corr-hin
"speech-corr-hin" ? ? "character" ? 9 ? ? ? ? yes ? no no "34.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > smndsy.speech_text.speech-corr-mar
"speech-corr-mar" ? ? "character" ? ? ? ? ? ? yes ? no no "34.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > smndsy.speech_text.speech-auto-hin
"speech-auto-hin" ? ? "character" ? ? ? ? ? ? yes ? no no "40" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > smndsy.speech_text.speech-auto-guj
"speech-auto-guj" ? ? "character" ? 3 ? ? ? ? yes ? no no "48.33" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > smndsy.speech_text.speech-auto-mar
"speech-auto-mar" "Auto Marathi" ? "character" ? ? ? ? ? ? yes ? no no "48.33" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > smndsy.speech_text.speech-auto-spa
"speech-auto-spa" ? ? "character" ? ? ? ? ? ? yes ? no no "48.33" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > smndsy.speech_text.speech-auto-tag
"speech-auto-tag" "Auto Tagalog" ? "character" ? ? ? ? ? ? yes ? no no "48.33" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > smndsy.speech_text.speech-auto-tam
"speech-auto-tam" ? ? "character" ? ? ? ? ? ? yes ? no no "48" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > smndsy.speech_text.speech-auto-kan
"speech-auto-kan" ? ? "character" ? ? ? ? ? ? yes ? no no "48" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > smndsy.speech_text.speech-auto-chi-cn
"speech-auto-chi-cn" ? ? "character" ? ? ? ? ? ? yes ? no no "40" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > smndsy.speech_text.speech-auto-per
"speech-auto-per" ? ? "character" ? ? ? ? ? ? yes ? no no "40" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   = smndsy.speech_text.IsEmpty
     _FldNameList[19]   = smndsy.speech_text.IsTimer
     _FldNameList[20]   = smndsy.speech_text.IsTimerNum
     _FldNameList[21]   = smndsy.speech_text.time-from
     _FldNameList[22]   = smndsy.speech_text.time-to
     _FldNameList[23]   = smndsy.speech_text.srt-timing
     _FldNameList[24]   > smndsy.speech_text.lectures-code
"lectures-code" ? ? "integer" ? ? ? ? ? ? no ? no no "6.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   = smndsy.speech_text.IsText
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 3
       COLUMN          = 3.17
       HEIGHT          = 9.92
       WIDTH           = 58.5
       WIDGET-ID       = 2
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME CtrlFrame-4 ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 18.19
       COLUMN          = 2.67
       HEIGHT          = 1
       WIDTH           = 5.67
       WIDGET-ID       = 28
       HIDDEN          = yes
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {6BF52A52-394A-11d3-B153-00C04F79FAA6} type: WMP */
      CtrlFrame-4:NAME = "CtrlFrame-4":U .
/* CtrlFrame-4 OCXINFO:CREATE-CONTROL from: {F0B88A90-F5DA-11CF-B545-0020AF6ED35A} type: PSTimer */
      CtrlFrame:MOVE-AFTER(wdes-lang:HANDLE IN FRAME fMain).
      CtrlFrame-4:MOVE-AFTER(wother-lang:HANDLE IN FRAME fMain).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


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
  chCtrlFrame:WMP:controls:stop().
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 wWin
ON MOUSE-SELECT-DBLCLICK OF BROWSE-1 IN FRAME fMain /* Speech */
DO:
  IF available speech_text THEN DO:
      assign ptranslate-one-line = true.
      assign pcons-ini = speech_text.cons
             pcons-fin = speech_text.cons.
      apply "Choose" to BtnTranslate.
      assign ptranslate-one-line = false.
      apply "Value-Changed" to self.


  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 wWin
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Speech */
DO:
  IF available speech_text THEN do:
     assign wenglish:screen-value = speech_text.speech-ori-eng.
     assign whindi:screen-value = speech_text.speech-corr-hin.

    ASSIGN 
        psrc-lang = wsrc-lang:screen-value
        pdes-lang = wdes-lang:screen-value
        .

    assign ptime-from = speech_text.time-from.
    assign ptime-to   = speech_text.time-to.


    assign wother-lang:label = pdes-lang.

   /* IF pdes-lang = "hi"    THEN wother-lang:screen-value = speech_text.speech-corr-hin .*/
    IF pdes-lang = "hi"    THEN wother-lang:screen-value = speech_text.speech-auto-hin .
    IF pdes-lang = "gu"    THEN wother-lang:screen-value = speech_text.speech-auto-guj .
    IF pdes-lang = "mr"    THEN wother-lang:screen-value = speech_text.speech-auto-mar .
    IF pdes-lang = "ta"    THEN wother-lang:screen-value = speech_text.speech-auto-tam .

    IF pdes-lang = "tl"    THEN wother-lang:screen-value = speech_text.speech-auto-tag .
    IF pdes-lang = "kn"    THEN wother-lang:screen-value = speech_text.speech-auto-kan .
    IF pdes-lang = "es"    THEN wother-lang:screen-value = speech_text.speech-auto-spa .
    IF pdes-lang = "zh-Cn" THEN wother-lang:screen-value = speech_text.speech-auto-chi-cn .
    IF pdes-lang = "fa"    THEN wother-lang:screen-value = speech_text.speech-auto-per .




  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnAssignPosition
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnAssignPosition wWin
ON CHOOSE OF BtnAssignPosition IN FRAME fMain /* Assign Position */
DO:
    
    
   
    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT ptime-from, output pcur-pos-ini).
    assign pcur-ini = string(pcur-pos-ini / 1000) no-error.
      

   

    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT ptime-to, output pcur-pos-fin) no-error.
    assign pcur-fin = string(pcur-pos-fin / 1000) no-error.
      
     
    assign pdur = INT(pcur-fin) - INT(pcur-ini).

    werror:screen-value = STRING(pcur-ini) + " "  + STRING(pcur-fin) + "  "  + STRING(pdur) .


    
    /*
    assign pduration = 300.
    */
    assign pduration = pdur + 1.
    assign ptick = 0.
    assign pdur-ctrl = true.
    
    /*
    chCtrlFrame:WMP:controls:currenTPOSITION = "100".
      */
      
  chCtrlFrame:WMP:URL = pmedia-file.
  chCtrlFrame:WMP:controls:currenTPOSITION = pcur-ini.
  chCtrlFrame:WMP:controls:play().
    /*
    apply "Choose" to BtnPlay.  
      **/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnAssignSRTInfo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnAssignSRTInfo wWin
ON CHOOSE OF BtnAssignSRTInfo IN FRAME fMain /* Assign SRT Info */
DO:
    
    run c:\pvr\translation\lib\assign_srt_timing.p.
    apply "Choose" to BTNSEARCH.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnGenerateSrtFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnGenerateSrtFile wWin
ON CHOOSE OF BtnGenerateSrtFile IN FRAME fMain /* SRT Files */
DO:
    IF wsrc-lang:screen-value = "" THEN do:
       MESSAGE "Please select source language "
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.
    IF wdes-lang:screen-value = "" THEN do:
       MESSAGE "Please select target language "
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.

    FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
    IF not available lectures_default THEN do:
       MESSAGE "lectures_default table not available" 
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.

    ASSIGN 
        psrc-lang = "en" 
        pdes-lang = "hi" 
        .

    ASSIGN 
        psrc-lang = wsrc-lang:screen-value
        pdes-lang = wdes-lang:screen-value
        .
    assign psrc-lang = replace(psrc-lang,"_Ori","").
    assign pdes-lang = replace(pdes-lang,"_Ori","").

    assign pdes-folder-srt = lectures_default.des-folder-srt.
    assign pdes-file-srt = pdes-folder-srt + plectures-filename + "_" + psrc-lang + pdes-lang + ".srt".
    run c:\pvr\translation\lib\generate_srt.p.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnPause
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnPause wWin
ON CHOOSE OF BtnPause IN FRAME fMain /* Pause */
DO:
    /*
    assign pdur-ctrl = false.
    assign ptick = 0.
    */
  chCtrlFrame:WMP:controls:pause().

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnPlay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnPlay wWin
ON CHOOSE OF BtnPlay IN FRAME fMain /* Play */
DO:
  
  /*chCtrlFrame:WMP:URL = "C:\pvr\translation\video\0942-1984-09-16.mp4".*/
  chCtrlFrame:WMP:URL = pmedia-file.
  chCtrlFrame:WMP:controls:play().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearch wWin
ON CHOOSE OF BtnSearch IN FRAME fMain /* <?> */
DO:
    assign plectures-code = int(wlectures-code:screen-value).
    find lectures where lectures.lectures-code = plectures-code no-lock no-error.
    IF available lectures THEN do:
       assign  plectures-filename = lectures.lectures-filename.
    END.

    FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
    IF not available lectures_default THEN do:
       MESSAGE "lectures_default table not available" 
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.


    ASSIGN plectures-spoken-language = lectures.lectures-spoken-language
           plectures-title = lectures.lectures-title.
    assign psrc-folder-temp = lectures_default.src-folder-temp
           pdes-folder-temp = lectures_default.des-folder-temp
                .


    assign
        wsrc-lang:screen-value = "" 
        wdes-lang:screen-value = "" .

  assign wsearch = "*" + wsearch:screen-value + "*".
    assign pmedia-file = "C:\pvr\translation\video\" + plectures-filename + ".mp4".
  /*
  chCtrlFrame:WMP:URL = "c:\temp\candling.mp4".
    */
  /*
  chCtrlFrame:WMP:URL = "C:\pvr\translation\video\plectures-filename" + ".mp4".
    */
  /*
  chCtrlFrame:WMP:controls:stop().
    */
  {&OPEN-QUERY-BROWSE-1}
  APPLY "value-changed" TO browse-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSrtTiming
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSrtTiming wWin
ON CHOOSE OF BtnSrtTiming IN FRAME fMain /* SRT Timing */
DO:
  run c:\pvr\translation\lib\assign_srt_timing.p.
    {&OPEN-QUERY-BROWSE-1}
  APPLY "value-changed" TO browse-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnStop
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnStop wWin
ON CHOOSE OF btnStop IN FRAME fMain /* Stop */
DO:
  chCtrlFrame:WMP:controls:stop().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnTranslate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnTranslate wWin
ON CHOOSE OF BtnTranslate IN FRAME fMain /* Translate */
DO:
    IF wsrc-lang:screen-value = "" THEN do:
       MESSAGE "Please select source language "
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.

    IF wdes-lang:screen-value = "" THEN do:
       MESSAGE "Please select target language "
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.

    IF wsrc-lang:screen-value matches "*ori*" and wdes-lang:screen-value matches "*ori*" THEN do:
       MESSAGE "Cannot translate when both the languages are original"
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.

    FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
    IF not available lectures_default THEN do:
       MESSAGE "lectures_default table not available" 
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.


    MESSAGE "Confirm translation?"
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "" UPDATE choice AS LOGICAL.
    IF not choice THEN do:
       return no-apply.
    END.


    IF ptranslate-one-line THEN do:
    END.
    else do:
         assign pcons-ini = 0
                pcons-fin = 1000000.

    END.

    /*
    ASSIGN 
        psrc-lang = "Hi"
        pdes-lang = "Gu" 
        .
      */
    
    ASSIGN 
        psrc-lang = wsrc-lang:screen-value
        pdes-lang = wdes-lang:screen-value
        .
    assign psrc-lang = replace(psrc-lang,"_Ori","").
    assign pdes-lang = replace(pdes-lang,"_Ori","").




    assign pprocess-type = 5.

    IF pprocess-type = 5 THEN do:
      assign
          psrc-file = psrc-folder-temp + plectures-filename + "_" + psrc-lang + ".srt"
          pdes-file = pdes-folder-temp + plectures-filename + "_" + pdes-lang + ".srt"
          .
    END.
  SESSION:SET-WAIT-STATE("GENERAL").

  assign wstart-time:screen-value = string(time,"HH:MM:SS").
  run c:\pvr\translation\lib\py-command.p.
  assign wEND-time:screen-value = string(time,"HH:MM:SS").
  SESSION:SET-WAIT-STATE("").

  IF ptranslate-one-line THEN do:
  END.
  else do:
       APPLY "Choose" TO BtnSearch.
  END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-4 wWin OCX.Tick
PROCEDURE CtrlFrame-4.PSTimer.Tick .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

DO WITH FRAME {&FRAME-NAME}:
    
END.
IF pdur-ctrl = true THEN do:
     assign ptick = ptick + 1.
     IF ptick = pduration then do:
        apply "Choose" to BTNPAUSE.
        assign ptick = 0.
        /*
        MESSAGE chCtrlFrame:WMP:controls:currenTPOSITION
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
            */
     END.
END.
  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Defaults
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Defaults wWin
ON CHOOSE OF MENU-ITEM m_Defaults /* Defaults */
DO:
    run c:\pvr\translation\obj\wLectures_Default.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Exit wWin
ON CHOOSE OF MENU-ITEM m_Exit /* Exit */
DO:
    chCtrlFrame:WMP:controls:stop().
    run exitObject.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Import_-_Source_Lecture_Eng
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Import_-_Source_Lecture_Eng wWin
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Eng /* Import - Source Lecture English (Original) */
DO:
  DO WITH FRAME {&FRAME-NAME}:
  END.
    MESSAGE "Do you want to import the english original?" skip
      "It will delete all other translation. Are you sure?"
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "" UPDATE choice AS LOGICAL.
  IF not choice THEN do:
     return no-apply.
  END.

  FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
  IF not available lectures_default THEN do:
     MESSAGE "lectures_default table not available" 
         VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.

  assign psrc-folder = lectures_default.src-folder
         pdes-folder = lectures_default.des-folder
      .
  
  assign pprocess-type = 1
         psrc-lang = "en"
         pori-corr = "ori".


  IF pprocess-type = 1 THEN do: /* en */
     assign pspeech-ori-eng-file = psrc-folder + plectures-filename + "_en.srt".
  END.
  /*
  IF pprocess-type = 2 THEN do: /* hi */
     assign pspeech-ori-hin-file = psrc-folder + plectures-filename + "_hi.srt".
  END.
  IF pprocess-type = 3 THEN do: /* hi */
     assign pspeech-ori-mar-file = psrc-folder + plectures-filename + "_ma.srt".
  END.



  IF pprocess-type = 5 THEN do:
    assign
        psrc-file = psrc-folder + "lecture_" + psrc-lang + ".srt"
        pdes-file = pdes-folder + "lecture_" + pdes-lang + ".srt"
        .

  END.
     */

run c:\pvr\translation\lib\import_source_lecture.p.
APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Import_-_Source_Lecture_Eng2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Import_-_Source_Lecture_Eng2 wWin
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Eng2 /* Import - Source Lecture English (Corrected) */
DO:
    DO WITH FRAME {&FRAME-NAME}:
  END.
    MESSAGE "Do you want to import the english original?" skip
      "It will delete all other translation. Are you sure?"
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "" UPDATE choice AS LOGICAL.
  IF not choice THEN do:
     return no-apply.
  END.

  FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
  IF not available lectures_default THEN do:
     MESSAGE "lectures_default table not available" 
         VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.

  assign psrc-folder = lectures_default.src-folder
         pdes-folder = lectures_default.des-folder
      .

  assign pprocess-type = 1
         psrc-lang = "en"
         pori-corr = "corr".

  IF pprocess-type = 1 THEN do: /* en */
     assign pspeech-ori-eng-file = psrc-folder + plectures-filename + "_en.srt".
  END.
  /*
  IF pprocess-type = 2 THEN do: /* hi */
     assign pspeech-ori-hin-file = psrc-folder + plectures-filename + "_hi.srt".
  END.
  IF pprocess-type = 3 THEN do: /* hi */
     assign pspeech-ori-mar-file = psrc-folder + plectures-filename + "_ma.srt".
  END.



  IF pprocess-type = 5 THEN do:
    assign
        psrc-file = psrc-folder + "lecture_" + psrc-lang + ".srt"
        pdes-file = pdes-folder + "lecture_" + pdes-lang + ".srt"
        .

  END.
     */

run c:\pvr\translation\lib\import_source_lecture.p.
APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Import_-_Source_Lecture_Hin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Import_-_Source_Lecture_Hin wWin
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Hin /* Import - Source Lecture Hindi (Original) */
DO:
  DO WITH FRAME {&FRAME-NAME}:
  END.

    FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
    IF not available lectures_default THEN do:
       MESSAGE "lectures_default table not available" 
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.

    assign psrc-folder = lectures_default.src-folder
           pdes-folder = lectures_default.des-folder
        .
    assign pprocess-type = 2
           psrc-lang = "hi"
           pori-corr = "ori".

    IF pprocess-type = 2 THEN do: /* hi */
       assign pspeech-ori-hin-file = psrc-folder + plectures-filename + "_hi.srt".
    END.

  run c:\pvr\translation\lib\import_source_lecture.p.
  
  APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Import_-_Source_Lecture_Hin2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Import_-_Source_Lecture_Hin2 wWin
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Hin2 /* Import - Source Lecture Hindi (Corrected) */
DO:
    DO WITH FRAME {&FRAME-NAME}:
  END.

    FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
    IF not available lectures_default THEN do:
       MESSAGE "lectures_default table not available" 
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.

    assign psrc-folder = lectures_default.src-folder
           pdes-folder = lectures_default.des-folder
        .

    assign pprocess-type = 2
           psrc-lang = "hi"
           pori-corr = "corr".

    IF pprocess-type = 2 THEN do: /* hi */
       assign pspeech-ori-hin-file = psrc-folder + plectures-filename + "_hi.srt".
    END.

  run c:\pvr\translation\lib\import_source_lecture.p.
  
  APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Import_-_Source_Lecture_Mar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Import_-_Source_Lecture_Mar wWin
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Mar /* Import - Source Lecture Marathi (Original) */
DO:
  DO WITH FRAME {&FRAME-NAME}:
  END.
  FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
  IF not available lectures_default THEN do:
     MESSAGE "lectures_default table not available" 
         VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.

  assign psrc-folder = lectures_default.src-folder
         pdes-folder = lectures_default.des-folder
      .

  assign pprocess-type = 1
         psrc-lang = "mr"
         pori-corr = "ori".

  IF pprocess-type = 1 THEN do:
     assign
        pspeech-ori-eng-file = psrc-folder + plectures-filename + ".srt"
         .

  END.
  IF pprocess-type = 2 THEN do:
    assign
        psrc-file = psrc-folder + "lecture_" + psrc-lang + ".srt"
        pdes-file = pdes-folder + "lecture_" + pdes-lang + ".srt"
        .

  END.


run c:\pvr\translation\lib\import_source_lecture.p.
APPLY "Choose" TO BtnSearch.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Import_-_Source_Lecture_Mar2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Import_-_Source_Lecture_Mar2 wWin
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Mar2 /* Import - Source Lecture Marathi (Corrected) */
DO:
    DO WITH FRAME {&FRAME-NAME}:
  END.
  FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
  IF not available lectures_default THEN do:
     MESSAGE "lectures_default table not available" 
         VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.

  assign psrc-folder = lectures_default.src-folder
         pdes-folder = lectures_default.des-folder
      .

  assign pprocess-type = 1
         psrc-lang = "mr"
         pori-corr = "corr".

  IF pprocess-type = 1 THEN do:
     assign
        pspeech-ori-eng-file = psrc-folder + plectures-filename + ".srt"
         .

  END.
  IF pprocess-type = 2 THEN do:
    assign
        psrc-file = psrc-folder + "lecture_" + psrc-lang + ".srt"
        pdes-file = pdes-folder + "lecture_" + pdes-lang + ".srt"
        .

  END.


run c:\pvr\translation\lib\import_source_lecture.p.
APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Languages
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Languages wWin
ON CHOOSE OF MENU-ITEM m_Languages /* Languages */
DO:
    run c:\pvr\translation\obj\wlanguages.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Lectures
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Lectures wWin
ON CHOOSE OF MENU-ITEM m_Lectures /* Lectures */
DO:
    run c:\pvr\translation\obj\wlectures.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wdes-lang
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wdes-lang wWin
ON VALUE-CHANGED OF wdes-lang IN FRAME fMain
DO:
    IF wsrc-lang:screen-value matches "*ori*" and wdes-lang:screen-value matches "*ori*" THEN do:
       MESSAGE "Cannot translate when both the languages are original"
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       assign wdes-lang:screen-value = ?.
       apply "value-changed" to self.

       /*return no-apply.*/
    END.

    APPLY "value-changed" TO browse-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wlectures-code
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wlectures-code wWin
ON LEAVE OF wlectures-code IN FRAME fMain /* Lecture Code */
DO:
    find lectures where lectures.lectures-code = int(self:screen-value) no-lock no-error.
    IF available lectures THEN do:
       assign wlectures-filename:screen-value = lectures.lectures-filename.
    END.
    APPLY "Choose" to BTNSEARCH.

wenglish:screen-value = "".
whindi:screen-value = "".
wother-lang:screen-value = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wlectures-code wWin
ON MOUSE-SELECT-DBLCLICK OF wlectures-code IN FRAME fMain /* Lecture Code */
DO:
  assign plectures-code1 = 0.
  run c:\pvr\translation\diag\glectures.w.
  IF plectures-code1 > 0 THEN DO:
      assign wlectures-code:screen-value = STRING(plectures-code1).
      apply "Leave" to SELF.
  END.
  assign plectures-code1 = 0.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wlectures-filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wlectures-filename wWin
ON LEAVE OF wlectures-filename IN FRAME fMain /* File */
DO:
    APPLY "Choose" to BTNSEARCH.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wlectures-filename wWin
ON MOUSE-SELECT-DBLCLICK OF wlectures-filename IN FRAME fMain /* File */
DO:
  assign plectures-code1 = 0.
  run c:\pvr\translation\diag\glectures.w.
  IF plectures-code1 > 0 THEN DO:
      assign wlectures-code:screen-value = STRING(plectures-code1).
      apply "Leave" to SELF.
  END.
  assign plectures-code1 = 0.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearch wWin
ON ANY-PRINTABLE OF wsearch IN FRAME fMain /* Search */
DO:
    /*
     APPLY "Choose" TO BtnSearch.
     APPLY LAST-EVENT:LABEL TO SELF.
     apply "entry" to self.
     return no-apply.
     */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearch wWin
ON LEAVE OF wsearch IN FRAME fMain /* Search */
DO:
  APPLY "Choose" to BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsrc-lang
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsrc-lang wWin
ON VALUE-CHANGED OF wsrc-lang IN FRAME fMain
DO:
   IF wsrc-lang:screen-value matches "*ori*" and wdes-lang:screen-value matches "*ori*" THEN do:
      MESSAGE "Cannot translate when both the languages are original"
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
       assign wsrc-lang:screen-value = ?.
       apply "value-changed" to self.
   /*return no-apply.*/
    END.

    APPLY "value-changed" TO browse-1.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load wWin  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "wSpeech.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    chCtrlFrame-4 = CtrlFrame-4:COM-HANDLE
    UIB_S = chCtrlFrame-4:LoadControls( OCXFile, "CtrlFrame-4":U)
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "wSpeech.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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
  DISPLAY wlectures-code wlectures-filename wsearch wsrc-lang wdes-lang wenglish 
          whindi wother-lang werror wstart-time wend-time 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE BtnAssignSRTInfo RECT-1 RECT-2 RECT-3 RECT-4 wlectures-code 
         wlectures-filename wsearch BtnSearch wsrc-lang wdes-lang BROWSE-1 
         wenglish whindi wother-lang werror BtnSrtTiming BtnAssignPosition 
         BtnPause BtnPlay btnStop BtnGenerateSrtFile BtnTranslate 
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

  assign plectures-code = 270 /*321*/ /*942*/.
  ASSIGN wlectures-code:screen-value = STRING(plectures-code).


  APPLY "Choose" TO BtnSearch.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

