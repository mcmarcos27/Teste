unit uProduto;

interface
uses SysUtils, Classes, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,uTabela;

type
  TProduto = class;
  TListaProdutos = array of TProduto;
  TProduto = class(TTabela)
  private
    FID_PRODUTO: Integer;
    FPreco: Double;
    FDescricao: string;
    class function ConsultarProdutos(pFiltros: TStrings=nil): TListaProdutos;
    procedure SetDescricao(const Value: string);
    procedure SetID_PRODUTO(const Value: Integer);
    procedure SetPreco(const Value: Double);
  public

    class function GetProduto(pID_Produto: integer): TProduto;
    class function GetProdutos(pFiltros: TStrings): TListaProdutos;
    property ID_PRODUTO: Integer read FID_PRODUTO write SetID_PRODUTO;
    property Descricao: string read FDescricao write SetDescricao;
    property Preco: Double read FPreco write SetPreco;
  end;

implementation

{ TProduto }

uses uDmConexao;

class function TProduto.ConsultarProdutos(pFiltros: TStrings): TListaProdutos;
var
  lqry: TFDQuery;
begin
  try
    Result := nil;
    lqry := TFDQuery.Create(nil);
    lqry.Connection := dmConexao.fdConexao;
    lqry.SQL.Add('SELECT C.ID_PRODUTO, C.DESCRICAO, C.PRECO');
    lqry.SQL.Add('FROM PRODUTOS C');
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
        Result[High(Result)] := TProduto.Create('PRODUTOS');
        Result[High(Result)].SetID_PRODUTO(lqry.FieldByName('ID_PRODUTO').AsInteger);
        Result[High(Result)].SetDescricao(lqry.FieldByName('DESCRICAO').AsString);
        Result[High(Result)].SetPreco(lqry.FieldByName('PRECO').AsFloat);
        lqry.Next;
      end;
    end;
  finally
    lqry.Close;
    FreeAndNil(lqry);
  end;
end;

class function TProduto.GetProduto(pID_Produto: integer): TProduto;
var
  lFiltro: TStrings;
  lProdutos: TListaProdutos;
begin
  try
    Result := nil;
    lFiltro := TStringList.Create;
    lFiltro.Add('AND C.ID_PRODUTO = '+IntToStr(pID_Produto));
    lProdutos := TProduto.ConsultarProdutos(lFiltro);
    if Assigned(lProdutos) then
      Result := lProdutos[0];
  finally
    FreeAndNil(lFiltro);
  end;

end;

class function TProduto.GetProdutos(pFiltros: TStrings): TListaProdutos;
begin
  Result := TProduto.ConsultarProdutos(pFiltros);
end;


procedure TProduto.SetDescricao(const Value: string);
begin
  FDescricao := AnsiUpperCase(Value);
end;

procedure TProduto.SetID_PRODUTO(const Value: Integer);
begin
  fID_PRODUTO := Value;
  SetChave('ID_PRODUTO', Value);
end;

procedure TProduto.SetPreco(const Value: Double);
begin
  if Value < 0 then
    FPreco := 0
  else
    FPreco := Value;
end;

end.
