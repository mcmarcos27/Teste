object dmConexao: TdmConexao
  OldCreateOrder = False
  Height = 245
  Width = 330
  object fdConexao: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Server=127.0.0.1'
      'User_Name=root'
      'Password=marcos'
      'Database=marcos')
    LoginPrompt = False
    Left = 34
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files (x86)\MySQL\MySQL Server 5.7\lib\libmysql.dll'
    Left = 122
    Top = 24
  end
end
