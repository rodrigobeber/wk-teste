program WKTeste;

uses
  Vcl.Forms,
  FPrincipal in 'FPrincipal.pas' {Form1},
  DConexao in 'DConexao.pas' {dmConexao: TDataModule},
  DClientes in 'DClientes.pas' {dmClientes: TDataModule},
  DProdutos in 'DProdutos.pas' {dmProdutos: TDataModule},
  DPedidos in 'DPedidos.pas' {dmPedidos: TDataModule},
  FPedidos in 'FPedidos.pas' {frPedidos},
  UUtilDatasets in 'UUtilDatasets.pas',
  UUtilDialogs in 'UUtilDialogs.pas',
  UUtilControls in 'UUtilControls.pas',
  DExecSQL in 'DExecSQL.pas' {dmExecSQL: TDataModule},
  USQLs in 'USQLs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmExecSQL, dmExecSQL);
  Application.CreateForm(TdmClientes, dmClientes);
  Application.CreateForm(TdmProdutos, dmProdutos);
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.Run;
end.
