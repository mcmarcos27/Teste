object FrmPedidos: TFrmPedidos
  Left = 0
  Top = 0
  Caption = 'Pedidos'
  ClientHeight = 402
  ClientWidth = 746
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 103
    Height = 402
    Align = alLeft
    TabOrder = 0
    object sbGravar: TSpeedButton
      Left = 3
      Top = 7
      Width = 95
      Height = 31
      Caption = 'Gravar'
      Enabled = False
      OnClick = sbGravarClick
    end
    object sbCancelar: TSpeedButton
      Left = 3
      Top = 44
      Width = 95
      Height = 31
      Caption = 'Cancelar Edi'#231#227'o'
      Enabled = False
      OnClick = sbCancelarClick
    end
    object sbFechar: TSpeedButton
      Left = 6
      Top = 365
      Width = 95
      Height = 37
      Caption = 'Fechar'
      Flat = True
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6487B6436794ECEAE5FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFEFFFFFEFFFEFFFFFF84A2C708479F113D78938F8AACACACF8F8F8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFEFFFEFFFFFFCAD5E0003F9D1C59AA184177AAA5A0979796959596D3D3
        D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FEFEFEFFFFFFD6DEE806439E1C57AA1C58A5193B72B7B5AFAAAAAAADADADA5A5
        A5AEAEAEEBEBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
        FFFFFEF9F9F92B5EA21551A61F57A71D56A6193A6CC3C0BBB4B4B3B7B7B7B9B9
        B9B9B9B9B7B7B7D1D1D1F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFFFFFF
        FFFFFF3B68A6114EA4205AAB1E5CAC1C57A5163869CECDC7BFBEBEC1C1C1C4C4
        C4C6C6C6CBCBCBC7C7C7C9C9C9E8E8E8FFFFFFFFFEFFFEFFFEFFFFFEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        688AB6074AA3225BAC2263B2215EB11E58A4163765DFDDD9CDCDCCD0D0D0D2D2
        D2D5D5D5D8D8D8DBDBDBDCDCDCDCDBDBE2E2E2FFFFFFFFFFFFFEFDFDFFFEFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8CA6C77291BB
        0A4AA3235DAE2665B62565B72461B21F59A5143464E3E0DCD0D0D0D6D6D6D8D8
        D8DDDDDDE0E0E0E5E5E5EAEAEAEEEFEFF8F6F194AEC89CB0C9FFFFFFFEFFFEFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1E5BAB0D4BA0
        2762B32769BA2768B92767B82664B6225CA814325FD4D2CDC5C4C4CACACAD2D2
        D2D6D6D6DCDCDCE1E1E1E7E7E7F1F0F0F7F5F23776BB3768ABFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF336AB31F59A6
        2C6BBB296BBD286ABB2A6CBC2668BA275EAA11305DD6D5CFC6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7F0F0F0F8F7F34980BD4774B3FFFFFFFFFFFFFE
        FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF346DB61D5AAD
        2F6DBD2B6DC02B6CBE2C6DBF296BBB2660AE0F2F5AD8D3CEC6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7F0F0EFF8F6F34A82C14D79BAFFFFFCACCFACFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF346FBB3C6596
        2C6FC12D71C32D70C12D71C12A6EC22F64AF223755D4D3D0C6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7F0F0EFF8F7F34F85CA5073C279CA7265B668FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3171BE526E91
        2D71C62D73C62F74C52C73C82265B63266A5484B4ED2D1D0C6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7F1F0EFFDF9F94879B7228E3F4CC74F79C07DFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3976BF3066AA
        3176C82F75C82A74CB4983C965605A224371333B44D3D2D3C6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7F6F2F6EFF0F040A3524CC54C46C14E7ABD80FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3D78C02664B6
        3579C92E78CA3179CA3676C24170AC4179BB696A6DCDCDCEC6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE2E2E2EFEBEFF7F3F74CB64C39B73B42BA4848BF5067BB6BAA
        D7AAA1D6A2A3D6A4A3D6A4A3D7A4A4D7A4A4D8A6A7D9A797D0983D7BC42968B6
        377BCE357CCD3273C42A6DC02872C83270B8263C5AD5D2CFC6C6C6CDCDCDD3D3
        D3D6D6D6DCDCDCEBE5ECE6E8E538B03B2FB1343CB7403EB84543B94B43BB4C40
        BC4744BB4D4ABE514EC05852C25D56C45F59C76464CA704FC058407DC5296AB9
        3F82D13175C62E73C63178C8317ACD3571B90A2856D7D6D0C6C6C6CDCDCDD3D3
        D3D6D6D6E5DFE7DBE2D83CAF4027AD2B32B23738B43B3CB6423FB84542BB4948
        BD4E4BBE5250C15654C25C58C5615CC76560C76966CD705AC25F4280C82D6DBC
        3279CB2D70C23375C33982D3317ACC3773BC102A56D6D6D1C6C6C6CDCDCDD2D1
        D2E2D9E2D1DCD029A82D19A81C2CAD302EB03433B13736B43D3CB6423EB84543
        BB4A46BD4F4CBE534FC05754C25C57C5615BC66561CA6C57C15B4482CA2E70BE
        3177C73279C93478C73881D5317ACD3777BD0E2A55D6D6D1C6C6C6CDCDCDD8D2
        D8B5CFB63CAF3C4EBB5339B23B20AA242AAD2E2DB03332B13738B43C3BB5423F
        B84543BB4A48BC4E4BBE5250BF5654C25B59C5615FC86854BF584584CB3071BE
        3B83D1367ED13478C73A83D7337CCF3A79C00E2A54D6D6D1C6C6C6CDCCCDDDD8
        DF5EAE5E3BB8414CB84C50BC5546B9492BAC2C27AC2B2BAF3133B23737B43C3C
        B6433EB84643BB4A46BD4E4BBE524FC05754C35C5AC76251BE584885CC3271C0
        3F87D7347DD1377BC93B84D8327DD13D7AC40D2954D6D6D1C6C6C6CDCDCDD3D2
        D3EDE2EC71BA703AB23B49B94C4DB94F52BE5646B84A36B2392BAF312DB03233
        B3383AB53E3DB74442BA4A46BB4E49BE514FC05554C25C4DBD524888CE3173C2
        4187D8347FD2387CCB3C85D9347FD13E7EC50E2954D6D6D1C6C6C6CDCDCDD2D2
        D2D7D5D8F1E5F27FC27F38B13B49B84B4ABA4E4EBA5152BB5553BD564EBC5145
        B74B41B84943B74843BA4B48BC4E4DBD5352C1595DC66455BE5A4A89CF3273C3
        428BDA357ED2377CCB3E87DB337ED03F80C70D2853D6D6D1C6C6C6CDCDCDD2D3
        D2D6D6D6DDDCDEF4EAF38CC98E31AE3349B94D4BBA4D4ABA4E4DBB5353BC5552
        BE5756C15B59C25E5BC3605EC46461C66765C76C6ACB6F58C15D4D8BD13076C9
        428BDB357FD23B7FCE3C86DA3681D24383C90B2752D6D6D0C6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE2E1E1FFF3FFA3D0A12FAD3247B84C4ABA4D4DBC5152BA5658
        BC5A57BA595ABB5B59BC5B5ABD5F5DBE5F5EBE6262C0674FB7514D8DD64271A6
        438EE0367FD33980CE458DDD3C85D74483CC052550D9D3CEC6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7FFF8FFAED8AC3BB0384CB84E47BA4978BB7BFF
        FFFFF5F8F5F6F8F5F5F8F5F5F7F5F5F7F5F5F7F4F5F7F4F5F8F54A8ED8577696
        428EE3347DD1377FCB4088DA3A82D14FA2EB5E91C0CDC8C3C6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7EFEFEFFFF8FF53A0A23EB63545BA4779BB7BFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5090D43779C1
        458EDE428BD93983D73D86D550A4EC7AA5CBCAC2BBC3C1C2C6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7F0F0EFF8F7F25D95E93A88A93EB33473BD76FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5191D53379C7
        4E97E53981D23F89D74C9EE48AA5BFC1BBB6BEBDBBC1C2C2C6C6C6CDCDCDD3D3
        D3D6D6D6DDDDDDE1E1E1E7E7E7F0F0EFF8F7F15696D86395DCD2EAC967AF67FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5292D63378C9
        3685DB3E8BD94897E08DA4B7BEB7AFB9B8B8BBBBBCC2C2C2C6C6C6CCCCCCD2D2
        D3D6D6D6DCDCDCE1E1E1E7E7E7EFEFEFF9F7F25898D8578ECFFFFFFFF3F5F4FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5392D73579CA
        4995DE5B99CFB0ACAAC8B9AAC3BBB2C8C1B8CDC4BCD4CCC3D8D1C8E0D8CFE5DE
        D5EAE3DAF0EAE1F6F0E7FDF6EFFFFFF8FFFFF75E9CD9578FCEFFFFFEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5294D62B75C8
        317AC85080B85A85B75684BA5786BB5988BF5B89C05D8BC15C8DC35E8EC46290
        C76391C96694CA6796CB6A97CC6B9ACE6E9AC83C87D45B93D0FFFFFEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF518DCC4F90D7
        508FD74B8FD8478ED8478CD7478BD7468CD7448AD54288D54388D34187D23F86
        D33E85D23D85D23B83D13C81D03980D03A80D0387ECD6193CAFFFFFEFFFFFEFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = sbFecharClick
    end
    object sbExcluir: TSpeedButton
      Left = 3
      Top = 201
      Width = 95
      Height = 31
      Caption = 'Excluir Pedido'
      Enabled = False
      OnClick = sbExcluirClick
    end
  end
  object Panel2: TPanel
    Left = 103
    Top = 0
    Width = 643
    Height = 402
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object lbTotalPedido: TLabel
      Left = 1
      Top = 382
      Width = 641
      Height = 19
      Align = alBottom
      Alignment = taCenter
      Caption = 'Total Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 104
    end
    object btnPesquisar: TSpeedButton
      Left = 87
      Top = 25
      Width = 23
      Height = 22
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFF000000
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
        000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FF
        FFFFFFFFFFFFFFFF2A2A2AC9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF000000000000000000FFFFFF0000000000000000000000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFAFAFAF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9C9C9000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF8C8C8C0000
        00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFF}
      OnClick = btnPesquisarClick
    end
    object grdProdutos: TDBGrid
      Left = 1
      Top = 149
      Width = 641
      Height = 233
      TabStop = False
      Align = alBottom
      DataSource = dsItensPedido
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = grdProdutosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'ID_PRODUTO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Width = 254
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_UNITARIO'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLTOTAL'
          Width = 82
          Visible = True
        end>
    end
    inline FrProduto1: TFrProduto
      Left = 6
      Top = 104
      Width = 622
      Height = 44
      TabOrder = 2
      ExplicitLeft = 6
      ExplicitTop = 104
      inherited Label2: TLabel
        Left = 347
        ExplicitLeft = 347
      end
      inherited btnPesquisar: TSpeedButton
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF000000
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
          000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FF
          FFFFFFFFFFFFFFFF2A2A2AC9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF000000000000000000FFFFFF0000000000000000000000000000
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFAFAFAF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9C9C9000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF8C8C8C0000
          00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFF}
      end
      inherited edtDescricaoProduto: TEdit
        Width = 247
        TabOrder = 4
        Text = ''
        ExplicitWidth = 247
      end
      inherited btnConfirmar: TButton
        TabOrder = 3
        OnClick = FrProduto1btnConfirmarClick
      end
      inherited edtQUANTIDADE: TEditNumber
        Left = 346
        TabOrder = 1
        ExplicitLeft = 346
      end
      inherited edtID_PRODUTO: TEditNumber
        TabOrder = 0
      end
    end
    object edtCodigo: TEditNumber
      Left = 8
      Top = 26
      Width = 78
      Height = 21
      TabOrder = 0
      OnExit = edtCodigoExit
      Decimais = 0
      MostrarZero = False
      Value = 0
    end
    inline FrCliente1: TFrCliente
      Left = 8
      Top = 56
      Width = 380
      Height = 42
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 56
      inherited btnPesquisar: TSpeedButton
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF000000
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
          000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FF
          FFFFFFFFFFFFFFFF2A2A2AC9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF000000000000000000FFFFFF0000000000000000000000000000
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFAFAFAF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9C9C9000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF8C8C8C0000
          00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFF}
      end
      inherited edtNOME: TEdit
        Text = ''
      end
    end
  end
  object cdsItensPedido: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    AfterPost = cdsItensPedidoAfterPost
    AfterDelete = cdsItensPedidoAfterDelete
    OnNewRecord = cdsItensPedidoNewRecord
    Left = 465
    Top = 16
    object cdsItensPedidoNUMERO_PED: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'NUMERO_PED'
    end
    object cdsItensPedidoID_PRODUTO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_PRODUTO'
    end
    object cdsItensPedidoQUANTIDADE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      DisplayFormat = ',##0.000'
    end
    object cdsItensPedidoVALOR_UNITARIO: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALOR_UNITARIO'
      DisplayFormat = ',##0.00'
    end
    object cdsItensPedidoVLTOTAL: TFloatField
      DisplayLabel = 'Total'
      FieldName = 'VLTOTAL'
      DisplayFormat = ',##0.00'
    end
    object cdsItensPedidoDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 300
    end
    object cdsItensPedidoID_ITEM: TIntegerField
      DisplayLabel = 'Item'
      FieldName = 'ID_ITEM'
    end
  end
  object dsItensPedido: TDataSource
    DataSet = cdsItensPedido
    Left = 441
    Top = 24
  end
end
