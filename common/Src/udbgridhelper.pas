unit UDBGridHelper;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  db, DBGrids, Grids
  ;

type

  { TDBGridHelper }

  TDBGridHelper = class helper for TDBGrid
  public const
    cMaxColCOunt = 3;
  private
  protected
    function Internal_IndexNameExists(IndexDefs: TIndexDefs; IndexName: String): Boolean;

    procedure Internal_MakeNames(Fields: TStrings; out FieldsList, DescFields: String);
    procedure Internal_SetColumnsIcons(Fields: TStrings; AscIdx, DescIdx: Integer);
  public
    procedure SetDefaultRowHeight(const Size : Integer);
    procedure Sort(const FieldName: String; AscIdx: Integer = -1; DescIdx: Integer = -1);
  end;

implementation

uses
  BufDataset,
  Controls,
  dialogs
  ;

procedure TDBGridHelper.Internal_MakeNames(Fields: TStrings; out FieldsList, DescFields: String);
var
  FldList: TStringList;
  DscList: TStringList;
  FldDesc, FldName: String;
  i: Integer;
begin
  if Fields.Count = 0 then
  begin
    FieldsList := '';
    DescFields := '';
    Exit;
  end;

  FldList := TStringList.Create;
  DscList := TStringList.Create;
  try
    FldList.Delimiter := ';';
    DscList.Delimiter := ';';

    for i := 0 to Fields.Count - 1 do
    begin
      Fields.GetNameValue(i, FldName, FldDesc);
      FldList.Add(FldName);

      if FldDesc = 'D' then
         DscList.Add(FldName);
    end;

    FieldsList := FldList.DelimitedText;
    DescFields := DscList.DelimitedText;
  finally
    FldList.Free;
    DscList.Free;
  end;
end;

procedure TDBGridHelper.Internal_SetColumnsIcons(Fields: TStrings; AscIdx, DescIdx: Integer);
var
  i: Integer;
  FldDesc: String;
begin
  for i := 0 to Self.Columns.Count - 1 do
  begin
    FldDesc := Fields.Values[Self.Columns[i].Field.FieldName];

    if FldDesc = 'A' then
      Self.Columns[i].Title.ImageIndex := AscIdx
    else
    if FldDesc = 'D' then
       Self.Columns[i].Title.ImageIndex := DescIdx
    else
       Self.Columns[i].Title.ImageIndex := -1
  end;
end;

function TDBGridHelper.Internal_IndexNameExists(IndexDefs: TIndexDefs; IndexName: String): Boolean;
var
  i: Integer;
begin
  for i := 0 to IndexDefs.Count - 1 do
  begin
    if IndexDefs[i].Name = IndexName then
      Exit(True)
  end;

  Result := False;
end;

procedure TDBGridHelper.SetDefaultRowHeight(const Size: Integer);
begin
  Self.DefaultRowHeight := Size;
end;

procedure TDBGridHelper.Sort(const FieldName: String; AscIdx: Integer; DescIdx: Integer);
var
 Field: TField;
  DataSet: TBufDataset;
  IndexDefs: TIndexDefs;
  IndexName, Dir, DescFields, FieldsList: String;
  Fields: TStringList;
begin
  if (not Assigned(DataSource.DataSet)) or
     (not DataSource.DataSet.Active) or
     (not (DataSource.DataSet is TBufDataset))
  then
    Exit;

  DataSet := DataSource.DataSet as TBufDataset;

  Field := DataSet.FieldByName(FieldName);
  if (Field is TBlobField) or (Field is TVariantField) or (Field is TBinaryField) then
    Exit;

  IndexDefs := DataSet.IndexDefs;
  IndexName := DataSet.IndexName;

  if not IndexDefs.Updated then
    IndexDefs.Update;

  Fields := TStringList.Create;
  try
    Fields.DelimitedText := IndexName;
    Dir := Fields.Values[FieldName];

    if Dir = 'A' then
      Dir := 'D'
    else
    if Dir = 'D' then
      Dir := 'A'
    else
      Dir := 'A';

    //If shift is presed then add field to field list
    if ssShift in GetKeyShiftState then
    begin
      Fields.Values[FieldName] := Dir;
      //We do not add to sor any more field if total field count exids cMaxColCOunt
      if Fields.Count > cMaxColCOunt then
        Exit;
    end
    else
    begin
      Fields.Clear;
      Fields.Values[FieldName] := Dir;
    end;

     IndexName := Fields.DelimitedText;
     if not Internal_IndexNameExists(IndexDefs, IndexName) then
     begin
       Internal_MakeNames(Fields, FieldsList, DescFields);
       TBufDataset(DataSet).AddIndex(IndexName, FieldsList, [], DescFields, '');
     end;

     DataSet.IndexName := IndexName;
     Internal_SetColumnsIcons(Fields, AscIdx, DescIdx)
   finally
     Fields.Free;
   end;

  self.DataSource.DataSet.First;
end;

end.

