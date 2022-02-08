object FrmPesquisar: TFrmPesquisar
  Left = 0
  Top = 0
  Caption = 'FrmPesquisar'
  ClientHeight = 352
  ClientWidth = 636
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 322
    Width = 636
    Height = 30
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 360
    ExplicitWidth = 630
    object btCancelar: TSpeedButton
      Left = 539
      Top = 2
      Width = 90
      Height = 26
      Caption = 'Cancelar'
      OnClick = btCancelarClick
    end
    object btConfirmar: TSpeedButton
      Left = 444
      Top = 2
      Width = 90
      Height = 26
      Caption = 'Confirmar'
      OnClick = btConfirmarClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 636
    Height = 322
    Align = alClient
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMERO_PED'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTEMISSAO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENTE'
        Visible = True
      end>
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 160
    object cdsItensNUMERO_PED: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'NUMERO_PED'
    end
    object cdsItensDTEMISSAO: TDateTimeField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'DTEMISSAO'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object cdsItensCLIENTE: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'CLIENTE'
      Size = 300
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 216
    Top = 208
  end
end
