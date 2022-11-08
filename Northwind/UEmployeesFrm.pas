unit UEmployeesFrm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBCtrls, DBGrids, ComCtrls, Grids, StdCtrls, RxDBGrid, RxSortSqlDB;

type
  TEmployeesFrm = class(TForm)
    BufDataset1: TBufDataset;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
  private

  public

  end;

var
  EmployeesFrm: TEmployeesFrm;

implementation

{$R *.lfm}

uses
  LCLIntf,
  LCLType,
  UDBGridHelper
  ;

end.
