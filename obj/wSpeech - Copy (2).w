&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BtnAssignPosition RECT-1 RECT-2 RECT-3 ~
RECT-4 wsearch BtnSearch wdes-lang BtnPause wsrc-lang BtnPlay btnStop ~
BtnGenerateSrtFile BtnTranslate 
&Scoped-Define DISPLAYED-OBJECTS wsearch wdes-lang wsrc-lang wstart-time ~
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
       MENU-ITEM m_Import_-_Source_Lecture_Eng LABEL "Import - Source Lecture English"
       MENU-ITEM m_Import_-_Source_Lecture_Hin LABEL "Import - Source Lecture Hindi"
       MENU-ITEM m_Import_-_Source_Lecture_Mar LABEL "Import - Source Lecture Marathi".

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

DEFINE BUTTON btnStop  NO-FOCUS FLAT-BUTTON
     LABEL "Stop" 
     SIZE 8 BY .81
     FONT 4.

DEFINE BUTTON BtnTranslate  NO-FOCUS FLAT-BUTTON
     LABEL "Translate" 
     SIZE 14.33 BY .81.

DEFINE VARIABLE wdes-lang AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "","",
                     "English","en",
                     "Hindi","hi",
                     "Marathi","mr",
                     "Gujrati","gu",
                     "Tamil","ta",
                     "Tagalog","tl",
                     "Kannada","kn",
                     "Spanish","es",
                     "Persian","fa",
                     "Chinese","zh-CN"
     DROP-DOWN-LIST
     SIZE 16 BY 1
     FONT 4 NO-UNDO.

DEFINE VARIABLE wend-time AS CHARACTER FORMAT "X(256)":U 
     LABEL "End" 
     VIEW-AS FILL-IN 
     SIZE 10.33 BY .81 NO-UNDO.

DEFINE VARIABLE wsearch AS CHARACTER FORMAT "X(256)":U 
     LABEL "Search" 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY .81 NO-UNDO.

DEFINE VARIABLE wstart-time AS CHARACTER FORMAT "X(256)":U 
     LABEL "Start" 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY .81 NO-UNDO.

DEFINE VARIABLE wsrc-lang AS CHARACTER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "", "",
"English", "en",
"Hindi", "hi",
"Marathi", "ma"
     SIZE 28.67 BY .73 TOOLTIP "Source Language"
     FONT 4 NO-UNDO.

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


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BtnAssignPosition AT ROW 13.04 COL 27 WIDGET-ID 84
     wsearch AT ROW 1.5 COL 9.5 COLON-ALIGNED WIDGET-ID 12
     BtnSearch AT ROW 1.5 COL 32.5 WIDGET-ID 10
     wdes-lang AT ROW 1.58 COL 69 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     BtnPause AT ROW 13.04 COL 19 WIDGET-ID 8
     wsrc-lang AT ROW 1.62 COL 40.5 NO-LABEL WIDGET-ID 34
     BtnPlay AT ROW 13.04 COL 3.33 WIDGET-ID 4
     btnStop AT ROW 13.04 COL 11.17 WIDGET-ID 6
     wstart-time AT ROW 20.88 COL 9.17 COLON-ALIGNED WIDGET-ID 22
     BtnGenerateSrtFile AT ROW 1.5 COL 105 WIDGET-ID 80
     wend-time AT ROW 20.92 COL 27.33 COLON-ALIGNED WIDGET-ID 24
     BtnTranslate AT ROW 1.5 COL 89.17 WIDGET-ID 18
     "Target Lang." VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 1 COL 70.67 WIDGET-ID 64
          FONT 4
     "Source Lang." VIEW-AS TEXT
          SIZE 11.33 BY .62 AT ROW 1 COL 39.83 WIDGET-ID 62
          FONT 4
     RECT-1 AT ROW 1.27 COL 39.33 WIDGET-ID 66
     RECT-2 AT ROW 1.27 COL 69.67 WIDGET-ID 68
     RECT-3 AT ROW 1.27 COL 88.33 WIDGET-ID 70
     RECT-4 AT ROW 1.27 COL 104 WIDGET-ID 82
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 179.33 BY 21.38 WIDGET-ID 100.


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
         HEIGHT             = 21.38
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
/* SETTINGS FOR FILL-IN wend-time IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wstart-time IN FRAME fMain
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 2.73
       COLUMN          = 4
       HEIGHT          = 8.96
       WIDTH           = 52.5
       WIDGET-ID       = 2
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME CtrlFrame-4 ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 19.77
       COLUMN          = 1.5
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
      CtrlFrame:MOVE-AFTER(wsrc-lang:HANDLE IN FRAME fMain).
      CtrlFrame-4:MOVE-AFTER(CtrlFrame).

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


&Scoped-define SELF-NAME BtnAssignPosition
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnAssignPosition wWin
ON CHOOSE OF BtnAssignPosition IN FRAME fMain /* Assign Position */
DO:
    
    
   
    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT ptime-from, output pcur-pos-ini).
    assign pcur-ini = string(pcur-pos-ini / 1000) no-error.
      

   

    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT ptime-to, output pcur-pos-fin) no-error.


    assign pcur-fin = string(pcur-pos-fin / 1000) no-error.
      
     
    assign pdur = INT(pcur-fin) - INT(pcur-ini).

    chCtrlFrame:WMP:controls:currenTPOSITION = pcur-ini.

    
    /*
    assign pduration = 300.
    */
    assign pduration = pdur + 3.
    assign ptick = 0.
    assign pdur-ctrl = true.
    /*
    chCtrlFrame:WMP:controls:currenTPOSITION = "100".
      */
      
    apply "Choose" to BtnPlay.  
    

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
  chCtrlFrame:WMP:controls:play().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearch wWin
