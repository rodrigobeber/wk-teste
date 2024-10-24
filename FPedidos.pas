unit FPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TPedidoEstado = (estVazio, estIncluindo, estAlterando, estBrowse);

  TfrPedidos = class(TForm)
    pnPedido: TPanel;
    pnPedidoTopo: TPanel;
    pnPedidoRodape: TPanel;
    pnPedidoProdutos: TPanel;
    pnDadosProduto: TPanel;
    pnGridProdutos: TPanel;
    dbedTotalPedido: TDBLabeledEdit;
    pnPedidoToolbar: TPanel;
    btGravarPedido: TBitBtn;
    btCancelarPedido: TBitBtn;
    pnDadosPedido: TPanel;
    dbedDataEmissao: TDBLabeledEdit;
    dbedNumeroPedido: TDBLabeledEdit;
    dbgrdProdutos: TDBGrid;
    dbedNomeCliente: TDBEdit;
    btAbrirPedido: TBitBtn;
    dbedCidadeCliente: TDBLabeledEdit;
    dbedUfCliente: TDBEdit;
    dbedCodigoProduto: TDBLabeledEdit;
    dbedDescricaoProduto: TDBEdit;
    dbedQuantidadeProduto: TDBLabeledEdit;
    dbedValorUnitarioProduto: TDBLabeledEdit;
    dbedValorTotalProduto: TDBLabeledEdit;
    btConfirmarProduto: TBitBtn;
    btCancelarProduto: TBitBtn;
    edCodigoCliente: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btGravarPedidoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btConfirmarProdutoClick(Sender: TObject);
    procedure dbgrdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrdProdutosEnter(Sender: TObject);
    procedure btAbrirPedidoClick(Sender: TObject);
    procedure btCancelarPedidoClick(Sender: TObject);
    procedure btCancelarProdutoClick(Sender: TObject);
    procedure edCodigoClienteExit(Sender: TObject);
  private
    { Private declarations }
    FEstado: TPedidoEstado;
    function LerNumeroPedido(ATitulo: String): Integer;
    procedure SetEstado(const AValue: TPedidoEstado);
    procedure VerificarPerderAlteracoes;
  public
    { Public declarations }
    property Estado: TPedidoEstado read FEstado write SetEstado;
  end;

var
  frPedidos: TfrPedidos;

implementation

{$R *.dfm}

uses DPedidos, UUtilDialogs, UUtilControls;

procedure TfrPedidos.btAbrirPedidoClick(Sender: TObject);
var
    NumeroPedido: Integer;
begin
    NumeroPedido := LerNumeroPedido('Consultar pedido');
    if NumeroPedido < 1 then Exit;
    if not dmPedidos.CarregarPedido(NumeroPedido) then
        UUtilDialogs.ExibirErro('Pedido não encontrado com o código ' + IntToStr(NumeroPedido))
    else
    begin
        Estado := estBrowse;
        edCodigoCliente.Text := IntToStr(dmPedidos.CodigoCliente);
    end;
end;

procedure TfrPedidos.btCancelarPedidoClick(Sender: TObject);
var
    NumeroPedido: Integer;
    MensagemErro: String;
begin
    NumeroPedido := LerNumeroPedido('Excluir pedido');
    if NumeroPedido < 1 then Exit;
    if not dmPedidos.CarregarPedido(NumeroPedido) then
        UUtilDialogs.ExibirErro('Pedido não encontrado com o código ' + IntToStr(NumeroPedido))
    else
    begin
        edCodigoCliente.Text := IntToStr(dmPedidos.CodigoCliente);
        if UUtilDialogs.Confirmar('Tem certeza que deseja excluir o pedido ' + IntToStr(NumeroPedido)) then
        begin
            MensagemErro := dmPedidos.ExcluirPedido(NumeroPedido);
            if MensagemErro <> '' then
                UUtilDialogs.ExibirErro('Erro excluindo pedido: ' + MensagemErro)
            else
                UUtilDialogs.ExibirInfo(Format('Pedido %d excluído com sucesso', [NumeroPedido]));
        end
        else
            UUtilDialogs.ExibirInfo('Operação cancelada. O pedido NÃO foi excluído');
        dmPedidos.LimparDataSets;
        Estado := estVazio;
    end;
end;

procedure TfrPedidos.btCancelarProdutoClick(Sender: TObject);
begin
   dmPedidos.CancelarProduto;
   btCancelarProduto.Enabled := False;
   dbedCodigoProduto.Enabled := True;
   dbedCodigoProduto.SetFocus;
end;

function TfrPedidos.LerNumeroPedido(ATitulo: String): Integer;
begin
    Result := UUtilDialogs.LerInteiroPositivo(ATitulo);
end;

procedure TfrPedidos.btConfirmarProdutoClick(Sender: TObject);
begin
    try
        dmPedidos.ConfirmarProduto;
    except
        on E: Exception do
        begin
            UUtilControls.FocarPrimeiroCampoVazio([dbedCodigoProduto, dbedQuantidadeProduto, dbedValorUnitarioProduto]);
            raise Exception.Create(E.Message);
        end;
    end;
    dbedCodigoProduto.Enabled := True;
    dbedCodigoProduto.SetFocus;
    btCancelarProduto.Enabled := False;
    if Estado = estBrowse then
       Estado := estAlterando;
end;

procedure TfrPedidos.btGravarPedidoClick(Sender: TObject);
var
    MensagemErro: String;
