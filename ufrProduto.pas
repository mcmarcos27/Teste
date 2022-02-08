unit ufrProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untEdits, Data.DB,
  Datasnap.DBClient, uProduto, Vcl.Buttons;

type
  TFrProduto = class(TFrame)
    edtDescricaoProduto: TEdit;
    btnConfirmar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtVALOR_UNITARIO: TEditNumber;
    edtQUANTIDADE: TEditNumber;
    edtID_PRODUTO: TEditNumber;
    procedure btnConfirmarClick(Sender: TObject);virtual;
    procedure edtID_PRODUTOExit(Sender: TObject);virtual;
  private
     FClientDataSet: TClientDataSet;
     FProduto: TProduto;
     procedure AtualizaEdicaoCampos;
{ Private declarations }
  public
    property Produto:TProduto read FProduto;
    procedure SetClient(pClientDataSet: TClientDataSet);
    procedure SetLabelBotao(pCaption: string);
    procedure EditarProduto();

    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uFuncoes;

procedure TFrProduto.AtualizaEdicaoCampos;
begin
  edtID_PRODUTO.Enabled := FClientDataSet.State in [dsInsert,dsBrowse];
end;

procedure TFrProduto.btnConfirmarClick(Sender: TObject);
begin
  if StrToInt64Def(edtID_PRODUTO.Text,0)=0 then
  begin
     MensagemAtencao('Produto não informado! Verifique');
     edtID_PRODUTO.SetFocus;
     Abort;
  end;

  if edtQUANTIDADE.Value <= 0 then
  begin
     MensagemAtencao('Informe uma quantidade válida para o produto!');
     edtQUANTIDADE.SetFocus;
     Abort;
  end;

  if edtVALOR_UNITARIO.Value <= 0 then
  begin
     MensagemAtencao('Informe o valor unitário para o produto!');
     edtVALOR_UNITARIO.SetFocus;
     Abort;
  end;
  if not (FClientDataSet.State in [dsEdit, dsInsert]) then
  begin
    FClientDataSet.Insert;
  end;
  FClientDataSet.FieldByName('VALOR_UNITARIO').AsFloat := edtVALOR_UNITARIO.AsFloat;
  FClientDataSet.FieldByName('DESCRICAO').AsString := Self.FProduto.Descricao;
  FClientDataSet.FieldByName('QUANTIDADE').AsFloat := edtQUANTIDADE.AsFloat;
  FClientDataSet.FieldByName('ID_PRODUTO').AsFloat := Self.FProduto.ID_PRODUTO;
  FClientDataSet.FieldByName('VLTOTAL').AsFloat := FClientDataSet.FieldByName('QUANTIDADE').AsFloat*
  FClientDataSet.FieldByName('VALOR_UNITARIO').AsFloat;
  FClientDataSet.Post;
  LimparCampos(Self);
  AtualizaEdicaoCampos;
  edtID_PRODUTO.SetFocus;
end;

procedure TFrProduto.EditarProduto();
begin
  if FClientDataSet.IsEmpty then
    Exit;
  SELF.edtID_PRODUTO.Value := FClientDataSet.FieldByName('ID_PRODUTO').AsInteger;
  SELF.edtDescricaoProduto.Text := FClientDataSet.FieldByName('DESCRICAO').AsString;
  SELF.edtQUANTIDADE.Value := FClientDataSet.FieldByName('QUANTIDADE').AsFloat;
  SELF.edtVALOR_UNITARIO.AsFloat := FClientDataSet.FieldByName('VALOR_UNITARIO').AsFloat;
  FClientDataSet.Edit;
  AtualizaEdicaoCampos;
end;

procedure TFrProduto.edtID_PRODUTOExit(Sender: TObject);
begin
  if edtID_PRODUTO.Value > 0 then
  begin
    if Assigned(Self.FProduto) and (Self.FProduto.ID_PRODUTO = edtID_PRODUTO.Value) then
      Exit;

    edtDescricaoProduto.Clear;
    Self.FProduto := TProduto.GetProduto(edtID_PRODUTO.AsInteger);
    if not Assigned(Self.FProduto) then
    begin
      LimparCampos(Self);
      MensagemAtencao('Produto informado não cadastrado!');
      edtID_PRODUTO.SetFocus;
      Abort;
    end;
    edtDescricaoProduto.Text := Self.Produto.Descricao;
    edtVALOR_UNITARIO.Value := Self.Produto.Preco;
  end
  else
   LimparCampos(Self);

end;

procedure TFrProduto.SetClient(pClientDataSet: TClientDataSet);
begin
  Self.FClientDataSet := pClientDataSet;
end;

procedure TFrProduto.SetLabelBotao(pCaption: string);
begin
  Self.btnConfirmar.Caption := pCaption;
end;

end.
