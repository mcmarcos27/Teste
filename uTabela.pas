unit uTabela;

interface
 uses Windows,Classes, Messages,SysUtils, System.TypInfo,
    DB, ADODB, Variants, StrUtils,   FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt;
type
  TCampos = record
    nome: string;
    valor: Variant;
  end;

  TArrayCampos = array of TCampos;

  TTabela = class (TPersistent)
  private
    campos: TArrayCampos;
    chaves: TArrayCampos;
    FTabela: String;
    procedure SetParametro(ParamByName: string; valor: Variant);
    procedure IniciarQuery;
    function CarregarCampos: TFDQuery;
    procedure FecharConsulta;
  protected
    qry: TFDQuery;
    procedure SetValor(campo: string; valor: Variant);
    procedure SetChave(campo: string; valor: Variant);
    function GetProximoIncremento: Integer;
  public
    constructor Create(nome_tabela: string);
    function Inserir: Boolean; virtual;
    procedure Update; virtual;
    procedure Excluir; virtual;
    property NomeTabela:string read FTabela;
end;

implementation

{ TTabela }

uses uDmConexao;

function TTabela.CarregarCampos: TFDQuery;
var
  i: Integer;
begin
  Result := TFDQuery.Create(nil) ;
  Result.Connection := dmConexao.fdConexao;
  Result.SQL.Add('select * from '+FTabela);
  for i := Low(chaves) to High(chaves) do begin
    if i = 0 then
      Result.SQL.Add('where '+chaves[i].nome+' = :'+chaves[i].nome)
    else
      Result.SQL.Add('and '+chaves[i].nome+' = :'+chaves[i].nome);
  end;
  for i := Low(chaves) to High(chaves) do
    Result.ParamByName(chaves[i].nome).Value := chaves[i].valor;
  Result.Open;
end;

constructor TTabela.Create(nome_tabela: string);
begin
  Self.FTabela := nome_tabela;
  Self.campos := nil;
  Self.chaves := nil;
  Self.IniciarQuery;
end;

procedure TTabela.Excluir;
var
  comando: TStrings;
  i: Integer;
begin
  if Length(chaves) = 0 then
    Exit;
  try
    comando := TStringList.Create;
    Self.IniciarQuery;
    comando.Add('delete from '+FTabela);
    for i := Low(self.chaves) to High(self.chaves) do begin
      if i = 0 then
        comando.Add('where '+chaves[i].nome+' = :'+chaves[i].nome)
      else
        comando.Add('and '+chaves[i].nome+' = :'+chaves[i].nome);
    end;
    qry.SQL.AddStrings(comando);
    for i := Low(chaves) to High(chaves) do
      SetParametro(chaves[i].nome, chaves[i].valor);
    qry.ExecSQL;
  finally
    qry.Close;
    comando.Clear;
    FreeAndNil(comando);
  end;

end;

procedure TTabela.FecharConsulta;
begin
  Self.qry.Close;
  FreeAndNil(qry);
  FreeMemory(qry);
end;

function TTabela.GetProximoIncremento: Integer;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil) ;
    qry.Connection := dmConexao.fdConexao;
    qry.SQL.Add('SELECT AUTO_INCREMENT ID');
    qry.SQL.Add('FROM information_schema.tables');
    qry.SQL.Add('WHERE TABLE_NAME=:TABELA');
    qry.ParamByName('TABELA').AsString := Self.FTabela;
    qry.Open();
    Result := qry.FieldByName('ID').AsInteger;
  finally
    qry.Close;
    FreeAndNil(qry);
  end;


end;

procedure TTabela.IniciarQuery;
begin
  if qry = nil then
    qry := TFDQuery.Create(nil);
  qry.Connection := dmConexao.fdConexao;
  qry.Close;
  qry.SQL.Clear;
end;

function TTabela.Inserir: Boolean;
var
  i: Integer;
  comando: string;
  parametros: string;
