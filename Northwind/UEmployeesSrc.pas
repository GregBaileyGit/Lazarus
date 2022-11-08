unit UEmployeesSrc;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  DBGrids,
  Grids,
  UEmployeesFrm,
  UFaceToolbelt
  ;

type
  TDTTEmployeesFormCreation = class
  private
    fForm     : TEmployeesFrm;
    fToolbelt : IFaceToolbelt;
  protected
    procedure LoadEmployees(Sender : TObject);
    procedure MemoText(sender: TObject; DataCol: Integer;
       Column: TColumn; AState: TGridDrawState);

    procedure Sort(Column: TColumn);
  public
    constructor Create(aToolbelt : IFaceToolbelt);
    destructor Destroy; override;
  end;

implementation

uses
  Dialogs,
  db,
  Graphics,
  sqlDB,
  UDBGridHelper
  ;

procedure TDTTEmployeesFormCreation.LoadEmployees(Sender: TObject);
var
  Qry : TSQLQuery;
  Frm : TEmployeesFrm;
begin
  Frm := self.fForm;
  Qry := self.fToolbelt.GetMsSqlQuery1;
  Qry.Clear;
  Qry.Sql.Text := ''                                                                        +
    'select '                                                                               +
  	'  Emp.EmployeeID							          as ID, '                                        +
  	'  Emp.Country, '                                                                       +
  	'  Emp.TitleOfCourtesy				          as Prefix, '                                    +
  	'  Emp.LastName								          as [LastName], '                                +
  	'  Emp.FirstName							          as [FirstName], '                               +
  	'  EmpArea.TerritoryID				          as [AreaID], '                                  +
    '  Area.TerritoryDescription	          as [AreaDesc], '                                +
  	'  Reg.RegionID								          as [RegionID], '                                +
  	'  Reg.RegionDescription			          as [RegionDesc], '                              +
  	'  Emp.Photo, '                                                                         +
  	'  Emp.Title, '                                                                         +
  	'  Convert(varchar, Emp.BirthDate, 101) as Birthdate, '                                 +
  	'  Convert(varchar, Emp.HireDate , 101) as [HireDate], '                                +
  	'  Emp.Address, '                                                                       +
  	'  Emp.City, '                                                                          +
  	'  Emp.Region, '                                                                        +
  	'  Emp.PostalCode, '                                                                    +
  	'  Emp.HomePhone 							          as [HomePhone#], '                              +
  	'  Emp.Extension, '                                                                     +
  	'  Cast(Emp.Notes as Text)              as Notes, '                                                                         +
  	'  Emp.ReportsTo, '                                                                     +
  	'  Emp.PhotoPath '                                                                      +
    'from Employees Emp '                                                                   +
    '  left  join EmployeeTerritories EmpArea on EmpArea.EmployeeID = Emp.EmployeeID '      +
    '  inner join Territories	  	    Area		on Area.TerritoryID   = EmpArea.TerritoryID ' +
    '  inner join Region							Reg		  on Reg.RegionID       = Area.RegionID '       +
    'order by '                                                                             +
    '	 Emp.Country desc, '                                                                  +
    '  Emp.LastName, '                                                                      +
    '  Emp.FirstName, '                                                                     +
    '  Area.TerritoryDescription '                                                          +
    ''
  ;
  Qry.Active := True;

  frm.BufDataset1.CopyFromDataset(Qry);
  frm.BufDataset1.Active := True;

  frm.DBGrid1.Columns[frm.BufDataset1.FieldByName('Title'  ).Index].Width := 150;
  frm.DBGrid1.Columns[frm.BufDataset1.FieldByName('Address').Index].Width := 150;
  frm.DBGrid1.Columns[frm.BufDataset1.FieldByName('City'   ).Index].Width :=  75;
  frm.DBGrid1.Columns[frm.BufDataset1.FieldByName('Notes'  ).Index].Width := 200;
  frm.DBGrid1.DataSource.DataSet.First;
end;

procedure TDTTEmployeesFormCreation.MemoText(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
var
  TextStyle : TTextStyle;

begin
  //eliminate hints
  Sender := Sender;
  DataCol:= DataCol;
  Column := Column;
  aState := aState;

  TextStyle := self.fForm.DBGrid1.Canvas.TextStyle;
  TextStyle.SingleLine  := False;
  TextStyle.Wordbreak   := True;
  self.fForm.DBGrid1.Canvas.TextStyle := TextStyle;
end;

procedure TDTTEmployeesFormCreation.Sort(Column: TColumn);
var
  s : string;
begin
  s := Column.Field.FieldName;
  Self.fForm.DBGrid1.Sort(s, 0, 1);
end;

constructor TDTTEmployeesFormCreation.Create(aToolbelt: IFaceToolbelt);
begin
  self.fToolbelt                              := aToolbelt;
  self.fForm                                  := TEmployeesFrm.Create(nil);
  self.fForm.OnShow                           := @LoadEmployees;
  self.fForm.DBGrid1.OnTitleClick             := @Sort;
  self.fForm.DBGrid1.OnPrepareCanvas          := @MemoText;
  self.fForm.DBGrid1.SetDefaultRowHeight(100);
  self.fForm.ShowModal;
end;

destructor TDTTEmployeesFormCreation.Destroy;
begin
  Self.fForm.Free;
  inherited Destroy;
end;

end.