ON CHOOSE OF BtnSearch IN FRAME fMain /* <?> */
DO:
  assign wsearch = "*" + wsearch:screen-value + "*".

  /*
  chCtrlFrame:WMP:URL = "c:\temp\candling.mp4".
    */
  
  chCtrlFrame:WMP:URL = "C:\pvr\translation\video\plectures-filename" + ".mp4".
  
  /*
  chCtrlFrame:WMP:controls:stop().
    */
  /*
  {&OPEN-QUERY-BROWSE-1}
  APPLY "value-changed" TO browse-1.
  */
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

    assign psrc-folder-temp = lectures_default.src-folder-temp
           pdes-folder-temp = lectures_default.des-folder-temp
        .
    ASSIGN 
        psrc-lang = "Hi"
        pdes-lang = "Gu" 
        .

    
    ASSIGN 
        psrc-lang = wsrc-lang:screen-value
        pdes-lang = wdes-lang:screen-value
        .

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
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Eng /* Import - Source Lecture English */
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
  ASSIGN 
      psrc-lang = "Hi" 
      pdes-lang = "Gu" 
      .
  assign pprocess-type = 1.

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
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Hin /* Import - Source Lecture Hindi */
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
    ASSIGN 
        psrc-lang = "Hi" 
        pdes-lang = "Gu" 
        .
    assign pprocess-type = 2.

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
ON CHOOSE OF MENU-ITEM m_Import_-_Source_Lecture_Mar /* Import - Source Lecture Marathi */
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
  ASSIGN 
      psrc-lang = "Hi" 
      pdes-lang = "Ma" 
      .
  assign pprocess-type = 1.

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
    /*APPLY "value-changed" TO browse-1.*/
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

OCXFile = SEARCH( "wSpeech - Copy (2).wrx":U ).
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
ELSE MESSAGE "wSpeech - Copy (2).wrx":U SKIP(1)
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
  DISPLAY wsearch wdes-lang wsrc-lang wstart-time wend-time 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE BtnAssignPosition RECT-1 RECT-2 RECT-3 RECT-4 wsearch BtnSearch 
         wdes-lang BtnPause wsrc-lang BtnPlay btnStop BtnGenerateSrtFile 
         BtnTranslate 
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

  assign plectures-code = 942.

  find lectures where lectures.lectures-code = plectures-code no-lock no-error.
  IF available lectures THEN do:
     assign  plectures-filename = lectures.lectures-filename.
  END.

  assign
      wsrc-lang:screen-value = " " 
      wdes-lang:screen-value = " " .


  APPLY "Choose" TO BtnSearch.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

