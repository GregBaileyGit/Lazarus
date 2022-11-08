unit UMainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls;

type
  TMainFrm = class(TForm)
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    miEmployees: TMenuItem;
    miCustomers: TMenuItem;
    MenuItem4: TMenuItem;
    miAbout: TMenuItem;
    miExit: TMenuItem;
    StatusBar1: TStatusBar;
  private

  public

  end;

var
  MainFrm: TMainFrm;

implementation

{$R *.lfm}

end.

