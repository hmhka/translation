// =========================================================================
// file      Misc.Pas
// by        Cyril O' Floinn, 1998
//           based on an example made by Marko alias lonewolf
//           http://homepages.tig.com.au/~lonewolf
// language  Delphi 3.
// =========================================================================
unit Misc;

interface

uses Windows;

function BrowseForFolder (
         OwnerWin       : HWnd;
         BrowseTitle    : PAnsiChar;
         BrowseFlags    : UINT;
         BrowseInitial  : PAnsiChar;
         FolderName     : PAnsiChar
         ): BOOL; stdcall;

exports
    BrowseForFolder;

implementation

uses Classes, ActiveX, ShellApi, ShlObj;

function BrowseCallbackProc(Wnd: HWnd; Msg: UINT; lParam: LPARAM;
                                   lData: LPARAM): integer; stdcall;
begin
  Result := 0;
  {upon startup, set the selection to the intial directory desired}
  if Msg = BFFM_INITIALIZED then begin
    SendMessage(Wnd, BFFM_SETSELECTION, WPARAM(False), lData);
  end; {if}
end;


function BrowseForFolder (
         OwnerWin       : HWnd;
         BrowseTitle    : PAnsiChar;
         BrowseFlags    : UINT;
         BrowseInitial  : PAnsiChar;
         FolderName     : PAnsiChar
         ): BOOL;
var
   MyShellMalloc : IMalloc;     // IMalloc task allocator
   MyBrowseInfo : TBrowseInfo;
   MyItemIDList, TheItemIDList, SelectionIDList : PItemIDList;
   ShellFolder: IShellFolder;          // the powerful IShellFolder interface
   OLEStr: array[0..MAX_PATH] of TOLEChar;    // need to use OLE strings
   DisplayName: array[0..MAX_PATH] of char;
   Eaten, Attr: ULONG;
   Success : Boolean;
   InitialDir : String;
begin
    {indicate no folder selected}
    Result := False;
    {Convert PAnsiChar to String}
    InitialDir := BrowseInitial;
    {Initialize TBrowseInfo}
    FillChar(MyBrowseInfo, sizeof(TBrowseInfo), #0);

    {This call is necessary as it retrieves a pointer to the IMalloc interface
    of the Win95 shell, which in turn is used to free memory that was allocated
    by the shell; something that certain shell functions require.}

    SHGetMalloc(MyShellMalloc);

    {Retrieve a pointer to an item identifier list specifying the location
    of the DeskTop virtual folder relative to the desktop folder}

    SHGetSpecialFolderLocation(OwnerWin, CSIDL_DESKTOP, MyItemIDList);
    try

      {MyItemIDList will be the root folder for the Browse Directory
      dialog. But what if you want a directory to be initially selected?
      Well, you first need to retrieve its item identifier. We do this
      via the IShellFolder interface for the desktop folder}

      if SHGetDesktopFolder(ShellFolder) = NO_ERROR then begin

        {The ParseDisplayName method will do the trick. But we need to
        make sure our directory string is a null-terminated Unicode string
        We use the StringToWideChar function to convert it properly}

        if ShellFolder.ParseDisplayName(OwnerWin, nil,
             StringToWideChar(InitialDir, OLEStr, MAX_PATH), Eaten,
             SelectionIDList, Attr) = NO_ERROR then
          Success := True
        else
          Success := False;
      end else
        Success := False;

      {Before calling the function which brings up the dialog editor,
      we need to fill in the members of the relevant structure TBrowseInfo}

      try
        with MyBrowseInfo do begin
          hwndOwner := OwnerWin;    // owner of dialog window
          pidlRoot := MyItemIDList; // specified the root folder
          pszDisplayName := @DisplayName; // this receives the selected folder
          lpszTitle := BrowseTitle; // dialog title
          ulFlags := BrowseFlags;   // folder filter
          if Success then begin

            {OK, this is the second part of selecting the initial directory
            of the browse dialog. lpfn points to a callback function, which
            the dialog window calls whenever events occur. One of the
            events is the opening of the dialog window. When this occurs
            we will send a selection message to browse dialog window,
            which will select the intial directory of our choice}

            lpfn := BrowseCallbackProc;

            {lParam gets passed to the callback function. It represents
            the item identifier (obtained above) of the directory we
            wish to select}

            lParam := Integer(SelectionIDList);
          end else begin

            {If, for whatever reason we couldn't obtain item identifier
            we set the callback function to nil}

            lpfn := nil;
            lParam := 0;
          end;
        end;

        {Here is where the dialog is called up for display, finally!
        The return result is the item identifier for the directory
        which was chosen by the user}

        TheItemIDList := SHBrowseForFolder(MyBrowseInfo);
        try
          {Convert the item identfier into a directory name}
          if SHGetPathFromIDList(TheItemIDList, FolderName) then
            Result := Bool(True);
        finally
          {It is very important that free the item identfiers}
          MyShellMalloc.Free(TheItemIDList); // Clean-up
        end;
      finally
        MyShellMalloc.Free(SelectionIDList); // Clean-up.
      end;
    finally
      MyShellMalloc.Free(MyItemIDList); // Clean-up.
    end;

end;

end.
