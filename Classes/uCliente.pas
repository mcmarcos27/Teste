unit uCliente;

interface
uses SysUtils, Classes, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt;

type
  TCliente = class;
  TListaClientes = array of TCliente;
  TCliente = class
  private
    FUF: string;
    fCodigo: Integer;
    FNome: string;
    FCidade: string;
    procedure SetCidade(const Value: string);
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetUF(const Value: string);
    class function ConsultarClientes(pFiltros: TStrings=nil): TListaClientes;
    class function ClienteExiste(pCodigo: Integer): Boolean;
  public
    class function GetCliente(pCodigo: integer): TCliente;
    class function GetClientes(pFiltros: TStrings): TListaClientes;
    property Codigo: Integer read fCodigo write SetCodigo;
    property Nome: string read FNome write SetNome;
    property Cidade: string read FCidade write SetCidade;
    property UF: string read FUF write SetUF;
  end;

implementation

{ TCliente }

uses uDmConexao;

class function  TCliente.ConsultarClientes(pFiltros: TStrings): TListaClientes;
var
  lqry: TFDQuery;
begin
  try
    Result := nil;
    lqry := TFDQuery.Create(nil);
    lqry.Connection := dmConexao.fdConexao;
    lqry.SQL.Add('SELECT C.ID_CLIENTE, C.NOME, C.CIDADE, C.UF');
    lqry.SQL.Add('FROM CLIENTES C');
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
        Result[High(Result)] := TCliente.Create;
        Result[High(Result)].SetCodigo(lqry.FieldByName('ID_CLIENTE').AsInteger);
        Result[High(Result)].SetNome(lqry.FieldByName('NOME').AsString);
        Result[High(Result)].SetUF(lqry.FieldByName('UF').AsString);
        Result[High(Result)].SetCidade(lqry.FieldByName('CIDADE').AsString);
        lqry.Next;
      end;
    end;
  finally
    lqry.Close;
    FreeAndNil(lqry);
  end;
end;

class function TCliente.GetCliente(pCodigo: integer): TCliente;
var
  lFiltro: TStrings;
  lCliente: TListaClientes;
begin
  try
    Result := nil;
    lFiltro := TStringList.Create;
    lFiltro.Add('AND C.ID_CLIENTE = '+IntToStr(pCodigo));
    lCliente := TCliente.ConsultarClientes(lFiltro);
    if Assigned(lCliente) then
      Result := lCliente[0];
  finally
    FreeAndNil(lFiltro);
  end;
end;

class function TCliente.GetClientes(pFiltros: TStrings): TListaClientes;
begin
  Result := TCliente.ConsultarClientes(pFiltros);
end;

procedure TCliente.SetCidade(const Value: string);
begin
  FCidade := AnsiUpperCase(Value);
end;

procedure TCliente.SetCodigo(const Value: Integer);
begin
  fCodigo := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := AnsiUpperCase(Value);
end;

procedure TCliente.SetUF(const Value: string);
begin
  FUF := AnsiUpperCase(Value);
end;

class function TCliente.ClienteExiste(pCodigo: Integer): Boolean;
begin
    Result  := Assigned(TCliente.GetCliente(pCodigo));
end;

end.
