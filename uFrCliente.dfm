object FrCliente: TFrCliente
  Left = 0
  Top = 0
  Width = 380
  Height = 42
  TabOrder = 0
  object Label1: TLabel
    Left = 1
    Top = 0
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object edtNOME: TEdit
    Left = 72
    Top = 19
    Width = 279
    Height = 21
    TabStop = False
    Color = clInactiveCaption
    ReadOnly = True
    TabOrder = 1
  end
  object edtID_CLIENTE: TEditNumber
    Left = 1
    Top = 19
    Width = 70
    Height = 21
    TabOrder = 0
    OnExit = edtID_CLIENTEExit
    Decimais = 0
    MostrarZero = False
    Value = 0
  end
end
