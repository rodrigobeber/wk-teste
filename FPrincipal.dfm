object frPrincipal: TfrPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste para WK - Rodrigo Luiz Beber'
  ClientHeight = 764
  ClientWidth = 1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmPrincipal
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  TextHeight = 15
  object mmPrincipal: TMainMenu
    Left = 192
    Top = 176
    object miVendas: TMenuItem
      Caption = '&Vendas'
      object miPedidos: TMenuItem
        Caption = '&Pedidos'
        OnClick = miPedidosClick
      end
    end
  end
end
