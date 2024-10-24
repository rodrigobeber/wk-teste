unit FPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrPrincipal = class(TForm)
    mmPrincipal: TMainMenu;
    miVendas: TMenuItem;
    miPedidos: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure miPedidosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frPrincipal: TfrPrincipal;

implementation

{$R *.dfm}

uses DConexao, DClientes, DProdutos, DPedidos, FPedidos, UUtilDialogs;


procedure TfrPrincipal.FormActivate(Sender: TObject);
begin
    // Como é só teste, abrindo direto a tela de Pedidos
    miPedidosClick(Sender);
end;

procedure TfrPrincipal.FormCreate(Sender: TObject);
var
    MensagemErro: String;
begin
    if not dmConexao.Conectar(MensagemErro) then
    begin
        UUtilDialogs.ExibirErro(MensagemErro);
        Application.Terminate;
    end;
end;

procedure TfrPrincipal.miPedidosClick(Sender: TObject);
begin
    dmClientes.CarregarClientes;
    dmProdutos.CarregarProdutos;
    if not Assigned(dmPedidos) then
    begin
       dmPedidos := TdmPedidos.Create(Self);
       frPedidos := TfrPedidos.Create(Self);
    end else
    begin
       // caso esteja minimizado
       frPedidos.WindowState := wsNormal;
    end;
end;

end.
