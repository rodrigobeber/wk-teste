unit DPedidos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Variants, Dialogs;

type
  TdmPedidos = class(TDataModule)
    qryPedido: TFDQuery;
    dsPedido: TDataSource;
    qryPedidoProdutos: TFDQuery;
    qryPedidonr_pedido: TFDAutoIncField;
    qryPedidocd_cliente: TIntegerField;
    qryPedidovl_total: TBCDField;
    qryPedidoProdutosid: TFDAutoIncField;
    qryPedidoProdutosnr_pedido: TIntegerField;
    qryPedidoProdutoscd_produto: TIntegerField;
    qryPedidoProdutosnr_quantidade: TIntegerField;
    qryPedidoProdutosvl_unitario: TBCDField;
    qryPedidoProdutosvl_total: TBCDField;
    dsPedidoProdutos: TDataSource;
    qryPedidods_cliente_nome: TStringField;
    qryPedidods_cliente_cidade: TStringField;
    qryPedidodt_emissao: TDateTimeField;
    qryPedidocd_cliente_uf: TStringField;
    qryPedidoProdutosds_produto_descricao: TStringField;
    fdSchemaAdapter: TFDSchemaAdapter;
    memtProduto: TFDMemTable;
    memtProdutocd_produto: TIntegerField;
    memtProdutods_produto: TStringField;
    memtProdutovl_unitario: TCurrencyField;
    memtProdutonr_quantidade: TIntegerField;
    memtProdutovl_total: TCurrencyField;
    dsProduto: TDataSource;
    memtProdutoeh_novo: TBooleanField;
    fdTransaction: TFDTransaction;
    procedure qryPedidonr_pedidoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure memtProdutoNewRecord(DataSet: TDataSet);
    procedure memtProdutocd_produtoValidate(Sender: TField);
    procedure memtProdutonr_quantidadeValidate(Sender: TField);
    procedure qryPedidoNewRecord(DataSet: TDataSet);
    procedure memtProdutods_produtoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    FIdsExcluidos: String;
    function GetCodigoCliente: Integer;
    procedure AtualizarValorTotalPedido;
    function InserirPedido: Integer;
    procedure AtualizarPedido;
  public
    { Public declarations }
    property CodigoCliente: Integer read GetCodigoCliente;

    // Pedido
    function AbrirNovoPedido(ACodigoCliente: Integer): Boolean;
    function GravarPedido: string;
    function GravarPedido2: string; // não utilizado, está aqui apenas como exemplo
    function CarregarPedido(ANumeroPedido: Integer): Boolean;
    function ExcluirPedido(ANumeroPedido: Integer): String;

    // Produto
    procedure ConfirmarProduto;
    procedure EditarProduto;
    procedure CancelarProduto;
    procedure ExcluirProduto;

    // Outros
    function TemAlteracoesPendentes: Boolean;
    procedure LimparDataSets;
  end;

var
  dmPedidos: TdmPedidos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses DConexao, DClientes, DProdutos, UUtilDatasets, USQLs, DExecSQL;

const
    CamposProduto: array[0..3] of string = ('cd_produto', 'nr_quantidade', 'vl_unitario', 'vl_total');

    // Para os SQLs
    CamposInsertPedido: array[0..2] of string = ('dt_emissao', 'cd_cliente', 'vl_total');
    CamposUpdatePedido: array[0..1] of string = ('nr_pedido', 'vl_total');
    CamposInsertProduto: array[0..4] of string = ('nr_pedido', 'cd_produto', 'nr_quantidade', 'vl_unitario', 'vl_total');
    CamposUpdateProduto: array[0..4] of string = ('nr_pedido', 'cd_produto', 'nr_quantidade', 'vl_unitario', 'vl_total');

// --------------------------------------------------------------
// Eventos do Data Módule
procedure TdmPedidos.DataModuleCreate(Sender: TObject);
begin
    memtProduto.CreateDataSet;
end;

// --------------------------------------------------------------
// Eventos do Dataset de Pedido
procedure TdmPedidos.qryPedidoNewRecord(DataSet: TDataSet);
begin
    qryPedidodt_emissao.Value := dmConexao.DataHora;
    qryPedidovl_total.Value := 0;
end;

