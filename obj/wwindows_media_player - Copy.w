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

def var ptick as int.

def var pdur-ctrl as log.
def var pduration as int.
assign ptick = 0.

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
&Scoped-Define ENABLED-OBJECTS BtnExit btnStop BtnCurrentPosition BtnPlay ~
BtnPause BtnAssignPosition 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE CtrlFrame-4 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame-4 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnAssignPosition 
     LABEL "Assign Position" 
     SIZE 20.33 BY 1.12.

DEFINE BUTTON BtnCurrentPosition 
     LABEL "Current Position" 
     SIZE 19.33 BY 1.12.

DEFINE BUTTON BtnExit 
     LABEL "Exit" 
     SIZE 15 BY 1.12.

DEFINE BUTTON BtnPause 
     LABEL "Pause" 
     SIZE 15 BY 1.12.

DEFINE BUTTON BtnPlay 
     LABEL "Play" 
     SIZE 15 BY 1.12.

DEFINE BUTTON btnStop 
     LABEL "Stop" 
     SIZE 15 BY 1.12.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BtnExit AT ROW 2.15 COL 60.33 WIDGET-ID 20
     btnStop AT ROW 11.38 COL 8 WIDGET-ID 6
     BtnCurrentPosition AT ROW 11.38 COL 44.17 WIDGET-ID 10
     BtnPlay AT ROW 12.58 COL 8.33 WIDGET-ID 4
     BtnPause AT ROW 13.81 COL 8.5 WIDGET-ID 8
     BtnAssignPosition AT ROW 13.96 COL 54.33 WIDGET-ID 22
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 17 WIDGET-ID 100.


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
         HEIGHT             = 17
         WIDTH              = 80
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
         MESSAGE-AREA       = yes
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 1.31
       COLUMN          = 2.17
       HEIGHT          = 8.96
       WIDTH           = 52.5
       WIDGET-ID       = 2
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME CtrlFrame-4 ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 6.23
       COLUMN          = 62.17
       HEIGHT          = 3.85
       WIDTH           = 16.67
       WIDGET-ID       = 28
       HIDDEN          = yes
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {6BF52A52-394A-11d3-B153-00C04F79FAA6} type: WMP */
      CtrlFrame-4:NAME = "CtrlFrame-4":U .
/* CtrlFrame-4 OCXINFO:CREATE-CONTROL from: {F0B88A90-F5DA-11CF-B545-0020AF6ED35A} type: PSTimer */
      CtrlFrame:MOVE-BEFORE(BtnExit:HANDLE IN FRAME fMain).
      CtrlFrame-4:MOVE-AFTER(BtnExit:HANDLE IN FRAME fMain).

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
    DEF VAR pcur-pos-ini as int.
    def var pcur-ini as char.

    DEF VAR pcur-pos-fin as int.
    def var pcur-fin as char.
    def var pdur as int.

    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT "00:01:00,000", output pcur-pos-ini).
    assign pcur-ini = string(pcur-pos-ini / 1000).

    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT "00:01:03,000", output pcur-pos-fin).
    assign pcur-fin = string(pcur-pos-fin / 1000).

    assign pdur = INT(pcur-fin) - INT(pcur-ini).

    chCtrlFrame:WMP:controls:currenTPOSITION = pcur-ini.

    apply "Choose" to BtnPlay.  
    
    assign pduration = 300.
    assign pduration = pdur + 3.
    assign ptick = 0.
    assign pdur-ctrl = true.
    /*
    chCtrlFrame:WMP:controls:currenTPOSITION = "100".
      */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnCurrentPosition
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnCurrentPosition wWin
ON CHOOSE OF BtnCurrentPosition IN FRAME fMain /* Current Position */
DO:
    /*
  chCtrlFrame:WMP:controls:stop().
  chCtrlFrame:WMP:controls:currentPosition = "00:02:00".
  */

    /*
    chCtrlFrame:WMP:timer:Interval = 1000.
    chCtrlFrame:WMP:timer:Start().
    */
    /*chCtrlFrame:WMP:controls:controls:fastForward().*/
    MESSAGE  chCtrlFrame:WMP:controls:currentPosition
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
    

        /*
    MESSAGE  chCtrlFrame:WMP:currentPositionLabel:Text()
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
        */
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnExit wWin
ON CHOOSE OF BtnExit IN FRAME fMain /* Exit */
DO:
  run exitobject.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnExit wWin
ON GO OF BtnExit IN FRAME fMain /* Exit */
DO:
  apply "Choose" to BTNSTOP.
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
  chCtrlFrame:WMP:URL = "c:\temp\candling.mp4".
  chCtrlFrame:WMP:controls:play().
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
        MESSAGE chCtrlFrame:WMP:controls:currenTPOSITION
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
     END.
END.



END PROCEDURE.

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

OCXFile = SEARCH( "wwindows_media_player.wrx":U ).
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
ELSE MESSAGE "wwindows_media_player.wrx":U SKIP(1)
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
  ENABLE BtnExit btnStop BtnCurrentPosition BtnPlay BtnPause BtnAssignPosition 
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
  DO WITH FRAME {&FRAME-NAME}:
      
  END.
  APPLY "Choose" to btnStop.
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

