unit UUtilDialogs;

interface

uses Vcl.Dialogs, Vcl.Controls, System.SysUtils;

function LerInteiroPositivo(Titulo: string): Integer;
procedure ExibirErro(Mensagem: String);
procedure ExibirInfo(Mensagem: String);
function Confirmar(Mensagem: string): Boolean;

implementation

procedure ExibirErro(Mensagem: String);
begin
    MessageDlg(Mensagem, mtError, [mbOk], 0);
end;

procedure ExibirInfo(Mensagem: String);
begin
    MessageDlg(Mensagem, mtInformation, [mbOk], 0);
end;


function Confirmar(Mensagem: string): Boolean;
begin
    Result := MessageDlg(Mensagem, mtConfirmation, [mbYes, mbCancel], 0) = mrYes;
end;

function LerInteiroPositivo(Titulo: string): Integer;
var
    sNumero: string;
begin
    sNumero := InputBox(Titulo, 'Digite o número', '');
    Result := StrToIntDef(sNumero, 0);
end;


end.