procedure TdmPedidos.qryPedidonr_pedidoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
    // ajustes na exibição do campo Número do Pedido
    if DisplayText then
    begin
        if Sender.AsInteger > 0 then
            Text := Sender.AsString
        else
            Text := 'Novo'
   end;
end;

function TdmPedidos.TemAlteracoesPendentes: Boolean;
begin
    Result := qryPedidoProdutos.ChangeCount > 0;
end;

// --------------------------------------------------------------
// Eventos do Dataset de Produto (Dataset temporário memtProduto)
procedure TdmPedidos.memtProdutocd_produtoValidate(Sender: TField);
var
    ValorUnitario: Currency;
begin
    if not Sender.IsNull then
    begin
      if dmProdutos.ObterValorUnitario(Sender.AsInteger, ValorUnitario) then
          memtProdutovl_unitario.Value := ValorUnitario
      else
          raise Exception.Create('Código de produto não encontrado. Por favor, insira um valor válido.');
    end;
end;

procedure TdmPedidos.memtProdutods_produtoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
    if DisplayText then
    begin
        Text := Sender.AsString
    end;
end;

procedure TdmPedidos.memtProdutoNewRecord(DataSet: TDataSet);
begin
    memtProdutoeh_novo.Value := True;
    memtProdutonr_quantidade.Value := 1;
end;

procedure TdmPedidos.memtProdutonr_quantidadeValidate(Sender: TField);
begin
    memtProdutovl_total.AsCurrency := memtProdutovl_unitario.Value * memtProdutonr_quantidade.Value;
end;

// --------------------------------------------------------------
// Métodos de Pedido

// método não utilizado, pois conforme recomendação,
// estou utilizando SQLs para gravar, no método GravaPedido
function TdmPedidos.GravarPedido2: string;
begin
    if qryPedidoProdutos.RecordCount = 0 then
        Result := 'Pedido deve ter pelo menos um produto'
    else
    if fdSchemaAdapter.ApplyUpdates(-1) = 0 then
        Result := ''
    else
        Result := 'Erro ao salvar o pedido';
end;

function TdmPedidos.GravarPedido: string;
var
   NumeroPedido: Integer;
begin
    NumeroPedido := 0; // somente eliminação de warning do compilador

    if qryPedidoProdutos.RecordCount = 0 then
    begin
        Result := 'Pedido deve ter pelo menos um produto';
        Exit;
    end;

    try
        fdTransaction.StartTransaction;
        if qryPedidonr_pedido.AsInteger < 1 then
            NumeroPedido := InserirPedido
        else
        begin
             AtualizarPedido;
             NumeroPedido := qryPedidonr_pedido.AsInteger;
        end;
        fdTransaction.Commit;
        Result := '';
    except
        on E: Exception do
        begin
            fdTransaction.Rollback;
            Result := 'Erro ao salvar o pedido: ' + E.Message;
        end;
    end;

    // como as execuções de insert/update/delete são todas manuais,
    // recarrega o pedido todo do banco de dados
    CarregarPedido(NumeroPedido);
end;

function TdmPedidos.InserirPedido: Integer;
var
    NumeroPedido: Integer;
begin
    dmExecSQL.ExecSQL(SQLInsertPedido, qryPedido, camposInsertPedido);
    NumeroPedido := dmConexao.fdConexao.GetLastAutoGenValue('nr_pedido');

    // Inserir os produtos do pedido
    with qryPedidoProdutos do
    try
        DisableControls;
        First;
        while not Eof do
        begin
            dmExecSQL.ExecSQL(SQLInsertPedidoProduto,
               [NumeroPedido, FieldByName('cd_produto').Value, FieldByName('nr_quantidade').Value,
                 FieldByName('vl_unitario').Value,  FieldByName('vl_total').Value]);
            Next;
        end;
    finally
        EnableControls;
    end;

    Result := NumeroPedido;
end;

function TdmPedidos.AbrirNovoPedido(ACodigoCliente: Integer): Boolean;
begin
    Result := False;
    if not dmClientes.qryClientes.Locate('cd_cliente', VarArrayOf([ACodigoCliente]), []) then
        Exit;
    LimparDataSets;
    with qryPedido do
    begin
        Params[0].AsInteger := 0;
        Open;
        Insert;
        qryPedidocd_cliente.Value := ACodigoCliente;
        Post;
    end;
    qryPedidoProdutos.Params[0].AsInteger := 0;
    qryPedidoProdutos.Open;
    Result := True;
