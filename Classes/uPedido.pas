unit uPedido;

interface

uses SysUtils, Classes, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, uCliente, uProduto,
  uTabela,Datasnap.DBClient, System.TypInfo, Variants;

type
  TItensPedido =class;
  TListaItensPedido = array of TItensPedido;

  TPedido = class;
  TListaPedidos = array of TPedido;
  TPedido = class(TTabela)
  private
    FCLIENTE: TCliente;
    fNUMERO_PED: Integer;
    FDTEMISSAO: TDateTime;
    FVLTOTAL: Double;
    FITENS: TListaItensPedido;
    procedure SetCLIENTE(const Value: TCliente);
    procedure SetDTEMISSAO(const Value: TDateTime);
    procedure SetNUMERO_PED(const Value: Integer);
    procedure SetVLTOTAL(const Value: Double);
    procedure SetITENS(const Value: TListaItensPedido);
  public
    constructor Create;
    function Inserir: Boolean; override;
    procedure Excluir; override;
    procedure Update; override;
    class function GetPedidos(pFiltros: TStrings=nil; pCarregarItens: Boolean=True): TListaPedidos;
    class function GetPedido(pNumero_Ped: integer): TPedido;
    class function Add(
      pNUMERO_PED: Integer;
      pCLIENTE: TCliente;
      pVLTOTAL: Double;
      pITENS:TListaItensPedido
    ):TPedido;
    property NUMERO_PED: Integer read fNUMERO_PED write SetNUMERO_PED;
    property DTEMISSAO: TDateTime read FDTEMISSAO write SetDTEMISSAO;
    property CLIENTE: TCliente read FCLIENTE write SetCLIENTE;
    property VLTOTAL: Double read FVLTOTAL write SetVLTOTAL;
    property ITENS:TListaItensPedido read FITENS write SetITENS;
  end;

  TItensPedido = class(TTabela)
  private
    FPRODUTO: TProduto;
    FVLTOTAL: Double;
    FQUANTIDADE: Double;
    fID_ITEM: Integer;
    FNUMERO_PED: Integer;
    FVALOR_UNITARIO: Double;
    FDataSetState: TDataSetState;
    procedure SetID_ITEM(const Value: Integer);
    procedure SetNUMERO_PED(const Value: Integer);
    procedure SetPRODUTO(const Value: TProduto);
    procedure SetQUANTIDADE(const Value: Double);
    procedure SetVALOR_UNITARIO(const Value: Double);
    procedure SetVLTOTAL(const Value: Double);
    procedure AtualizaVLTotal;
  public
    constructor Create;
    function Inserir: Boolean; override;
    class function GetItensPedidos(pFiltros: TStrings=nil): TListaItensPedido; overload;
    class function GetItensPedidos(pNUMERO_PED:Integer): TListaItensPedido; overload;
    class function GetItenPedido(pID_ITEM: integer): TItensPedido;
    class function AddClient(pClient: TClientDataSet): TListaItensPedido;
  published
    property ID_ITEM: Integer read fID_ITEM write SetID_ITEM;
    property NUMERO_PED: Integer read FNUMERO_PED write SetNUMERO_PED;
    property PRODUTO: TProduto read FPRODUTO write SetPRODUTO;
    property QUANTIDADE: Double read FQUANTIDADE write SetQUANTIDADE;
    property VALOR_UNITARIO:Double read FVALOR_UNITARIO write SetVALOR_UNITARIO;
    property VLTOTAL:Double read FVLTOTAL write SetVLTOTAL;
  end;


implementation



{ TPedido }

uses uDmConexao ;

class function TPedido.GetPedidos(pFiltros: TStrings; pCarregarItens: Boolean): TListaPedidos;
var
  lqry: TFDQuery;
begin
  try
    Result := nil;
    lqry := TFDQuery.Create(nil);
    lqry.Connection := dmConexao.fdConexao;
    lqry.SQL.Add('SELECT NUMERO_PED, DTEMISSAO,ID_CLIENTE,VLTOTAL');
    lqry.SQL.Add('FROM PEDIDOS ');
    lqry.SQL.Add('WHERE 1=1');
    if Assigned(pFiltros) then
      lqry.SQL.AddStrings(pFiltros);
    lqry.Open();
    if not lqry.IsEmpty then
    begin
      lqry.First;
      while not lqry.Eof do
      begin
        SetLength(Result , Length(Result)+1);
        Result[High(Result)] := TPedido.Create;
        Result[High(Result)].NUMERO_PED := lqry.FieldByName('NUMERO_PED').AsInteger;
        Result[High(Result)].FDTEMISSAO := lqry.FieldByName('DTEMISSAO').AsDateTime;
        Result[High(Result)].FVLTOTAL := lqry.FieldByName('VLTOTAL').AsFloat;
        Result[High(Result)].FCLIENTE := TCliente.GetCliente(lqry.FieldByName('ID_CLIENTE').AsInteger);
        if pCarregarItens then
          Result[High(Result)].SetITENS(TItensPedido.GetItensPedidos(lqry.FieldByName('NUMERO_PED').AsInteger));
        lqry.Next;
      end;
    end;
  finally
    lqry.Close;
    FreeAndNil(lqry);
  end;
