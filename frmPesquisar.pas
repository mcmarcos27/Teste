unit frmPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Grids, xGrid,
  Vcl.StdCtrls, untEdits, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Vcl.DBGrids;

type
  TFormPesquisar = class(TForm)
    pnlPesquisa: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    eDescricao: TEditText;
    pnlBotoes: TPanel;
    btCancelar: TSpeedButton;
    btConfirmar: TSpeedButton;
    DBGrid1: TDBGrid;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    cbxFiltro: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPesquisar: TFormPesquisar;

implementation

{$R *.dfm}

end.
