unit processmanager;

interface

uses windows;

function GetProcessWindow (ProcessId : integer): HWnd; stdcall;
function CloseProcessWindows (ProcessId : integer) : BOOL; stdcall;

exports
    GetProcessWindow,
    CloseProcessWindows;

implementation

uses messages;

  var hwndFound : HWnd;

  function EnumWindowsFunc(Wnd: HWnd; lParam: LPARAM): BOOL; stdcall;
    var pid      : integer;
    begin
      // was the window created by ProcessId?
      GetWindowThreadProcessId(Wnd, @pid);
      if (pid=lParam) then
        begin
          hwndFound := Wnd;
          result    := FALSE;
        end
      else
        result := TRUE;
    end;

function GetProcessWindow (ProcessId : integer): HWnd;
begin
  hwndFound := 0;
  EnumWindows ( @EnumWindowsFunc, ProcessId);
  result := hwndFound;
end;

  function CloseWindowsFunc(Wnd: HWnd; lParam: LPARAM): BOOL; stdcall;
    var pid        : integer;
        wasvisible : BOOL;
    begin
      // was the window created by ProcessId?
      GetWindowThreadProcessId(Wnd, @pid);
      if (pid=lParam) then
        begin
          hwndFound := Wnd;
          wasvisible := ShowWindow(Wnd, SW_SHOWMINNOACTIVE);
          SendMessage(Wnd, WM_CLOSE, 0, 0);
          if (NOT wasvisible) then
             ShowWindow(Wnd, SW_HIDE);
        end;
        result := TRUE;
    end;

function CloseProcessWindows (ProcessId : integer): BOOL;
begin
  hwndFound := 0;
  EnumWindows ( @CloseWindowsFunc, ProcessId);
  result := (hwndFound <> 0);
end;


end.
