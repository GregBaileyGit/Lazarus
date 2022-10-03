unit UToolbelt;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  msSqlConn,
  sqlDB,
  UFaceToolbelt;

type

  { TDTTToolbelt }

  TDTTToolbelt = class(TInterfacedObject, IFaceToolbelt)
  private
    fTrans        : TSQLTransaction;
    fConn         : TMsSqlConnection;
    fMsSqlQuery1  : TSQLQuery;
    fMsSqlQuery2  : TSQLQuery;
    fMsSQlQuery3  : TSQLQuery;
  protected
    function GetMsSqlConnection : TMsSqlConnection;
    function GetMsSqlQuery1     : TSQLQuery;
    function GetMsSqlQuery2     : TSQLQuery;
    function GetMsSQlQuery3     : TSQLQuery;
  public
    constructor Create(const aDatabaseName : string; aHostName : string = '127.0.0.1'; aPort : word = 1433);
    destructor Destroy; override;
  end;

implementation

function TDTTToolbelt.GetMsSqlConnection: TMsSqlConnection;
begin
  Result := fConn;
end;

function TDTTToolbelt.GetMsSqlQuery1: TSQLQuery;
begin
  Result := fMsSqlQuery1;
end;

function TDTTToolbelt.GetMsSqlQuery2: TSQLQuery;
begin
  Result := fMsSqlQuery2;
end;

function TDTTToolbelt.GetMsSQlQuery3: TSQLQuery;
begin
  Result := fMsSqlQuery2;
end;

constructor TDTTToolbelt.Create(const aDatabaseName: string; aHostName: string;
  aPort: word);
begin
  inherited Create;
  fTrans          := TSQLTransaction.Create(nil);
  fConn           := TMSSQLConnection.Create(nil);
  fMsSqlQuery1    := TSQLQuery.Create(nil);
  fMsSqlQuery2    := TSQLQuery.Create(nil);
  fMsSQlQuery3    := TSQLQuery.Create(nil);
  fConn.Connected := False;
  try
    fMsSqlQuery1.Transaction  := fTrans;
    fMsSqlQuery2.Transaction  := fTrans;
    fMsSqlQuery3.Transaction  := fTrans;

    fConn.DatabaseName        := aDatabaseName;
    fConn.HostName            := aHostName + ':' + aPort.ToString;
    fConn.Transaction         := fTrans;
    fConn.Connected           := True;
  except
    on e: Exception do
    begin
      fConn.DatabaseName  := 'Database connection exception: ' + e.Message;
      raise;
    end;
  end;
end;

destructor TDTTToolbelt.Destroy;
begin
  fTrans.Free;
  fConn.Free;
  fMsSqlQuery1.Free;
  fMsSqlQuery2.Free;
  fMsSQlQuery3.Free;
  inherited Destroy;
end;

end.