end;

function TPedido.Inserir: Boolean;
var
  i: Integer;
  lNUMERO_PED: Integer;
begin
  Self.SetNUMERO_PED(Self.GetProximoIncremento);
  inherited;
  for i := Low(Self.ITENS) to High(Self.ITENS) do
  begin
    Self.ITENS[i].SetNUMERO_PED(Self.NUMERO_PED);
    Result := Self.ITENS[i].Inserir;
  end;
end;

class function TPedido.Add(pNUMERO_PED: Integer; pCLIENTE: TCliente;
  pVLTOTAL: Double; pITENS: TListaItensPedido):TPedido;
begin
  Result := TPedido.Create;
  Result.SetNUMERO_PED(pNUMERO_PED);
  Result.SetCLIENTE(pCLIENTE);
  Result.SetVLTOTAL(pVLTOTAL);
  Result.SetITENS(pITENS);
  Result.SetDTEMISSAO(Trunc(Now));
end;

constructor TPedido.Create;
begin
  inherited Create('PEDIDOS');
end;

procedure TPedido.Excluir;
var
  I: Integer;
begin
  for I := Low(Self.ITENS) to High(Self.ITENS) do
  begin
    Self.ITENS[i].Excluir;
  end;
  inherited;
end;

class function TPedido.GetPedido(pNumero_Ped: integer): TPedido;
var
  lFiltro: TStrings;
  lPedidos: TListaPedidos;
begin
  try
    Result := nil;
    lFiltro := TStringList.Create;
    lFiltro.Add('AND NUMERO_PED = '+IntToStr(pNumero_Ped));
    lPedidos := TPedido.GetPedidos(lFiltro);
    if Assigned(lPedidos) then
      Result := lPedidos[0];
  finally
    FreeAndNil(lFiltro);
  end;
end;

procedure TPedido.SetCLIENTE(const Value: TCliente);
begin
  FCLIENTE := Value;
  SetValor('ID_CLIENTE',Value.Codigo);
end;

procedure TPedido.SetDTEMISSAO(const Value: TDateTime);
begin
  if Self.FDTEMISSAO <> Value then
  begin
    Self.FDTEMISSAO := Value;
    if Value > 1 then
      Self.SetValor('DTEMISSAO', Value)
    else
      Self.SetValor('DTEMISSAO', Null);
  end;
end;

procedure TPedido.SetITENS(const Value: TListaItensPedido);
begin
  FITENS := Value;
end;

procedure TPedido.SetNUMERO_PED(const Value: Integer);
begin
  FNUMERO_PED := Value;
  SetChave('NUMERO_PED',Value);
end;

procedure TPedido.SetVLTOTAL(const Value: Double);
begin
  if Self.FVLTOTAL <> Value then begin
    Self.FVLTOTAL := Value;
    if Value > 0 then
      Self.SetValor('VLTOTAL', Value)
    else
      Self.SetValor('VLTOTAL', Null);
  end;
end;

procedure TPedido.Update;
var
  I: Integer;
begin
  inherited;
  for I := Low(Self.ITENS) to High(Self.ITENS) do
  begin
    if Self.ITENS[i].FDataSetState = dsEdit then
      Self.ITENS[i].Update
    else
    begin
      Self.ITENS[i].SetNUMERO_PED(Self.NUMERO_PED);
      Self.ITENS[i].Inserir;
    end;
  end;

end;

{ TItensPedido }

class function TItensPedido.AddClient(pClient: TClientDataSet): TListaItensPedido;
var
  I: Integer;
  lProp:PPropInfo;
begin
  Result := nil;
  pClient.First;
  while not pClient.Eof do
  begin
    SetLength(Result, Length(Result)+1);
    Result[High(Result)] := TItensPedido.Create;
    for I := 0 to pClient.Fields.Count -1 do
    begin
      lProp := GetPropInfo(Result[High(Result)],pClient.Fields[i].FieldName);
      if Assigned(lProp) then
      begin
        SetPropValue(Result[High(Result)],pClient.Fields[i].FieldName, pClient.Fields[i].Value);
      end;
    end;
    if Assigned(pClient.FindField('ID_PRODUTO')) then
    begin
      Result[High(Result)].SetPRODUTO(TProduto.GetProduto(pClient.FindField('ID_PRODUTO').AsInteger));
    end;
    pClient.Next;
  end;
end;

