unit ufrmPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Grids, xGrid,
  Vcl.StdCtrls, untEdits, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Vcl.DBGrids,
  uTabela,TypInfo, uPedido;

type
  TFrmPesquisar = class(TForm)
    pnlBotoes: TPanel;
    btCancelar: TSpeedButton;
    btConfirmar: TSpeedButton;
    DBGrid1: TDBGrid;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    cdsItensNUMERO_PED: TIntegerField;
    cdsItensDTEMISSAO: TDateTimeField;
    cdsItensCLIENTE: TStringField;
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function PesquisarPedido():TPedido;

implementation

{$R *.dfm}

uses uFuncoes;
function PesquisarPedido():TPedido;
var
  F: TFrmPesquisar;
begin
  try
    F := TFrmPesquisar.Create(nil);
    if F.ShowModal = mrOk then
    begin
      Result := TPedido.GetPedido(f.cdsItens.FieldByName('NUMERO_PED').AsInteger);
    end;
  finally
    FreeAndNil(F);
  end;
end;

procedure TFrmPesquisar.btCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmPesquisar.btConfirmarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesquisar.FormShow(Sender: TObject);
var
  lPedidos: TListaPedidos;
  i:Integer;
begin
  try
      IniciarClientDataSet(cdsItens);
      lPedidos := TPedido.GetPedidos(nil, False);
      if not Assigned(lPedidos) then begin
        MensagemInformar('Nenhum registro encontrado!');
        Exit;
      end;

      for i := Low(lPedidos) to High(lPedidos) do
      begin
        cdsItens.Append;
        cdsItens.FieldByName('NUMERO_PED').AsVariant := lPedidos[i].NUMERO_PED;
        cdsItens.FieldByName('DTEMISSAO').AsVariant := lPedidos[i].DTEMISSAO;
        cdsItens.FieldByName('CLIENTE').AsVariant := lPedidos[i].CLIENTE.Nome;
        cdsItens.Post;
      end;

    finally
      lPedidos := nil;
    end;
end;

end.
