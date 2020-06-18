&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File:               AVIWIN.W

  Description:        Plays an AVI file in Progress window

  Input Parameters:
                      <none>

  Output Parameters:
                      <none>

  Author:             Jurjen Dijkstra
                      mailto:jurjen@global-shared.com
                      http://www.global-shared.com

  Created:            Progress 8.2A

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
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


/* DeviveID = unique identifier for opened multi media task */
def var DeviceID as integer no-undo.

/* Application instance of this Prowin.exe */
def var hAppInstance as integer no-undo.

def var AVIclip as char no-undo.
AVIClip = "d:\dlc\bin\pcdbdata.avi".



/* ------------ EXTRA API DEFINITIONS --------------- */

{windows.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-open BUTTON-close 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-close 
     LABEL "Close" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-open 
     LABEL "Open" 
     SIZE 15 BY 1.14.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     BUTTON-open AT ROW 13.62 COL 15
     BUTTON-close AT ROW 13.62 COL 34
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16.

DEFINE FRAME fdisplay
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 6 ROW 1.48
         SIZE 53 BY 11.19.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 15.38
         WIDTH              = 62.6
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 80
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fdisplay:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fdisplay:MOVE-BEFORE-TAB-ITEM (BUTTON-open:HANDLE IN FRAME DEFAULT-FRAME)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fdisplay
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-close
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-close C-Win
ON CHOOSE OF BUTTON-close IN FRAME DEFAULT-FRAME /* Close */
DO:
  run PlayerClose.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-open
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-open C-Win
ON CHOOSE OF BUTTON-open IN FRAME DEFAULT-FRAME /* Open */
DO:
  def var OKpressed as logical no-undo.
  
  SYSTEM-DIALOG GET-FILE Aviclip
     TITLE      "Choose Aviclip to play ..."
     FILTERS    "AVI Files (*.avi)"   "*.avi"
     MUST-EXIST
     USE-FILENAME
     UPDATE OKpressed.

  if OKpressed then
     run PlayerOpen (AVIclip).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.


/* THIS IS IMPORTANT or the AVI-file will stay locked! */
run PlayerClose.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win _DEFAULT-ENABLE
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
  ENABLE BUTTON-open BUTTON-close 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW FRAME fdisplay IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fdisplay}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PlayerClose C-Win 
PROCEDURE PlayerClose :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       Very important to call this before you leave the procedure.
               Is implemented by 'run PlayerClose' after the main wait-for.
------------------------------------------------------------------------------*/

  /* close and destroy the AVI player */
  
  def var mciError as integer no-undo.
  def var ReturnValue as integer no-undo.
  def var lpGenParm as memptr no-undo.
  
  if DeviceID<>0 then do:
     set-size(lpGenParm) = 4.
     put-long(lpGenParm,1) = hAppInstance.
     run mciSendCommand{&A} in hpApi( DeviceID,
                                      2052,  /* MC_CLOSE */
                                      2,     /* flags = MCI_WAIT */
                                      get-pointer-value(lpGenParm),
                                      output mciError).
     DeviceID = 0.
     set-size(lpGenParm)=0.
  end.  

  /* The picture doesn't disappear until the window is repainted.
     So lets repaint the frame now: */  
     
  run InvalidateRect in hpApi ( frame fdisplay:hwnd, 
                                0,   /* NILL = entire client rectangle */
                                1,   /* TRUE = erase background        */
                                OUTPUT ReturnValue).
                      
  run SendMessageA in hpApi (frame fdisplay:hwnd, 
                             {&WM_PAINT},
                             0, 
                             0,
                             output ReturnValue).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PlayerError C-Win 
