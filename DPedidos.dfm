object dmPedidos: TdmPedidos
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object qryPedido: TFDQuery
    OnNewRecord = qryPedidoNewRecord
    CachedUpdates = True
    Connection = dmConexao.fdConexao
    SchemaAdapter = fdSchemaAdapter
    FetchOptions.AssignedValues = [evDetailCascade]
    SQL.Strings = (
      'select *'
      'from pedidos'
      'where nr_pedido = :nr_pedido')
    Left = 320
    Top = 88
    ParamData = <
      item
        Name = 'NR_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryPedidonr_pedido: TFDAutoIncField
      FieldName = 'nr_pedido'
      Origin = 'nr_pedido'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
      OnGetText = qryPedidonr_pedidoGetText
      DisplayFormat = 'N'#250'mero do pedido'
    end
    object qryPedidocd_cliente: TIntegerField
      DisplayLabel = 'C'#243'digo do Cliente'
      FieldName = 'cd_cliente'
      Origin = 'cd_cliente'
      Required = True
    end
    object qryPedidovl_total: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'vl_total'
      Origin = 'vl_total'
      Required = True
      DisplayFormat = '0.00,'
      Precision = 10
      Size = 2
    end
    object qryPedidods_cliente_nome: TStringField
      DisplayLabel = 'Nome do Cliente'
      FieldKind = fkLookup
      FieldName = 'ds_cliente_nome'
      LookupDataSet = dmClientes.qryClientes
      LookupKeyFields = 'cd_cliente'
      LookupResultField = 'ds_nome'
      KeyFields = 'cd_cliente'
      Lookup = True
    end
    object qryPedidods_cliente_cidade: TStringField
      DisplayLabel = 'Nome da Cidade do Cliente'
      FieldKind = fkLookup
      FieldName = 'ds_cliente_cidade'
      LookupDataSet = dmClientes.qryClientes
      LookupKeyFields = 'cd_cliente'
      LookupResultField = 'ds_cidade'
      KeyFields = 'cd_cliente'
      Lookup = True
    end
    object qryPedidodt_emissao: TDateTimeField
      DisplayLabel = 'Data de Emiss'#227'o'
      FieldName = 'dt_emissao'
      Origin = 'dt_emissao'
      Required = True
    end
    object qryPedidocd_cliente_uf: TStringField
      DisplayLabel = 'UF do Cliente'
      FieldKind = fkLookup
      FieldName = 'cd_cliente_uf'
      LookupDataSet = dmClientes.qryClientes
      LookupKeyFields = 'cd_cliente'
      LookupResultField = 'cd_uf'
      KeyFields = 'cd_cliente'
      Lookup = True
    end
  end
  object dsPedido: TDataSource
    DataSet = qryPedido
    Left = 224
    Top = 88
  end
  object qryPedidoProdutos: TFDQuery
    CachedUpdates = True
    IndexFieldNames = 'nr_pedido'
    MasterSource = dsPedido
    MasterFields = 'nr_pedido'
    DetailFields = 'nr_pedido'
    Connection = dmConexao.fdConexao
    SchemaAdapter = fdSchemaAdapter
    FetchOptions.AssignedValues = [evDetailCascade]
    FetchOptions.DetailCascade = True
    SQL.Strings = (
      'select *'
      'from pedidos_produtos'
      'where nr_pedido = :nr_pedido')
    Left = 336
    Top = 160
    ParamData = <
      item
        Name = 'NR_PEDIDO'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = Null
      end>
    object qryPedidoProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryPedidoProdutosnr_pedido: TIntegerField
      FieldName = 'nr_pedido'
      Origin = 'nr_pedido'
      Required = True
    end
    object qryPedidoProdutoscd_produto: TIntegerField
      DisplayLabel = 'C'#243'digo do Produto'
      FieldName = 'cd_produto'
      Origin = 'cd_produto'
      Required = True
    end
    object qryPedidoProdutosnr_quantidade: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'nr_quantidade'
      Origin = 'nr_quantidade'
      Required = True
    end
    object qryPedidoProdutosvl_unitario: TBCDField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'vl_unitario'
      Origin = 'vl_unitario'
      Required = True
      DisplayFormat = '0.00,'
      Precision = 10
      Size = 2
    end
    object qryPedidoProdutosvl_total: TBCDField
      DisplayLabel = 'Valor Total do Produto'
      FieldName = 'vl_total'
      Origin = 'vl_total'
      Required = True
      DisplayFormat = '0.00,'
      Precision = 10
      Size = 2
    end
    object qryPedidoProdutosds_produto_descricao: TStringField
      FieldKind = fkLookup
      FieldName = 'ds_produto_descricao'
      LookupDataSet = dmProdutos.qryProdutos
      LookupKeyFields = 'cd_produto'
      LookupResultField = 'ds_descricao'
      KeyFields = 'cd_produto'
      Size = 100
      Lookup = True
    end
  end
  object dsPedidoProdutos: TDataSource
    DataSet = qryPedidoProdutos
    Left = 216
    Top = 160
  end
  object fdSchemaAdapter: TFDSchemaAdapter
    Left = 272
    Top = 232
  end
  object memtProduto: TFDMemTable
    OnNewRecord = memtProdutoNewRecord
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 328
    Top = 312
    object memtProdutocd_produto: TIntegerField
      DisplayLabel = 'C'#243'digo do Produto'
      FieldName = 'cd_produto'
      Required = True
      OnValidate = memtProdutocd_produtoValidate
    end
    object memtProdutods_produto: TStringField
      FieldKind = fkLookup
      FieldName = 'ds_produto'
      LookupDataSet = dmProdutos.qryProdutos
      LookupKeyFields = 'cd_produto'
      LookupResultField = 'ds_descricao'
      KeyFields = 'cd_produto'
      OnGetText = memtProdutods_produtoGetText
      Size = 100
      Lookup = True
    end
    object memtProdutonr_quantidade: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'nr_quantidade'
      Required = True
      OnValidate = memtProdutonr_quantidadeValidate
    end
    object memtProdutovl_unitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'vl_unitario'
      Required = True
      OnValidate = memtProdutonr_quantidadeValidate
    end
    object memtProdutovl_total: TCurrencyField
      DisplayLabel = 'Valor Total'
      FieldName = 'vl_total'
      Required = True
    end
    object memtProdutoeh_novo: TBooleanField
      FieldName = 'eh_novo'
      Required = True
    end
  end
  object dsProduto: TDataSource
    DataSet = memtProduto
    Left = 224
    Top = 312
  end
  object fdTransaction: TFDTransaction
    Connection = dmConexao.fdConexao
    Left = 280
    Top = 384
  end
end
