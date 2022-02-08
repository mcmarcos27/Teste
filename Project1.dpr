program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {FrmPedidos},
  uDmConexao in 'uDmConexao.pas' {dmConexao: TDataModule},
  ufrProduto in 'ufrProduto.pas' {FrProduto: TFrame},
  uFuncoes in 'uFuncoes.pas',
  uFrCliente in 'uFrCliente.pas' {FrCliente: TFrame},
  uCliente in 'Classes\uCliente.pas',
  uProduto in 'Classes\uProduto.pas',
  uPedido in 'Classes\uPedido.pas',
  uTabela in 'uTabela.pas',
  ufrmPesquisar in 'ufrmPesquisar.pas' {FrmPesquisar};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TFrmPedidos, FrmPedidos);
  Application.Run;
end.