begin
    MensagemErro := dmPedidos.GravarPedido;
    if MensagemErro <> '' then
        UUtilDialogs.ExibirErro(MensagemErro)
    else
        Estado := estBrowse;
end;

procedure TfrPedidos.dbgrdProdutosEnter(Sender: TObject);
begin
    dmPedidos.CancelarProduto;
end;

procedure TfrPedidos.dbgrdProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key = VK_RETURN then
    begin
        dmPedidos.EditarProduto;
        dbedQuantidadeProduto.SetFocus;
        dbedQuantidadeProduto.SelectAll;
        dbedCodigoProduto.Enabled := False;
        btCancelarProduto.Enabled := True;
    end else
    if Key = VK_DELETE then
    begin
        if UUtilDialogs.Confirmar('Tem certeza que deseja excluir o produto') then
        begin
            dmPedidos.ExcluirProduto;
            if Estado = estBrowse then
               Estado := estAlterando;
        end;
    end;
end;

procedure TfrPedidos.edCodigoClienteExit(Sender: TObject);
var
    CodigoCliente: Integer;
begin
    if edCodigoCliente.Text = '' then
    begin
        if Estado <> estVazio then
        begin
            VerificarPerderAlteracoes;
            dmPedidos.LimparDataSets;
            Estado := estVazio;
        end;
        Exit;
    end;
    CodigoCliente := StrToIntDef(edCodigoCliente.Text, 0);
    if CodigoCliente < 1 then
    begin
        UUtilDialogs.ExibirErro('Código de cliente deve ser um número inteiro positivo');
        edCodigoCliente.SetFocus;
        edCodigoCliente.SelectAll;
    end
    else
    if CodigoCliente <> dmPedidos.CodigoCliente then
    begin
        VerificarPerderAlteracoes;
        if not dmPedidos.AbrirNovoPedido(CodigoCliente) then
        begin
            UUtilDialogs.ExibirErro('Código de cliente não encontrado');
            edCodigoCliente.SetFocus;
            edCodigoCliente.SelectAll;
        end else
            Estado := estIncluindo;
    end;
end;

procedure TfrPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure TfrPedidos.FormDestroy(Sender: TObject);
begin
    frPedidos := nil;
    FreeAndNil(dmPedidos);
end;

procedure TfrPedidos.VerificarPerderAlteracoes;
begin
    if dmPedidos.TemAlteracoesPendentes
    and (not UUtilDialogs.Confirmar('As alterações pendentes serão PERDIDAS. Tem certeza que deseja continuar?')) then
    begin
        if edCodigoCliente.Text = '' then
            edCodigoCliente.Text := IntToStr(dmPedidos.CodigoCliente);
        Abort;
    end;
end;

procedure TfrPedidos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    inherited;
    // ENTER funcionando como TAB, exceto para a Grid
    if (Key = VK_RETURN) and (Sender <> dbgrdProdutos) then
        ActiveControl := FindNextControl (ActiveControl, True, True, False)
    else
    if Key = VK_ESCAPE then
        if Estado = estVazio then
            Close
        else
        begin
            VerificarPerderAlteracoes;
            dmPedidos.LimparDataSets;
            Estado := estVazio;
        end;
end;

// auto-dimensiona a coluna para que a coluna com a descrição do produto seja auto-dimensionável
procedure TfrPedidos.FormResize(Sender: TObject);
var
    IndiceColunaDescricao: Integer;
    TotalLarguraFixa: Integer;
    LarguraColunaDescricao: Integer;
begin
    IndiceColunaDescricao := 1;

    TotalLarguraFixa := 0;
    for var i := 0 to dbgrdProdutos.Columns.Count - 1 do
    begin
        if dbgrdProdutos.Columns[i].FieldName <> 'ds_produto_descricao' then
            TotalLarguraFixa := TotalLarguraFixa + dbgrdProdutos.Columns[i].Width;
    end;

    LarguraColunaDescricao := dbgrdProdutos.Width - TotalLarguraFixa - 50; // Ajuste para bordas e margens
    if LarguraColunaDescricao > 0 then
        dbgrdProdutos.Columns[IndiceColunaDescricao].Width := LarguraColunaDescricao;
end;

procedure TfrPedidos.FormShow(Sender: TObject);
begin
    FormResize(Sender); // dispara auto-redimensionamento da coluna Descrição da Grid
    Estado := estVazio;
end;

procedure TfrPedidos.SetEstado(const AValue: TPedidoEstado);
begin
    FEstado := AValue;
    btAbrirPedido.Enabled := FEstado = estVazio;
    btCancelarPedido.Enabled := FEstado = estVazio;
    btGravarPedido.Enabled := FEstado in [estIncluindo, estAlterando];

    // Para o código do produto usa readonly ao invés de enabled por causa do foco
    // automático que vem pora este campo ao teclar Enter no campo Código do Cliente
    dbedCodigoProduto.ReadOnly := FEstado = estVazio;

    dbedQuantidadeProduto.Enabled :=  FEstado <> estVazio;
    dbedValorUnitarioProduto.Enabled := FEstado <> estVazio;
    pnGridProdutos.Enabled := FEstado <> estVazio;
    dbedCodigoProduto.Enabled := True;
    btConfirmarProduto.Enabled := True;
    btCancelarProduto.Enabled := False;

    if FEstado = estBrowse then
       dbedCodigoProduto.SetFocus
    else
    if FEstado = estVazio then
    begin
        edCodigoCliente.Text := '';
        edCodigoCliente.SetFocus;
    end;
end;

end.
