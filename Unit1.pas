unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, ufrProduto, untEdits, uFrCliente, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, uPedido, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TFrmPedidos = class(TForm)
    pnlBotoes: TPanel;
    Panel2: TPanel;
    grdProdutos: TDBGrid;
    cdsItensPedido: TClientDataSet;
    cdsItensPedidoNUMERO_PED: TIntegerField;
    cdsItensPedidoID_PRODUTO: TIntegerField;
    cdsItensPedidoQUANTIDADE: TFloatField;
    cdsItensPedidoVALOR_UNITARIO: TFloatField;
    cdsItensPedidoVLTOTAL: TFloatField;
    FrProduto1: TFrProduto;
    Label1: TLabel;
    edtCodigo: TEditNumber;
    dsItensPedido: TDataSource;
    cdsItensPedidoDESCRICAO: TStringField;
    cdsItensPedidoID_ITEM: TIntegerField;
    sbGravar: TSpeedButton;
    sbCancelar: TSpeedButton;
    sbFechar: TSpeedButton;
    FrCliente1: TFrCliente;
    lbTotalPedido: TLabel;
    btnPesquisar: TSpeedButton;
    sbExcluir: TSpeedButton;
    procedure cdsItensPedidoNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FrProduto1btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsItensPedidoAfterPost(DataSet: TDataSet);
    procedure cdsItensPedidoAfterDelete(DataSet: TDataSet);
    procedure edtCodigoExit(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure sbFecharClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    FPedido: TPedido;
    procedure AtualizarTotalPedido;
    property Pedido: TPedido read FPedido;
    procedure HabilitarCodigo(phabilitar: boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPedidos: TFrmPedidos;

implementation

{$R *.dfm}

uses uFuncoes, uDmConexao, ufrmPesquisar;



procedure TFrmPedidos.AtualizarTotalPedido;
var
  lcds: TClientDataSet;
  ltotal:Double;
begin
  try
    lcds := TClientDataSet.Create(nil);
    lcds.CloneCursor(cdsItensPedido,False, False);
    ltotal := 0;
    lcds.First;
    while not lcds.Eof do
    begin
      ltotal := ltotal + lcds.FieldByName('VLTOTAL').AsFloat;
      lcds.Next;
    end;
    lbTotalPedido.Caption := 'Total do pedido R$ '+FormatFloat(',##0.00',ltotal);
    lbTotalPedido.Caption := lbTotalPedido.Caption+'          Quantidade de Itens :'+FormatFloat(',##0',lcds.RecordCount);
  finally
    FreeAndNil(lcds);
  end;

end;

procedure TFrmPedidos.btnPesquisarClick(Sender: TObject);
var
   lPedido: TPedido;
begin
  lPedido := PesquisarPedido;
  if Assigned(lPedido) then
  begin
    edtCodigo.AsInteger := lPedido.NUMERO_PED;
    edtCodigoExit(edtCodigo);
  end;
end;

procedure TFrmPedidos.cdsItensPedidoAfterDelete(DataSet: TDataSet);
begin
  AtualizarTotalPedido;
end;

procedure TFrmPedidos.cdsItensPedidoAfterPost(DataSet: TDataSet);
begin
  AtualizarTotalPedido;
end;

procedure TFrmPedidos.cdsItensPedidoNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID_ITEM').AsInteger := ProximoSequencia(cdsItensPedido,cdsItensPedidoID_ITEM);
  if Assigned(FPedido) then
  begin
    DataSet.FieldByName('NUMERO_PED').AsInteger := FPedido.NUMERO_PED;
  end
  else
   DataSet.FieldByName('NUMERO_PED').AsInteger := 1;
end;

procedure TFrmPedidos.edtCodigoExit(Sender: TObject);
var
  i: Integer;
begin
  IniciarClientDataSet(cdsItensPedido);
  if edtCodigo.AsInteger <= 0 then
  begin
    if MensagemQuestionar('Incluir novo pedido') then
    begin
      Self.FPedido := nil;
      HabilitarCodigo(False);
      Exit;
    end;
  end;
  Self.FPedido := TPedido.GetPedido(edtCodigo.AsInteger);
  if not Assigned(self.FPedido)   then
  begin
    MensagemInformar('Número de pedido informado não cadastrado!');
    Abort;
  end;
  HabilitarCodigo(False);
  FrCliente1.Cliente := Self.FPedido.CLIENTE;
  for i := Low(Self.FPedido.ITENS) to High(Self.FPedido.ITENS) do
  begin
    cdsItensPedido.Append;
    cdsItensPedido.FieldByName('VALOR_UNITARIO').AsFloat := Self.FPedido.ITENS[i].VALOR_UNITARIO;
    cdsItensPedido.FieldByName('DESCRICAO').AsString := Self.FPedido.ITENS[i].PRODUTO.Descricao;
    cdsItensPedido.FieldByName('QUANTIDADE').AsFloat := Self.FPedido.ITENS[i].QUANTIDADE;
    cdsItensPedido.FieldByName('ID_PRODUTO').AsFloat := Self.FPedido.ITENS[i].PRODUTO.ID_PRODUTO;
    cdsItensPedido.FieldByName('VLTOTAL').AsFloat := Self.FPedido.ITENS[i].VLTOTAL;
    cdsItensPedido.Post;
  end;
end;

procedure TFrmPedidos.grdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try
  if Key = VK_DELETE then
  begin
    if MensagemQuestionar('Confirmar a exclusão do produto'+sLineBreak+
      cdsItensPedidoID_PRODUTO.AsString+'-'+cdsItensPedidoDESCRICAO.AsString+sLineBreak+
      'Valor R$:' +FormatFloat(',##0.00',cdsItensPedidoVALOR_UNITARIO.AsFloat)
    ) then
      cdsItensPedido.Delete;
  end;

  if Key = VK_RETURN then
  begin
     FrProduto1.EditarProduto;
  end;
  finally
    grdProdutos.Enabled := not(cdsItensPedido.State in [dsEdit,dsInsert]);
  end;

end;

procedure TFrmPedidos.HabilitarCodigo(phabilitar: boolean);
begin
  edtCodigo.Enabled := phabilitar;
  btnPesquisar.Enabled := phabilitar;
  sbGravar.Enabled := not edtCodigo.Enabled;
  sbCancelar.Enabled := sbGravar.Enabled;
  sbExcluir.Enabled := not edtCodigo.Enabled and Assigned(FPedido);
  AtualizarTotalPedido;
end;



procedure TFrmPedidos.sbCancelarClick(Sender: TObject);
begin
  HabilitarCodigo(True);
  edtCodigo.SetFocus;
  LimparCampos(Self);
  IniciarClientDataSet(cdsItensPedido);
end;

procedure TFrmPedidos.sbExcluirClick(Sender: TObject);
begin
  if edtCodigo.AsInteger <= 0  then
  begin
    MensagemAtencao('Informe o número do pedido a ser excluído');
  end;

  edtCodigoExit(edtCodigo);
  if Assigned(FPedido) then
  begin
    if MensagemQuestionar('Excluir o pedido Nº '+IntToStr(FPedido.NUMERO_PED)) then
      FPedido.Excluir;
  end;
  HabilitarCodigo(True);
  edtCodigo.SetFocus;
  LimparCampos(Self);
  IniciarClientDataSet(cdsItensPedido);
end;

procedure TFrmPedidos.sbFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPedidos.sbGravarClick(Sender: TObject);
begin
  try
    if Assigned(Self.FPedido) then
    begin
      Self.FPedido.Update;
      MensagemInformar('Pedido gravado com sucesso! nº: '+ IntToStr(FPedido.NUMERO_PED));
      Self.edtCodigoExit(edtCodigo);
    end
    else
    begin
      Self.FPedido := TPedido.Add(
      edtCodigo.AsInteger,
      FrCliente1.Cliente,
      0,
      TItensPedido.AddClient(cdsItensPedido));
      if Self.FPedido.Inserir then
      begin
         MensagemInformar('Pedido gravado com sucesso! nº: '+ IntToStr(FPedido.NUMERO_PED));
      end;
    end;
  finally
    HabilitarCodigo(True);
  end;
end;

procedure TFrmPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Self.SelectNext(ActiveControl,True,True);
  end;
end;

procedure TFrmPedidos.FormShow(Sender: TObject);
begin
  FrProduto1.SetClient(cdsItensPedido);
  IniciarClientDataSet(cdsItensPedido);
end;

procedure TFrmPedidos.FrProduto1btnConfirmarClick(Sender: TObject);
begin
  FrProduto1.btnConfirmarClick(Sender);
  grdProdutos.Enabled := not(cdsItensPedido.State in [dsEdit,dsInsert]);
end;

end.
