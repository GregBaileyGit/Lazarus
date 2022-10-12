unit UCustomersFrm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics,
  DBGrids, DBCtrls, ExtCtrls, ComCtrls, RTTIGrids;

type
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


end.

