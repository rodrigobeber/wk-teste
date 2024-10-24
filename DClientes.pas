unit DClientes;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet;

type
  TdmClientes = class(TDataModule)
    qryClientes: TFDQuery;
    dsClientes: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarClientes;
  end;

var
  dmClientes: TdmClientes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses DConexao;

procedure TdmClientes.CarregarClientes;
begin
    if not qryClientes.Active then
        qryClientes.Open;
end;

end.
