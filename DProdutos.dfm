object dmProdutos: TdmProdutos
  Height = 480
  Width = 640
  object qryProdutos: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'select cd_produto, ds_descricao, vl_preco_venda'
      'from produtos'
      'order by ds_descricao')
    Left = 344
    Top = 208
  end
  object dsProdutos: TDataSource
    AutoEdit = False
    DataSet = qryProdutos
    Left = 216
    Top = 208
  end
end
