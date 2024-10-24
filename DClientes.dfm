object dmClientes: TdmClientes
  Height = 480
  Width = 640
  object qryClientes: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'select cd_cliente, ds_nome, ds_cidade, cd_uf'
      'from clientes'
      'order by ds_nome')
    Left = 280
    Top = 152
  end
  object dsClientes: TDataSource
    DataSet = qryClientes
    Left = 184
    Top = 152
  end
end
