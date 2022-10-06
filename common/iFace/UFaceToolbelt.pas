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
    ['{FB2738FD-6E05-402F-95BD-FDD2BA6B6722}']
    function GetMsSqlConnection : TMsSqlConnection;
    function GetMsSqlQuery1     : TSQLQuery;
    function GetMsSqlQuery2     : TSQLQuery;
    function GetMsSQlQuery3     : TSQLQuery;
  end;

implementation

end.

