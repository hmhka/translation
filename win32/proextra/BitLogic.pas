// =========================================================================
// file      BitLogic.Pas
// by        Jurjen Dijkstra, 1997
// language  Delphi 2.01
// project   ProExtra.DLL
// =========================================================================
unit BitLogic;

interface

procedure Bit_Remove(var Flags : longint; OldFlag  : longint); stdcall;
procedure Bit_Or    (var Flags : longint; NewFlag  : longint); stdcall;
procedure Bit_Xor   (var Flags : longint; NewFlag  : longint); stdcall;
function  Bit_And   (    Flags : longint; TestFlag : longint): longint; stdcall;

exports
   Bit_Or,
   Bit_And,
   Bit_Xor,
   Bit_Remove;

implementation

procedure Bit_Remove(var Flags : longint; OldFlag : longint);
begin
   Flags := Flags AND (NOT OldFlag);
end;

procedure Bit_Or(var Flags : longint; NewFlag : longint);
begin
   Flags := Flags OR NewFlag;
end;

procedure Bit_Xor(var Flags : longint; NewFlag : longint);
begin
   Flags := Flags XOR NewFlag;
end;

function  Bit_And(Flags : longint; TestFlag : longint) : longint;
begin
  Result := Flags AND TestFlag;
end;

end.
