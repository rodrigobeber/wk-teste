unit DProdutos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Variants;

type
  TdmProdutos = class(TDataModule)
    qryProdutos: TFDQuery;
    dsProdutos: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarProdutos;
    function ObterValorUnitario(CodigoProduto: Integer; out ValorUnitario: Currency): Boolean;
  end;

var
  dmProdutos: TdmProdutos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses DConexao;

procedure TdmProdutos.CarregarProdutos;
begin
    if not qryProdutos.Active then
        qryProdutos.Open;
end;

function TdmProdutos.ObterValorUnitario(CodigoProduto: Integer; out ValorUnitario: Currency): Boolean;
begin
    Result := qryProdutos.Locate('cd_produto', VarArrayOf([CodigoProduto]), []);
    if Result then
        ValorUnitario := qryProdutos.FieldByName('vl_preco_venda').AsCurrency;
end;


end.