procedure TItensPedido.AtualizaVLTotal;
begin
  SetVLTOTAL(SELF.QUANTIDADE*Self.VALOR_UNITARIO);
end;

constructor TItensPedido.Create;
begin
  inherited Create('ITENSPEDIDO');
  FDataSetState := dsInsert;
end;

class function TItensPedido.GetItenPedido(pID_ITEM: integer): TItensPedido;
var
  lFiltro: TStrings;
  lItens: TListaItensPedido;
begin
  try
    Result := nil;
    lFiltro := TStringList.Create;
    lFiltro.Add('AND ID_ITEM = '+IntToStr(pID_ITEM));
    lItens := TItensPedido.GetItensPedidos(lFiltro);
    if Assigned(lItens) then
      Result := lItens[0];
  finally
    FreeAndNil(lFiltro);
  end;

end;

class function TItensPedido.GetItensPedidos(pFiltros: TStrings): TListaItensPedido;
var
  lqry: TFDQuery;
begin
  try
    Result := nil;
    lqry := TFDQuery.Create(nil);
    lqry.Connection := dmConexao.fdConexao;
    lqry.SQL.Add('SELECT ID_ITEM, NUMERO_PED, ID_PRODUTO,QUANTIDADE, VALOR_UNITARIO, VLTOTAL');
    lqry.SQL.Add('FROM ITENSPEDIDO');
    lqry.SQL.Add('WHERE 1=1');
    if Assigned(pFiltros) then
      lqry.SQL.AddStrings(pFiltros);
    lqry.Open();
    if not lqry.IsEmpty then
    begin
      lqry.First;
      while not lqry.Eof do
      begin
        SetLength(Result , Length(Result)+1);
        Result[High(Result)] := TItensPedido.Create;
        Result[High(Result)].ID_ITEM  := lqry.FieldByName('ID_ITEM').AsInteger;
        Result[High(Result)].FNUMERO_PED := lqry.FieldByName('NUMERO_PED').AsInteger;
        Result[High(Result)].FPRODUTO := TProduto.GetProduto(lqry.FieldByName('ID_PRODUTO').AsInteger);
        Result[High(Result)].FQUANTIDADE  := lqry.FieldByName('QUANTIDADE').AsFloat;
        Result[High(Result)].FVALOR_UNITARIO  := lqry.FieldByName('VALOR_UNITARIO').AsFloat;
        Result[High(Result)].FVLTOTAL := lqry.FieldByName('VLTOTAL').AsFloat;
        Result[High(Result)].FDataSetState := dsEdit;
        lqry.Next;
      end;
    end;
  finally
    lqry.Close;
    FreeAndNil(lqry);
  end;

end;

class function TItensPedido.GetItensPedidos(pNUMERO_PED: Integer): TListaItensPedido;
var
  lFiltro: TStrings;
begin
  try
    Result := nil;
    lFiltro := TStringList.Create;
    lFiltro.Add('AND NUMERO_PED = '+IntToStr(pNUMERO_PED));
    Result := TItensPedido.GetItensPedidos(lFiltro);
  finally
    FreeAndNil(lFiltro);
  end;
end;

function TItensPedido.Inserir: Boolean;
begin
  Self.SetID_ITEM(Self.GetProximoIncremento);
  inherited;
end;

procedure TItensPedido.SetID_ITEM(const Value: Integer);
begin
  fID_ITEM := Value;
  SetChave('ID_ITEM',Value);
end;

procedure TItensPedido.SetNUMERO_PED(const Value: Integer);
begin
  if Self.FNUMERO_PED <> Value then begin
    Self.FNUMERO_PED := Value;
    if Value > 0 then
      Self.SetValor('NUMERO_PED', Value)
    else
      Self.SetValor('NUMERO_PED', Null);
  end;
end;

procedure TItensPedido.SetPRODUTO(const Value: TProduto);
begin
  FPRODUTO := Value;
  SetValor('ID_PRODUTO',Value.ID_PRODUTO);
end;

procedure TItensPedido.SetQUANTIDADE(const Value: Double);
begin
  if Self.FQUANTIDADE <> Value then begin
    Self.FQUANTIDADE := Value;
    if Value > 0 then
      Self.SetValor('QUANTIDADE', Value)
    else
      Self.SetValor('QUANTIDADE', Null);
  end;
  Self.AtualizaVLTotal;
end;

procedure TItensPedido.SetVALOR_UNITARIO(const Value: Double);
begin
  FVALOR_UNITARIO := Value;
  Self.AtualizaVLTotal;
  SetValor('VALOR_UNITARIO',Value);
end;

procedure TItensPedido.SetVLTOTAL(const Value: Double);
begin
  FVLTOTAL := Value;
  SetValor('VLTOTAL',Value);
end;

initialization
  RegisterClass(TItensPedido)
finalization
  UnRegisterClass(TItensPedido)

end.

