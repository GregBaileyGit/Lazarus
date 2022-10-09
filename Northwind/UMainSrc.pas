{
================================================================================
used to support form/code separation
================================================================================
}
unit UMainSrc;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  Types, ComCtrls,
  UMainFrm, UFaceToolbelt
  ;

type
  TDTTMainFormCreation = class
  private
    fForm     : TMainFrm;
    fToolbelt : IFaceToolbelt;
  protected
    procedure MenuExit(Sender : TObject);
    procedure MenuAbout(Sender : TObject);
    procedure MenuCustomers(Sender : TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
  public
    constructor Create(aToolbelt : IFaceToolbelt);
    destructor Destroy; override;
  end;

implementation

uses
  Dialogs,
  UCustomersSrc
  ;

procedure TDTTMainFormCreation.MenuExit(Sender: TObject);
begin
  self.fForm.close;
end;

procedure TDTTMainFormCreation.MenuAbout(Sender: TObject);
begin
  ShowMessage('about goes here...');
end;

procedure TDTTMainFormCreation.MenuCustomers(Sender: TObject);
var
  frm : TDTTCustomersFormCreation;
begin
  frm := TDTTCustomersFormCreation.Create(self.fToolbelt);
  frm.Free;
end;

procedure TDTTMainFormCreation.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  {
   show connection icon in statusbar panel:
      Red cirle with white minus symbol (Default - database is not connected)
      Green cirle with white plus symbol (database is connected)
  }
  self.fForm.ImageList1.Draw(
    self.fForm.StatusBar1.Canvas,
    Rect.Left,
    Rect.Top,
    self.fToolbelt.GetMsSqlConnection.Connected.ToInteger
  );
end;

constructor TDTTMainFormCreation.Create(aToolbelt : IFaceToolbelt);
begin
  //create form assing events
  inherited Create;
  self.fToolbelt                        := aToolbelt;
  self.fForm                            := TMainFrm.Create(nil);
  self.fForm.miExit.OnClick             := @self.MenuExit;
  self.fForm.miCustomers.OnClick        := @self.MenuCustomers;
  self.fForm.miAbout.OnClick            := @self.MenuAbout;
  self.fForm.StatusBar1.OnDrawPanel     := @self.StatusBar1DrawPanel;
  self.fForm.StatusBar1.Panels[2].Text  := self.fToolbelt.GetMsSqlConnection.DatabaseName;
  self.fForm.ShowModal;
end;

destructor TDTTMainFormCreation.Destroy;
begin
  self.fForm.Free;
  inherited Destroy;
end;

end.

