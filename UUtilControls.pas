unit UUtilControls;

interface

uses Controls,Vcl.StdCtrls;

procedure FocarPrimeiroCampoVazio(const AEdits: array of TCustomEdit);

implementation

procedure FocarPrimeiroCampoVazio(const AEdits: array of TCustomEdit);
var
    i: Integer;
    Edit: TCustomEdit;
begin
    for i := Low(AEdits) to High(AEdits) do
    begin
        Edit := AEdits[i];
        if Edit.Text = '' then
        begin
            Edit.SetFocus;
            Break;
        end;
    end;
end;


end.
