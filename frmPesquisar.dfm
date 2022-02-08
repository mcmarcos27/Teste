object FormPesquisar: TFormPesquisar
  Left = 0
  Top = 0
  Caption = 'FormPesquisar'
  ClientHeight = 352
  ClientWidth = 636
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 636
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 630
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 65
      Height = 13
      Caption = 'Tipo pesquisa'
    end
    object Label2: TLabel
      Left = 175
      Top = 11
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object eDescricao: TEditText
      Left = 175
      Top = 30
      Width = 440
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      TipoEdit = tpEdit
    end
    object cbxFiltro: TComboBox
      Left = 8
      Top = 30
      Width = 159
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 322
    Width = 636
    Height = 30
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 360
    ExplicitWidth = 630
    object btCancelar: TSpeedButton
      Left = 539
      Top = 2
      Width = 90
      Height = 26
      Caption = 'Cancelar'
    end
    object btConfirmar: TSpeedButton
      Left = 444
      Top = 2
      Width = 90
      Height = 26
      Caption = 'Confirmar'
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 65
    Width = 636
    Height = 257
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 160
  end
  object dsItens: TDataSource
    Left = 216
    Top = 208
  end
end