PROCEDURE PlayerError :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  define input parameter command as char no-undo.
  define input parameter mciError as integer no-undo.
  
  def var ErrorString as char no-undo.
  DEF VAR ReturnValue as INTEGER NO-UNDO.
  
  if mciError=0 then return.
  
     ErrorString = fill(" ",200).
     run mciGetErrorString{&A} in hpApi (mciError,
                                         output ErrorString,
                                         length(ErrorString),
                                         output ReturnValue).
                               
     message "Error during " command skip
             "mciError status=" mciError skip
             ErrorString
             view-as alert-box.                       

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PlayerOpen C-Win 
PROCEDURE PlayerOpen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  define input parameter AVIFileName as char no-undo.

  def var flags as integer no-undo.
  def var lpOpenParms as memptr no-undo.    /* = type MCI_OPEN_PARMS */
  def var lpDeviceType as memptr no-undo.
  def var lpElementName as memptr no-undo.
  def var lpAlias as memptr no-undo.
  
  def var mciError as integer no-undo.
  
  /* we need to know the application instance of the current
     program (=prowin32.exe). We can read it from any window: */
     
  run GetWindowLong{&A} in hpApi ( frame fDisplay:HWND,  
                                   -6,  /* = GWL_HINSTANCE */ 
                                   output hAppInstance).


  /* Close previous AVI-file, if any: */
  if DeviceID<>0 then
     run PlayerClose.
  
  /* -------- first step: open device ------------ */
  
  flags = 0
          + 2     /* = mci_wait           */ 
          + 512   /* = mci_open_element   */
          + 8192  /* = mci_open_type      */
      /*  + 256   /* = mci_open_shareable */ does not work?? */
          .
  /* don't use the mci_notify flag (=1) because you can't catch events anyway */
 
  set-size(lpOpenParms) =   4  /* = dwCallBack       */  
                          + 4  /* = wDeviceID        */
                          + 4  /* = lpstrDeviceName  */
                          + 4  /* = lpstrElementName */
                          + 4. /* = lpstrAlias       */
  
  set-size(lpDeviceType)     = length("AVIVideo") + 1.
  put-string(lpDeviceType,1) = "AVIVideo".
  
  set-size(lpElementName)     = length(AviFileName) + 1.
  put-string(lpElementName,1) = AVIFileName.
  
  /* Alias has no effect because mci_open_shareable was not used: */
  set-size(lpAlias)     = length("UniqueName") + 1.
  put-string(lpAlias,1) = "UniqueName".
  
  put-long (lpOpenParms, 1) = hAppInstance.
  put-long (lpOpenParms, 5) = 0.
  put-long (lpOpenParms, 9) = get-pointer-value(lpDeviceType).
  put-long (lpOpenParms,13) = get-pointer-value(lpElementName).
  put-long (lpOpenParms,17) = get-pointer-value(lpAlias).
  
  run mciSendCommand{&A} in hpApi ( 0, 
                                    2051,  /* = MCI_OPEN */
                                    flags, 
                                    get-pointer-value(lpOpenParms),
                                    output mciError).
                       
  if mciError<>0 then
     run PlayerError("Open", mciError).

  DeviceID = get-long (lpOpenParms, 5).
    
  set-size(lpAlias) = 0.
  set-size(lpOpenParms) = 0.
  set-size(lpDeviceType) = 0.
  set-size(lpElementName) = 0.

  if mciError<>0 then return.
  
  /* ---------- next step: redirect output to frame fdisplay ----------- */
  def var lpAnimParms as memptr.
  
  flags = 0
          + 2 /* mci_wait */
          +  65536  /* mci_Anim_Window_hWnd */
          .
  
  set-size(lpAnimParms)=16.
  put-long(lpAnimParms,5) = frame fdisplay:hwnd.
  
  run mciSendCommand{&A} in hpApi ( DeviceID, 
                                    2113,  /* = MCI_WINDOW */
                                    flags, 
                                    get-pointer-value(lpAnimParms),
                                    output mciError).
                       
  if mciError<>0 then 
     run PlayerError("Window", mciError).
    
  set-size(lpAnimParms) = 0.
  
  if mciError<>0 then return.
  
  /* ---------- last step: PLAY the avi ----------- */
  
  def var lpPlayParms as memptr no-undo.
  set-size(lpPlayParms) = 12.
  
  flags = 65536. /* = mci_dgv_play_repeat,  makes it loop forever */
  /* don't use the mci_wait flag in this step or it will not be a background task */
          
  put-long(lpPlayParms,5) = 0.  /* first frame, ignored because flags not set */
  put-long(lpPlayParms,9) = 0.  /* last frame, ignored because flags not set  */
  
  run mciSendCommand{&A} in hpApi ( DeviceID, 
                                    2054,  /* = MCI_PLAY */
                                    flags, 
                                    get-pointer-value(lpPlayParms),
                                    output mciError).

  if mciError<>0 then
     run PlayerError("Play", mciError).

  set-size(lpPlayParms) = 0.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


