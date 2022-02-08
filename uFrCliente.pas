unit uFrCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untEdits, Vcl.StdCtrls,
  Vcl.Buttons, uCliente;

type


  TFrCliente = class(TFrame)
    edtNOME: TEdit;
    edtID_CLIENTE: TEditNumber;
    Label1: TLabel;
    procedure edtID_CLIENTEExit(Sender: TObject);
  private
    FCliente: TCliente;
    procedure SetCliente(const Value: TCliente);
    { Private declarations }
  public
    property Cliente:TCliente read FCliente write SetCliente;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uDmConexao, uFuncoes;

{ TCliente }



procedure TFrCliente.edtID_CLIENTEExit(Sender: TObject);
begin
  if edtID_CLIENTE.Value > 0 then
  begin
    if Assigned(Self.FCliente) and (Self.FCliente.Codigo = edtID_CLIENTE.Value) then
      Exit;

    edtNOME.Clear;
    Self.FCliente := TCliente.GetCliente(edtID_CLIENTE.AsInteger);
    if not Assigned(Self.FCliente) then
    begin
      MensagemAtencao('Cliente informado não cadastrado!');
      edtID_CLIENTE.SetFocus;
      Abort;
    end;
    edtNOME.Text := Self.Cliente.Nome;
  end
  else
     edtNOME.Clear;

end;

procedure TFrCliente.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
  if Assigned(FCliente) then
  begin
    Self.edtID_CLIENTE.Value :=  FCliente.Codigo;
    Self.edtNOME.Text :=  FCliente.Nome;
  end;
end;

end.

