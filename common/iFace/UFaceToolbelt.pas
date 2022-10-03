unit UFaceToolbelt;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  msSqlConn,
  sqlDB
  ;

type
  IFaceToolbelt = interface(IInvokable)
    function GetMsSqlConnection : TMsSqlConnection;
    function GetMsSqlQuery1     : TSQLQuery;
    function GetMsSqlQuery2     : TSQLQuery;
    function GetMsSQlQuery3     : TSQLQuery;
  end;

implementation

end.

