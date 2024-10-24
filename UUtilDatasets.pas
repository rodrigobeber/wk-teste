unit UUtilDatasets;

interface

uses DB, SysUtils;

function SomarColuna(ADataSet: TDataSet; ANomeCampo: String): Currency;
procedure CopiarCampos(AOrigem, ADestino: TDataSet; ACampos: array of string);
procedure VerificarCampos(ADataSet: TDataSet; ACampos: array of string);

implementation

function DSValid(ADataSet: TDataSet): Boolean;
begin
    Result := Assigned(ADataSet)
              and ADataSet.Active
              and (not ADataSet.IsEmpty);
end;

procedure EnableControlsCascade (ADataset: TDataSet);
var
    i: Integer;
begin
    with ADataSet do
    begin
        for i := 0 to FieldCount-1 do
            if Fields[i] is TDataSetField then
                EnableControlsCascade(TDataSetField(Fields[i]).NestedDataSet);
        EnableControls;
    end;
end;

procedure DisableControlsCascade (ADataset: TDataSet);
var
    i: Integer;
begin
    with ADataSet do
    begin
        for i := 0 to FieldCount-1 do
            if Fields[i] is TDataSetField then
                DisableControlsCascade(TDataSetField(Fields[i]).NestedDataSet);
        DisableControls;
    end;
end;


procedure DSLoopPrepare(ADataSet: TDataSet; out ABookmark: TBookmark);
begin
    if not DSValid(ADataSet) then Exit;
    ABookmark := ADataSet.GetBookmark;
    DisableControlsCascade(ADataSet);
    ADataSet.First;
end;

procedure DSLoopEnd(ADataSet: TDataSet; ABookmark: TBookmark);
begin
    if not DSValid(ADataSet) then Exit;
    if Assigned(ABookmark) and ADataSet.BookmarkValid(ABookmark) then
        ADataSet.GotoBookmark(ABookmark)
    else
        ADataSet.First;
    EnableControlsCascade(ADataSet);
end;

function SomarColuna(ADataSet: TDataSet; ANomeCampo: String): Currency;
var
    Bookmark: TBookmark;
    Field: TField;
begin
    Result := 0;
    if not DSValid(ADataSet) then Exit;
    DSLoopPrepare(ADataSet, Bookmark);
    Field := ADataSet.FieldByName(ANomeCampo);
    try
        with ADataSet do
        begin
            First;
            while not EOF do
            begin
                Result := Result + Field.AsCurrency;
                Next;
            end;
            First;
        end;
    finally
        DSLoopEnd(ADataSet, Bookmark);
    end;
end;

procedure CopiarCampos(AOrigem, ADestino: TDataSet; ACampos: array of string);
var
   i: Integer;
begin
    for i := Low(ACampos) to High(ACampos) do
    begin
        if AOrigem.FieldByName(ACampos[i]).IsNull then
            ADestino.FieldByName(ACampos[i]).Clear
        else
            ADestino.FieldByName(ACampos[i]).Value := AOrigem.FieldByName(ACampos[i]).Value;
    end;
end;

procedure VerificarCampos(ADataSet: TDataSet; ACampos: array of string);
var
    i: Integer;
begin
    for i := Low(ACampos) to High(ACampos) do
        if ADataSet.FieldByName(ACampos[i]).IsNull then
            raise Exception.Create('Campo ' +  ADataSet.FieldByName(ACampos[i]).DisplayLabel + ' não preenchido');
end;

end.
