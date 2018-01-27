object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 438
  Width = 591
  object ConOrigem: TUniConnection
    ConnectDialog = DialogOrigem
    Left = 24
    Top = 40
  end
  object ConDestino: TUniConnection
    ConnectDialog = DialogDestino
    Left = 24
    Top = 112
  end
  object fdqOrigem: TUniQuery
    Connection = ConOrigem
    Left = 104
    Top = 40
  end
  object fdqDestino: TUniQuery
    Connection = ConDestino
    Left = 104
    Top = 112
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 504
    Top = 120
  end
  object OracleUniProvider1: TOracleUniProvider
    Left = 512
    Top = 176
  end
  object PostgreSQLUniProvider1: TPostgreSQLUniProvider
    Left = 496
    Top = 224
  end
  object SQLServerUniProvider1: TSQLServerUniProvider
    Left = 520
    Top = 280
  end
  object SQLiteUniProvider1: TSQLiteUniProvider
    Left = 512
    Top = 344
  end
  object InterBaseUniProvider1: TInterBaseUniProvider
    Left = 392
    Top = 344
  end
  object AccessUniProvider1: TAccessUniProvider
    Left = 264
    Top = 344
  end
  object DialogOrigem: TUniConnectDialog
    DatabaseLabel = 'Base de dados'
    PortLabel = 'Porta'
    ProviderLabel = 'Fornecedor'
    SavePassword = True
    Caption = 'Iniciar Sess'#227'o'
    UsernameLabel = 'Nome do Usu'#225'rio'
    PasswordLabel = 'Senha'
    ServerLabel = 'Servidor'
    ConnectButton = 'Ok'
    CancelButton = 'Cancelar'
    LabelSet = lsPortuguese
    Left = 184
    Top = 8
  end
  object DialogDestino: TUniConnectDialog
    DatabaseLabel = 'Base de dados'
    PortLabel = 'Porta'
    ProviderLabel = 'Fornecedor'
    Caption = 'Iniciar Sess'#227'o'
    UsernameLabel = 'Nome do Usu'#225'rio'
    PasswordLabel = 'Senha'
    ServerLabel = 'Servidor'
    ConnectButton = 'Ok'
    CancelButton = 'Cancelar'
    LabelSet = lsPortuguese
    Left = 272
    Top = 8
  end
end
