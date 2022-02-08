object FrProduto: TFrProduto
  Left = 0
  Top = 0
  Width = 622
  Height = 44
  TabOrder = 0
  object Label1: TLabel
    Left = 3
    Top = 1
    Width = 38
    Height = 13
    Caption = 'Produto'
  end
  object Label2: TLabel
    Left = 344
    Top = 1
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label3: TLabel
    Left = 442
    Top = 1
    Width = 64
    Height = 13
    Caption = 'Valor Unit'#225'rio'
  end
  object edtDescricaoProduto: TEdit
    Left = 73
    Top = 16
    Width = 236
    Height = 21
    TabStop = False
    Color = clInactiveCaption
    ReadOnly = True
    TabOrder = 0
    Text = 'Edit1'
  end
  object btnConfirmar: TButton
    Left = 543
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btnConfirmarClick
  end
  object edtVALOR_UNITARIO: TEditNumber
    Left = 442
    Top = 16
    Width = 95
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
    Decimais = 2
    MostrarZero = True
    Value = 0.000000000000000000
  end
  object edtQUANTIDADE: TEditNumber
    Left = 343
    Top = 16
    Width = 93
    Height = 21
    Alignment = taRightJustify
    TabOrder = 3
    Decimais = 3
    MostrarZero = True
    Value = 0.000000000000000000
  end
  object edtID_PRODUTO: TEditNumber
    Left = 3
    Top = 16
    Width = 70
    Height = 21
    TabOrder = 4
    OnExit = edtID_PRODUTOExit
    Decimais = 0
    MostrarZero = False
    Value = 0
  end
end
