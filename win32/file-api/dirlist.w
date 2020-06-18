&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wndMain
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wndMain 
/*------------------------------------------------------------------------

  File: dirlist.w

  Description: Comparison of different directory listing methods

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: Stu Churchill    (schurch@stanley.co.uk)
          Jurjen Dijkstra  added file-api and BtnFindLoop,
                           adapted api calls to 'conventions' used
                           on http://www.global-shared.com

  Created: 03/13/97 -  8:12 pm

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

{windows.i}
{File-Api.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fraMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btnInputThrough btnWinAPI BtnFileLoop ~
lstDirs lstFiles 
&Scoped-Define DISPLAYED-OBJECTS lstDirs lstFiles 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wndMain AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnFileLoop 
     LABEL "FileFindLoop" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnInputThrough 
     LABEL "Input Through" 
     SIZE 16.4 BY 1.1.

DEFINE BUTTON btnWinAPI 
     LABEL "LB_DIR" 
     SIZE 16.4 BY 1.1.

DEFINE VARIABLE lstDirs AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE NO-DRAG SORT SCROLLBAR-VERTICAL 
     SIZE 31.4 BY 5.67 NO-UNDO.

DEFINE VARIABLE lstFiles AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE NO-DRAG SORT SCROLLBAR-VERTICAL 
     SIZE 32.8 BY 5.76 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fraMain
     btnInputThrough AT ROW 1.24 COL 3.2
     btnWinAPI AT ROW 1.24 COL 21
     BtnFileLoop AT ROW 1.24 COL 39
     lstDirs AT ROW 4.91 COL 2.4 NO-LABEL
     lstFiles AT ROW 4.91 COL 36 NO-LABEL
     "Directories" VIEW-AS TEXT
          SIZE 13.6 BY .62 AT ROW 4 COL 2.4
     "Files" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 4 COL 36
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 69 BY 10.04.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: WINDOW
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wndMain ASSIGN
         HIDDEN             = YES
         TITLE              = "Directory List Comparison"
         COLUMN             = 24
         ROW                = 8
         HEIGHT             = 10.19
         WIDTH              = 69.2
         MAX-HEIGHT         = 22
         MAX-WIDTH          = 96.4
         VIRTUAL-HEIGHT     = 22
         VIRTUAL-WIDTH      = 96.4
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = yes
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
/* SETTINGS FOR WINDOW wndMain
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fraMain
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wndMain)
THEN wndMain:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME BtnFileLoop
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnFileLoop wndMain
ON CHOOSE OF BtnFileLoop IN FRAME fraMain /* FileFindLoop */
DO:
  def var a as integer no-undo.
  
    lstFiles:LIST-ITEMS = "".
    lstDirs:LIST-ITEMS = "".
    STATUS INPUT "".

    a = ETIME(YES).

    run FileFindLoop in hpFileApi ("c:\windows\*.*", 
                                   "ProcessCallBack", 
                                   this-procedure).

    STATUS INPUT "Elapsed time : " + STRING(ETIME) + " milliseconds".

END.

procedure ProcessCallBack :
   define input parameter lpFindData as memptr.
   
   def var FileName as char no-undo.
   def var Flags as integer no-undo.
   def var result as integer no-undo.
   def var bResult as logical no-undo.

   run FileInfo_LongName in hpFileApi (lpFindData, output FileName).
   Flags = get-long(lpFindData, 1).
   
   run Bit_And in hpExtra(Flags, {&DDL_DIRECTORY}, output result).
   if result<>0 then
      bResult=lstDirs:ADD-FIRST(FileName) in frame {&FRAME-NAME}.
   else
      bResult=lstFiles:ADD-FIRST(FileName) in frame {&FRAME-NAME}.
      
end procedure.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInputThrough
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInputThrough wndMain
ON CHOOSE OF btnInputThrough IN FRAME fraMain /* Input Through */
DO:

    DEFINE VARIABLE bResult AS LOGICAL.
    DEFINE VARIABLE sBuffer AS CHARACTER.
    DEFINE VARIABLE sFlags AS CHARACTER.
    DEFINE VARIABLE sFile AS CHARACTER.
    DEFINE VARIABLE a AS INTEGER.

    lstFiles:LIST-ITEMS = "".
    lstDirs:LIST-ITEMS = "".
    STATUS INPUT "".

    a = ETIME(YES).

    /* supports long names */
    
    INPUT FROM OS-DIR ("C:\WINDOWS") NO-ECHO.
    REPEAT:
        IMPORT sFile sBuffer sFlags.
        IF sFlags = "F" THEN DO:
            bResult = lstFiles:ADD-FIRST(sFile).
        END.
        ELSE IF sFlags = "D" THEN DO:
            bResult = lstDirs:ADD-FIRST(sFile).
        END.
    END.
    INPUT CLOSE.

    STATUS INPUT "Elapsed time : " + STRING(ETIME) + " milliseconds".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnWinAPI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnWinAPI wndMain
ON CHOOSE OF btnWinAPI IN FRAME fraMain /* LB_DIR */
DO:

    DEFINE VARIABLE lpMask      AS MEMPTR.
    DEFINE VARIABLE a           AS INTEGER NO-UNDO.
    DEFINE VARIABLE ReturnValue AS INTEGER NO-UNDO.

    lstFiles:LIST-ITEMS = "".
    lstDirs:LIST-ITEMS = "".
    STATUS INPUT "".

    a = ETIME(YES).

    /* this method is extremely fast but does NOT appear to support long names */
    
    set-size(lpMask) = 20.
    put-string(lpMask,1)= "C:\windows\*.*".

    RUN SendMessage{&A} in hpApi (lstDirs:HWND,
                                  {&LB_DIR}, 
                                  {&DDL_DIRECTORY} + {&DDL_EXCLUSIVE}, 
                                  get-pointer-value(lpMask),
                                  output ReturnValue).
    RUN SendMessage{&A} in hpApi  (lstFiles:HWND,
                                  {&LB_DIR}, 
                                  {&DDL_ARCHIVE} + {&DDL_SYSTEM} + {&DDL_HIDDEN} + {&DDL_READONLY}, 
                                  get-pointer-value(lpMask),
                                  output ReturnValue).

    STATUS INPUT "Elapsed time : " + STRING(ETIME) + " milliseconds".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wndMain 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* These events will close the window and terminate the procedure.      */
/* (NOTE: this will override any user-defined triggers previously       */
/*  defined on the window.)                                             */
ON WINDOW-CLOSE OF {&WINDOW-NAME} DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.
ON ENDKEY, END-ERROR OF {&WINDOW-NAME} ANYWHERE DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  STATUS INPUT "".
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wndMain _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wndMain)
  THEN DELETE WIDGET wndMain.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wndMain _DEFAULT-ENABLE
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
  DISPLAY lstDirs lstFiles 
      WITH FRAME fraMain IN WINDOW wndMain.
  ENABLE btnInputThrough btnWinAPI BtnFileLoop lstDirs lstFiles 
      WITH FRAME fraMain IN WINDOW wndMain.
  {&OPEN-BROWSERS-IN-QUERY-fraMain}
  VIEW wndMain.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


