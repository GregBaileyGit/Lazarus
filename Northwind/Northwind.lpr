program Northwind;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UMainFrm, UMainSrc, UFaceToolbelt, UToolbelt
  { you can add units after this };

{$R *.res}


procedure Main;
var
  frm : TDTTMainFormCreation;
begin

  frm := TDTTMainFormCreation.Create(TDTTToolbelt.Create('Northwind'));
  frm.Free;
end;

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Main;
  {
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
  }


end.