end;

procedure TdmPedidos.AtualizarPedido;
begin
    dmExecSQL.ExecSQL(SQLUpdatePedido, qryPedido, camposUpdatePedido);
    if FIdsExcluidos <> '' then
        dmExecSQL.ExecSQL(Format(SQLDeletePedidoProdutosIn, [FIdsExcluidos]));
    with qryPedidoProdutos do
    try
        DisableControls;
        First;
        while not EOF do
        begin
            if FieldByName('id').AsInteger > 0 then
                dmExecSQL.ExecSQL(SQLUpdatePedidoProduto, [
                   FieldByName('nr_quantidade').Value,
                   FieldByName('vl_unitario').value,
                   FieldByName('vl_total').value,
                   FieldByName('id').AsInteger
                ])
            else
                dmExecSQL.ExecSQL(SQLInsertPedidoProduto, qryPedidoProdutos, camposInsertProduto);
            Next;
        end;
    finally
        EnableControls;
    end;
end;

function TdmPedidos.CarregarPedido(ANumeroPedido: Integer): Boolean;
begin
    LimparDataSets;
    with qryPedido do
    begin
        Params[0].AsInteger := ANumeroPedido;
        Open;
        Result := not IsEmpty;
        if Result then
            qryPedidoProdutos.Open;
    end;
end;

function TdmPedidos.ExcluirPedido(ANumeroPedido: Integer): String;
begin
    try
        fdTransaction.StartTransaction;
        dmExecSQL.ExecSQL(SQLDeletePedidoProdutos, [ANumeroPedido]);
        dmExecSQL.ExecSQL(SQLDeletePedido, [ANumeroPedido]);
        fdTransaction.Commit;
    except
        on E: Exception do
        begin
            fdTransaction.Rollback;
            Result := E.Message;
        end;
    end;
    LimparDataSets;
end;

// --------------------------------------------------------------
// Métodos de Produto
procedure TdmPedidos.CancelarProduto;
begin
    memtProduto.EmptyDataSet;
end;

procedure TdmPedidos.EditarProduto;
begin
    memtProduto.EmptyDataSet;
    memtProduto.Insert;
    UUtilDataSets.CopiarCampos(qryPedidoProdutos, memtProduto, CamposProduto);
    memtProdutoEh_Novo.Value := False;
end;

procedure TdmPedidos.ConfirmarProduto;
begin
    UUtilDataSets.VerificarCampos(memtProduto, CamposProduto);
    if memtProdutoeh_novo.Value then
        qryPedidoProdutos.Insert
    else
        qryPedidoProdutos.Edit;
    UUtilDataSets.CopiarCampos(memtProduto,  qryPedidoProdutos, CamposProduto);
    qryPedidoProdutos.Post;
    memtProduto.EmptyDataSet;
    AtualizarValorTotalPedido;
end;

procedure TdmPedidos.ExcluirProduto;
begin
    // gerenciamento manual de itens a serem excluídos
    if qryPedidoProdutosId.AsInteger > 0 then
    begin
        if FIdsExcluidos <> '' then
            FIdsExcluidos := FIdsExcluidos + ',';
        FIdsExcluidos := FIdsExcluidos + qryPedidoProdutosId.AsString;
    end;
    qryPedidoProdutos.Delete;
    AtualizarValorTotalPedido;
end;

procedure TdmPedidos.AtualizarValorTotalPedido;
begin
    qryPedido.Edit;
    qryPedidovl_total.Value := UUtilDataSets.SomarColuna(qryPedidoProdutos, 'vl_total');
    qryPedido.Post;
end;

// --------------------------------------------------------------
// Outros métodos
procedure TdmPedidos.LimparDataSets;
begin
    qryPedido.Close;
    qryPedidoProdutos.Close;
    memtProduto.EmptyDataSet;
    FIdsExcluidos := '';
end;

function TdmPedidos.GetCodigoCliente: Integer;
begin
    Result := qryPedidocd_cliente.Value;
end;


end.
