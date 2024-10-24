unit DConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, System.IniFiles, Dialogs, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    fdConexao: TFDConnection;
    fdMySQLDriver: TFDPhysMySQLDriverLink;
    fdWaitCursor: TFDGUIxWaitCursor;
    qryDataHoraServidor: TFDQuery;
  private
    { Private declarations }
    function GetDataHora: TDateTime;
  public
    { Public declarations }
    property DataHora: TDateTime read GetDataHora;
    function Conectar(AMensagemErro: String): Boolean;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

const nomeArquivoIni = 'WKTeste.ini';

function TdmConexao.Conectar(AMensagemErro: String): Boolean;
var
    IniFile: TMemIniFile;
    CaminhoArquivoIni: String;
begin

    Result := False;

    CaminhoArquivoIni := ExtractFilePath(ParamStr(0)) + nomeArquivoIni;

    if not FileExists(CaminhoArquivoIni) then
    begin
        AMensagemErro := Format('Arquivo de configuração "%s" não encontrado.', [CaminhoArquivoIni]);
        Exit;
    end;

    IniFile := TMemIniFile.Create(CaminhoArquivoIni);

    try
        with fdConexao, IniFile do
        begin
            Params.Values['Database'] := ReadString('Database', 'Database', '');
            Params.Values['User_Name'] := ReadString('Database', 'Username', '');
            Params.Values['Server'] := ReadString('Database', 'Server', '');
            Params.Values['Port'] := ReadString('Database', 'Port', '');
            Params.Values['Password'] := ReadString('Database', 'Password', '');
            Params.Values['DriverID'] := 'MySQL';
            Params.Values['LibraryLocation'] := ReadString('Database', 'LibraryPath', '');
            Connected := True;
            Result := Connected;
            if not Result then
                AMensagemErro := 'Erro desconhecido em conectar ao banco de dados';
        end;
    except
        on E: Exception do
        begin
            AMensagemErro := 'Erro em conectar ao banco de dados: ' + E.Message;
        end;
    end;

    IniFile.Free;
end;

function TdmConexao.GetDataHora: TDateTime;
begin
    with qryDataHoraServidor do
    begin
        Open;
        Result := Fields[0].AsDateTime;
        Close;
    end;
end;

end.
