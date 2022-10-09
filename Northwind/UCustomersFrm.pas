unit UCustomersFrm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs,
  DBGrids, DBCtrls, ExtCtrls, ComCtrls, RTTIGrids;

type

  { TCustomersFrm }

  TCustomersFrm = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
  private

  public

  end;

var
  CustomersFrm: TCustomersFrm;

implementation

{$R *.lfm}

{ TCustomersFrm }

end.

