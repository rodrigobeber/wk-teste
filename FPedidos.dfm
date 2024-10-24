object frPedidos: TfrPedidos
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pedidos'
  ClientHeight = 611
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object pnPedido: TPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 611
    Align = alClient
    TabOrder = 0
    object pnPedidoTopo: TPanel
      Left = 1
      Top = 1
      Width = 740
      Height = 128
      Align = alTop
      TabOrder = 0
      object pnPedidoToolbar: TPanel
        Left = 1
        Top = 1
        Width = 738
        Height = 37
        Align = alTop
        TabOrder = 0
        object btGravarPedido: TBitBtn
          Left = 9
          Top = 6
          Width = 105
          Height = 25
          Hint = 'Salvar o pedido atual'
          Caption = 'Gravar Pedido'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btGravarPedidoClick
        end
        object btCancelarPedido: TBitBtn
          Left = 231
          Top = 6
          Width = 105
          Height = 25
          Hint = 'Excluir um pedido pelo n'#250'mero'
          Caption = 'Excluir Pedido'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btCancelarPedidoClick
        end
        object btAbrirPedido: TBitBtn
          Left = 120
          Top = 6
          Width = 105
          Height = 25
          Hint = 'Cancelar um pedido pelo n'#250'mero'
          Caption = 'Abrir Pedido'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btAbrirPedidoClick
        end
      end
      object pnDadosPedido: TPanel
        Left = 1
        Top = 38
        Width = 738
        Height = 89
        Align = alClient
        TabOrder = 1
        DesignSize = (
          738
          89)
        object dbedDataEmissao: TDBLabeledEdit
          Left = 318
          Top = 58
          Width = 120
          Height = 23
          Anchors = [akLeft]
          Color = clWhite
          DataField = 'dt_emissao'
          DataSource = dmPedidos.dsPedido
          Enabled = False
          ReadOnly = True
          TabOrder = 4
          EditLabel.Width = 86
          EditLabel.Height = 23
          EditLabel.Caption = 'Data de Emiss'#227'o'
          LabelPosition = lpLeft
        end
        object dbedNumeroPedido: TDBLabeledEdit
          Left = 86
          Top = 58
          Width = 121
          Height = 23
          Anchors = [akLeft]
          Color = clWhite
          DataField = 'nr_pedido'
          DataSource = dmPedidos.dsPedido
          Enabled = False
          ReadOnly = True
          TabOrder = 3
          EditLabel.Width = 63
          EditLabel.Height = 23
          EditLabel.Caption = 'Pedido Nro.'
          LabelPosition = lpLeft
        end
        object dbedNomeCliente: TDBEdit
          Left = 153
          Top = 8
          Width = 285
          Height = 23
          DataField = 'ds_cliente_nome'
          DataSource = dmPedidos.dsPedido
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object dbedCidadeCliente: TDBLabeledEdit
          Left = 86
          Top = 33
          Width = 303
          Height = 23
          Color = clWhite
          DataField = 'ds_cliente_cidade'
          DataSource = dmPedidos.dsPedido
          Enabled = False
          ReadOnly = True
          TabOrder = 1
          EditLabel.Width = 37
          EditLabel.Height = 23
          EditLabel.Caption = 'Cidade'
          LabelPosition = lpLeft
        end
        object dbedUfCliente: TDBEdit
          Left = 392
          Top = 33
          Width = 46
          Height = 23
          Color = clWhite
          DataField = 'cd_cliente_uf'
          DataSource = dmPedidos.dsPedido
          Enabled = False
          ReadOnly = True
          TabOrder = 2
        end
        object edCodigoCliente: TLabeledEdit
          Left = 86
          Top = 8
          Width = 65
          Height = 23
          EditLabel.Width = 65
          EditLabel.Height = 23
          EditLabel.Caption = 'C'#243'd. Cliente'
          LabelPosition = lpLeft
          TabOrder = 5
          Text = ''
          OnExit = edCodigoClienteExit
        end
      end
    end
    object pnPedidoRodape: TPanel
      Left = 1
      Top = 576
      Width = 740
      Height = 34
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        740
        34)
      object dbedTotalPedido: TDBLabeledEdit
        Left = 565
        Top = 4
        Width = 167
        Height = 23
        Anchors = [akTop, akRight]
        DataField = 'vl_total'
        DataSource = dmPedidos.dsPedido
        Enabled = False
        TabOrder = 0
        EditLabel.Width = 111
        EditLabel.Height = 23
        EditLabel.Caption = 'Valor Total do Pedido'
        LabelPosition = lpLeft
      end
    end
    object pnPedidoProdutos: TPanel
      Left = 1
      Top = 129
      Width = 740
      Height = 447
      Align = alClient
      TabOrder = 2
      object pnDadosProduto: TPanel
        Left = 1
        Top = 1
        Width = 738
        Height = 88
        Align = alTop
        TabOrder = 0
        ExplicitLeft = 0
        ExplicitTop = 5
        object dbedCodigoProduto: TDBLabeledEdit
          Left = 86
          Top = 5
          Width = 65
          Height = 23
          DataField = 'cd_produto'
          DataSource = dmPedidos.dsProduto
          TabOrder = 0
          EditLabel.Width = 71
          EditLabel.Height = 23
          EditLabel.Caption = 'C'#243'd. Produto'
          LabelPosition = lpLeft
        end
        object dbedDescricaoProduto: TDBEdit
          Left = 153
          Top = 5
          Width = 285
          Height = 23
          DataField = 'ds_produto'
          DataSource = dmPedidos.dsProduto
          Enabled = False
          ReadOnly = True
          TabOrder = 1
        end
        object dbedQuantidadeProduto: TDBLabeledEdit
          Left = 86
          Top = 30
          Width = 65
          Height = 23
          DataField = 'nr_quantidade'
          DataSource = dmPedidos.dsProduto
          TabOrder = 2
          EditLabel.Width = 62
          EditLabel.Height = 23
          EditLabel.Caption = 'Quantidade'
          LabelPosition = lpLeft
        end
        object dbedValorUnitarioProduto: TDBLabeledEdit
          Left = 232
          Top = 30
          Width = 63
          Height = 23
          DataField = 'vl_unitario'
          DataSource = dmPedidos.dsProduto
          TabOrder = 3
          EditLabel.Width = 71
          EditLabel.Height = 23
          EditLabel.Caption = 'Valor Unit'#225'rio'
          LabelPosition = lpLeft
        end
        object dbedValorTotalProduto: TDBLabeledEdit
          Left = 366
          Top = 30
          Width = 72
          Height = 23
          DataField = 'vl_total'
          DataSource = dmPedidos.dsProduto
          Enabled = False
          ReadOnly = True
          TabOrder = 4
          EditLabel.Width = 54
          EditLabel.Height = 23
          EditLabel.Caption = 'Valor Total'
          LabelPosition = lpLeft
        end
        object btConfirmarProduto: TBitBtn
          Left = 86
          Top = 57
          Width = 65
          Height = 25
          Caption = 'Confirmar'
          ModalResult = 6
          NumGlyphs = 2
          TabOrder = 5
          OnClick = btConfirmarProdutoClick
        end
        object btCancelarProduto: TBitBtn
          Left = 154
          Top = 57
          Width = 65
          Height = 25
          Caption = 'Cancelar'
          ModalResult = 6
          NumGlyphs = 2
          TabOrder = 6
          OnClick = btCancelarProdutoClick
        end
      end
      object pnGridProdutos: TPanel
        Left = 1
        Top = 89
        Width = 738
        Height = 357
        Align = alClient
        TabOrder = 1
        object dbgrdProdutos: TDBGrid
          Left = 1
          Top = 1
          Width = 736
          Height = 355
          Align = alClient
          DataSource = dmPedidos.dsPedidoProdutos
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnEnter = dbgrdProdutosEnter
          OnKeyDown = dbgrdProdutosKeyDown
          Columns = <
            item
              Expanded = False
              FieldName = 'cd_produto'
              Title.Alignment = taCenter
              Title.Caption = 'C'#243'digo'
              Width = 82
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ds_produto_descricao'
              Title.Caption = 'Descri'#231#227'o'
              Width = 270
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nr_quantidade'
              Title.Alignment = taCenter
              Title.Caption = 'Qtdade'
              Width = 67
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'vl_unitario'
              Title.Alignment = taCenter
              Title.Caption = 'Valor Unit.'
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'vl_total'
              Title.Alignment = taCenter
              Title.Caption = 'Valor Total'
              Width = 122
              Visible = True
            end>
        end
      end
    end
  end
end
