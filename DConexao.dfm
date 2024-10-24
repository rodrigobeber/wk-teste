object dmConexao: TdmConexao
  Height = 336
  Width = 483
  object fdConexao: TFDConnection
    Params.Strings = (
      'Database=wk'
      'User_Name=root'
      'Password=123456'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 152
    Top = 80
  end
  object fdMySQLDriver: TFDPhysMySQLDriverLink
    VendorLib = 'C:\WKTeste\libmysql.dll'
    Left = 288
    Top = 80
  end
  object fdWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 144
    Top = 176
  end
  object qryDataHoraServidor: TFDQuery
    Connection = fdConexao
    SQL.Strings = (
      'select current_timestamp ')
    Left = 288
    Top = 176
  end
end
