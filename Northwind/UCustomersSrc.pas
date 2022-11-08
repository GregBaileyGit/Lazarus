unit UCustomersSrc;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  UCustomersFrm,
  UFaceToolbelt
  ;

type
  TDTTCustomersFormCreation = class
    private
       fForm      : TCustomersFrm;
       fToolbelt  : IFaceToolbelt;
    protected
       procedure LoadCustomers(Sender : TObject);
    public
      constructor Create(aToolbelt : IFaceToolbelt);
      destructor Destroy; override;
  end;

implementation

uses
  Dialogs,
  db,
  sqlDB
  ;

procedure TDTTCustomersFormCreation.LoadCustomers(Sender : TObject);
var
  Qry : TSQLQuery;
  Frm : TCustomersFrm;
begin
  Qry                     := self.fToolbelt.GetMsSqlQuery1;
  Frm                     := self.fForm;;
  Frm.DataSource1.DataSet := Qry;
  Frm.DBGrid1.DataSource  := self.fForm.DataSource1;

  Qry.Clear;
  Qry.Sql.Text := ''                                                        +
    'select '                                                               +
    '  CustomerID as ID, '                                                  +
    '  CompanyName as Company, '                                            +
    '  ContactName as [Full Name], '                                        +
    '  ParseName(Replace(ContactName, '' '', ''.''), 2) as [First Name], '  +
    '  ParseName(Replace(ContactName, '' '', ''.''), 1) as [Last Name],  '  +
    '  ContactTitle as Title, '                                             +
    '  Address, '                                                           +
    '  City, '                                                              +
    '  Region, '                                                            +
    '  PostalCode as Zipcode, '                                             +
    '  Country, '                                                           +
    '  Phone, '                                                             +
    '  Fax '                                                                +
    'from Customers '                                                       +
    'order by '                                                             +
    '  [Last Name], '                                                       +
    '  [First Name] '                                                       +
    ''
  ;
  Qry.Active := True;

  //Note frm.DataSource1.DataSet is nil after this procedure exits
  //why is currently unknown, due to this the code is done in this procedure
  //we would need to have a method to update the record count as needed
  frm.DataSource1.DataSet.Last;
  frm.StatusBar1.Panels[1].Text := FormatFloat(',#', frm.DataSource1.DataSet.RecordCount);
  frm.DataSource1.DataSet.First;
end;

constructor TDTTCustomersFormCreation.Create(aToolbelt : IFaceToolbelt);
begin
  inherited Create;
  self.fToolbelt      := aToolbelt;
  self.fForm          := TCustomersFrm.Create(nil);
  self.fForm.OnShow   := @LoadCustomers;
//Self.fForm.StatusBar1.Panels[1].Text := self.GetRecordCount.ToString;
  self.fForm.ShowModal;
end;

destructor TDTTCustomersFormCreation.Destroy;
begin
  Self.fForm.Free;
  inherited Destroy;
end;

end.

