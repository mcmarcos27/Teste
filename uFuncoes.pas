unit uFuncoes;

interface
uses Forms, Windows, Datasnap.DBClient, Db, SysUtils, Vcl.Controls,Classes,
  Vcl.StdCtrls;

procedure MensagemInformar(Mensagem: string);
procedure MensagemAtencao(Mensagem: string);
procedure MensagemErro(Mensagem: string);
function MensagemQuestionar(Mensagem: string):Boolean;
function ProximoSequencia(pClient:TCustomClientDataSet; pField:TField): integer;
procedure IniciarClientDataSet(pClientDataSet: TClientDataSet);
procedure LimparCampos(pComponent:TComponent);

implementation

procedure MensagemInformar(Mensagem: string);
begin
  Application.MessageBox(PChar(Mensagem),'Informação',MB_ICONINFORMATION+MB_OK);
end;

procedure MensagemAtencao(Mensagem: string);
begin
  Application.MessageBox(PChar(Mensagem),'Atenção',MB_ICONWARNING+MB_OK);
end;

procedure MensagemErro(Mensagem: string);
begin
  Application.MessageBox(PChar(Mensagem),'Erro',MB_ICONERROR+MB_OK);
end;

function ProximoSequencia(pClient:TCustomClientDataSet; pField:TField): integer;
var
  lclient: TClientDataSet;
  lultimoValor: Integer;
begin
  try
    lclient := TClientDataSet.Create(nil);
    lclient.CloneCursor(pClient,False);
    lclient.IndexFieldNames := pField.FieldName;
    lclient.Last;
    Result := lclient.FieldByName(pField.FieldName).AsInteger+1;
  finally
    FreeAndNil(lclient);
  end;
end;
procedure IniciarClientDataSet(pClientDataSet: TClientDataSet);
begin
  if pClientDataSet.Active then
  begin
    pClientDataSet.EmptyDataSet;
    pClientDataSet.Close;
  end;

  pClientDataSet.CreateDataSet;
end;
function MensagemQuestionar(Mensagem: string):Boolean;
begin
  Result := Application.MessageBox(PChar(Mensagem),'Pergunta', MB_YESNO+MB_ICONQUESTION) = mrYes;
end;

procedure LimparCampos(pComponent:TComponent);
var
  i: Integer;
begin
   for i := 0 to pComponent.ComponentCount -1 do
   begin
     if pComponent.Components[i] is TCustomEdit then
     begin
       TCustomEdit(pComponent.Components[i]).clear;
     end;
     if pComponent.Components[i].ComponentCount > 0 then
     begin
        LimparCampos(pComponent.Components[i]);
     end;
   end;
end;
end.