begin
  if (Length(campos) = 0)  and (Length(chaves) = 0) then
    Exit;
  try
    Self.IniciarQuery;
    for i := Low(chaves) to High(chaves) do begin
      comando := comando + chaves[i].nome + ', ';
      parametros := parametros + ':' + chaves[i].nome + ', ';
    end;

    for i := Low(campos) to High(campos) do begin
      if (campos[i].valor = Null) or (VarToWideStrDef(Trim(campos[i].valor),'') = '') then
        Continue;

      comando := comando + campos[i].nome + ', ';
      parametros := parametros + ':' + campos[i].nome + ', ';
    end;
    comando := Copy(comando, 1, Length(comando) - 2);
    parametros := Copy(parametros, 1, Length(parametros) - 2);

    comando := 'INSERT INTO ' + FTabela + '(' + comando + ')' + #13
    +' VALUES (' + parametros + ')';


    Self.qry.SQL.Text := comando;

    for i := Low(chaves) to High(chaves) do
      Self.SetParametro(chaves[i].nome, chaves[i].valor);

    for i := Low(campos) to High(campos) do
      Self.SetParametro(campos[i].nome, campos[i].valor);
    Self.qry.ExecSql;
    Result := True;
  finally
    Self.FecharConsulta;
  end;

end;

procedure TTabela.SetChave(campo: string; valor: Variant);
var
  i: Integer;
begin
  for i := Low(chaves) to High(chaves) do
    if chaves[i].nome = campo then begin
      chaves[i].valor := valor;
      Exit;
    end;
  SetLength(chaves, Length(chaves) + 1);
  chaves[High(chaves)].nome := campo;
  chaves[High(chaves)].valor := valor;
end;

procedure TTabela.SetParametro(ParamByName: string; valor: Variant);
begin
  qry.Params.ParamByName(ParamByName).Value := valor;
  if qry.ParamByName(ParamByName).DataType in [ftWideString, ftString] then
    qry.ParamByName(ParamByName).Value := Trim(valor);

  if (qry.ParamByName(ParamByName).DataType = ftUnknown) or
   (Trim(VarToWideStrDef(qry.ParamByName(ParamByName).Value, '')) = '') then begin
      if (qry.ParamByName(ParamByName).DataType = ftUnknown) then
        qry.ParamByName(ParamByName).DataType := ftWideString;
      qry.ParamByName(ParamByName).Value := Null;
   end;
end;

procedure TTabela.SetValor(campo: string; valor: Variant);
var
  i: Integer;
begin
  for i := Low(campos) to High(campos) do
  begin
    if campos[i].nome = campo then
    begin
      campos[i].valor := valor;
      Exit;
    end;
  end;
  SetLength(campos, Length(campos) + 1);
  campos[High(campos)].nome := campo;
  campos[High(campos)].valor := valor;
end;

procedure TTabela.Update;
var
  i: Integer;
  comando: TStrings;
  qrCampos: TFDQuery;
begin
  if (Length(campos) = 0)  or (Length(chaves) = 0) then
    Exit;
  qrCampos := CarregarCampos;
  if qrCampos.IsEmpty then
    Exit;
  try
    for i := Low(campos) to High(campos) do
      if qrCampos.Fields.FindField(campos[i].nome) <> nil then
        if qrCampos.FieldByName(campos[i].nome).Value = campos[i].valor then
          Delete(campos, i,1);

    comando := TStringList.Create;
    Self.IniciarQuery;
    comando.Add('UPDATE ' + FTabela);
    comando.Add('SET');
    for i := Low(campos) to High(campos) do
      comando.Add(campos[i].nome + ' = :' + campos[i].nome + IfThen(i < High(campos), ','));

    for i := Low(chaves) to High(chaves) do begin
      if i = 0 then
        comando.Add('where '+chaves[i].nome+' = :'+chaves[i].nome)
      else
        comando.Add('and '+chaves[i].nome+' = :'+chaves[i].nome);
    end;


    qry.SQL.AddStrings(comando);
    for i := Low(campos) to High(campos) do
      SetParametro(campos[i].nome, campos[i].valor);

    for i := Low(chaves) to High(chaves) do
      SetParametro(chaves[i].nome, chaves[i].valor);

    qry.ExecSQL;
  finally
    Self.FecharConsulta;
    FreeAndNil(comando);
  end;

end;

end.
