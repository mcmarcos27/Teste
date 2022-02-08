unit untEdits;

interface

uses SysUtils, StdCtrls, Mask, Classes,  Controls, Messages, Dialogs, Variants,
  Windows;


type
  TTipoPessoa = (CNPJ, CPF);
  TStyle = (sDefault, sRedonda);
type

  TeditPadrao = class(TCustomEdit)
  private
    fMascara: string;
    fStyle: TStyle;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    function Numeros(value: string): string;
    function Formatar(value: string): string;
    procedure SetStyle(const Value: TStyle);
  public
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
  protected
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    property Mascara: string read fMascara write fMascara;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property NumbersOnly;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property Style : TStyle read fStyle write SetStyle default sDefault;
    property TabOrder;
    property TabStop;
    property TextHint;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;

  end;

  TEditNumber = class(TEditPadrao)
  private
    fDecimais: Integer;
    fMostrarZero: Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure SetDecimais(const Value: Integer);
    procedure SetMostrarZero(const Value: Boolean);
    function GetValue: Variant;
    procedure SetValue(const Value: Variant);
    function FormatarNumero(value: string): string;
    function GetFloat: Double;
    function GetInteger: Integer;
    procedure SetFloat(const Value: Double);
    procedure SetInteger(const Value: Integer);
  protected
  public
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
  published
    property Decimais: Integer read fDecimais write SetDecimais;
    property MostrarZero: Boolean read fMostrarZero write SetMostrarZero;
    property Value: Variant read GetValue write SetValue;
    property AsInteger: Integer read GetInteger write SetInteger;
    property AsFloat: Double read GetFloat write SetFloat;
  end;

  TTipoEdit = (tpEdit, tpTelefone, tpEmail, tpCep, tpData, tpNumerico, tpInteiro, tpMac);

  TEditText = class(TEditPadrao)
  private

    WidthPadrao: Integer;
    fTipoEdit: TTipoEdit;
    procedure SetTipoEdit(Value: TTipoEdit);
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected

  public
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
  published
    property TipoEdit: TTipoEdit read fTipoEdit write SetTipoEdit;
  end;


  TEditCPFCNPJ = class(TeditPadrao)
  private
    FTipoPessoa: TTipoPessoa;
    procedure SetTipoPessoa(const Value: TTipoPessoa);
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    function GetCPF_CNPJ_VALIDO: Boolean;
    function CNPJValido: Boolean;
    function CPFValido: Boolean;
     { private declarations }
  public
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
    function Value: String;
    property CPF_CNPJ_VALIDO: Boolean read GetCPF_CNPJ_VALIDO;
     { public declarations }
  published
    property TipoPessoa: TTipoPessoa read FTipoPessoa write SetTipoPessoa;
  end;

  THComboBox = class(TComboBox)
  private
    fValues: TStrings;
    function GetValorSelecionado: String;
    procedure SetValues(const Value: TStrings);
  public
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    function SetIndexValue(Value: string): Integer;
    property ValorSelecionado: String read GetValorSelecionado;
    procedure AdicionarItem(descricao: string; valor: string);
  published
    property Values: TStrings read fValues write SetValues;

  end;





implementation

{ TEditCPFCNPJ }
procedure TEditCPFCNPJ.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if Self.Value <> '' then
    Self.Text := Formatar(Self.Value);
end;

function TEditCPFCNPJ.CNPJValido: Boolean;
var
  i: Integer;
  multiplicador: Integer;
  numeros: string;
  soma: Integer;
  dv: Integer;
begin

  if Length(Self.Value) <> 14 then begin
    Result := False;
    Exit;
  end;
  numeros := Copy(Self.Value,1,12);
  while Length(numeros) < 14 do begin
    multiplicador := 9;
    soma := 0;
    for i := Length(numeros) downto 1 do begin
      soma := soma + (StrToInt(numeros[i])*multiplicador);
      if multiplicador <= 2 then
        multiplicador := 9
      else
        Dec(multiplicador);
    end;
    dv := (soma - (Trunc(soma/11)*11));
    if dv > 9 then
      dv := 0;
    numeros := numeros + IntToStr(dv);
  end;
  Result := Self.Value = numeros;
end;

function TEditCPFCNPJ.CPFValido: Boolean;
var
  i: Integer;
  soma: Integer;
  multiplicador: Integer;
  numeros: string;
  dv: integer;
begin
  numeros := Self.Value;
  if Length(numeros) <> 11 then begin
    Result := False;
    Exit;
  end;

  numeros := Copy(Self.Value, 1, 9);

  while Length(numeros) < 11 do begin
    multiplicador := 2;
    soma := 0;
    for i := Length(numeros) downto 1 do begin
      soma := soma + (StrToInt(numeros[i]) * multiplicador);
      Inc(multiplicador);
    end;
    dv := 11-((soma) - (Trunc(soma/11)*11));
    if dv > 9 then
      dv := 0;
    numeros := numeros + IntToStr(dv);
  end;
  Result := Self.Value = numeros;
end;

constructor TEditCPFCNPJ.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  TipoPessoa := CNPJ;
end;

destructor TEditCPFCNPJ.Destroy;
begin

   inherited;
end;

function TEditCPFCNPJ.GetCPF_CNPJ_VALIDO: Boolean;
begin
  if Self.Value = '' then begin
    Result := True;
    Exit;
  end;
  if TipoPessoa = CNPJ then
    Result := CNPJValido
  else
    Result := CPFValido;
end;

procedure TEditCPFCNPJ.SetTipoPessoa(const Value: TTipoPessoa);
begin
  FTipoPessoa := Value;

  if FTipoPessoa = CNPJ then
    Self.Mascara := '99.999.999/0000-99'
  else
    Self.Mascara := '999.999.999-00';


  Self.Text := Formatar(Numeros(Self.Text));
end;

function TEditCPFCNPJ.Value: String;
begin
  Result := Numeros(Self.Text);
end;

procedure TEditCPFCNPJ.WMChar(var Message: TWMChar);
var
  i: Integer;
  somente_numeros: string;
begin
  somente_numeros :='';
  if not CharInSet(char(Message.CharCode), ['0'..'9', #08, #13,#3,#$18,#$16]) then
    Exit
  else
    Inherited;
  if Trim(fMascara)<>'' then begin
    for i := 1 to Length(Self.Text) do
      if CharInSet(Self.Text[i], ['0'..'9']) then
        somente_numeros := somente_numeros+Self.Text[i];

      Self.Text := somente_numeros;
      Self.Text := Formatar(Self.Text);
      Self.SetSelStart(Length(Self.Text));
  end;
end;



{ TEditNumber }
procedure TEditNumber.CMExit(var Message: TCMExit);
begin
  inherited;
  if Self.Mascara <> '' then
    Self.Text := FormatFloat(Self.Mascara,StrToFloatDef(StringReplace(Self.Text,'.','',[rfReplaceAll,rfIgnoreCase]),0));
  if not MostrarZero and (Self.Text = '0') then
    Self.Text := '';
end;

constructor TEditNumber.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  Self.Mascara := ',##0';


end;

destructor TEditNumber.Destroy;
begin

   inherited;
end;

function TEditNumber.FormatarNumero(value: string): string;
var
  i: Integer;
  zeros: string;
begin
   if StrToIntDef(value, 0) = 0  then begin
    Result := '0';
    Exit;
   end;
   zeros := '1';
   for i := 1 to Self.Decimais do
    zeros := zeros + '0';

   Result :=  FloatToStr(StrToInt(value) / StrToInt(zeros));
end;

function TEditNumber.GetFloat: Double;
begin
  Result := GetValue;
end;

function TEditNumber.GetInteger: Integer;
begin
  Result := Trunc(GetValue);
end;

function TEditNumber.GetValue: Variant;
begin
  if Decimais > 0 then
    Result := StrToFloatDef(StringReplace(Self.Text,'.','',[rfReplaceAll,rfIgnoreCase]),0)
  else
    Result := StrToIntDef(StringReplace(Self.Text,'.','',[rfReplaceAll,rfIgnoreCase]),0);

end;


procedure TEditNumber.SetDecimais(const Value: Integer);
var
  I: Integer;
begin
  Self.Clear;
  fDecimais := Value;
  fMascara := '';
  if fDecimais > 0 then
    Self.fMascara := ',##0.'
  else
    Self.fMascara := ',##0';

  for I := 1 to fDecimais do begin
    Self.fMascara := Self.fMascara + '0';
  end;
end;

procedure TEditNumber.SetFloat(const Value: Double);
begin
  SetValue(Value);
end;

procedure TEditNumber.SetInteger(const Value: Integer);
begin
  SetValue(Value);
end;

procedure TEditNumber.SetMostrarZero(const Value: Boolean);
begin
  fMostrarZero := Value;
end;

procedure TEditNumber.SetValue(const Value: Variant);
begin
  try
    Self.Text := VarToStrDef(Value, '0');
    Self.Text := FormatFloat(Self.Mascara,StrToFloatDef(StringReplace(Self.Text,'.','',[rfReplaceAll,rfIgnoreCase]),0));
  Except
    Self.Text := '0';
  end;
  if (Self.Text = '0') and not(Self.MostrarZero) then
    Self.Text := '';
end;

procedure TEditNumber.WMChar(var Message: TWMChar);
begin
  if not CharInSet(Char(Message.CharCode), ['0'..'9', #08, #13,#3,#$18,#$16,',']) then
    Exit
//  else if (Length(Trim(copy(Self.Text,Pos(',',Self.Text),Length(Self.Text)))) > Decimais)
//    and (Pos(',',Self.Text) > 0) and CharInSet(Char(Message.CharCode), ['0'..'9',',']) then
//    Exit
  else
    Inherited;
  if ((Char(Message.CharCode) <> ',') or (Decimais = 0)) then
      Self.Text :=  FormatFloat(Self.Mascara,StrToFloatDef(Self.FormatarNumero(self.Numeros(Self.Text)),0));
  if not (MostrarZero) and (Self.Value = 0) then
    Self.Text := '';

  Self.SetSelStart(Length(Self.Text));

end;

{ TEditTextNumber }

procedure TEditText.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if TipoEdit in [tpTelefone, tpCep, tpData] then begin
    if Self.Text <> '' then
      Self.Text := Formatar(Self.Numeros(Self.Text));
      if Length(Self.Text) > 9 then begin
        try
          if TipoEdit = tpData then
            StrToDate(Self.Text)
        except
          Self.Text := '';
        end;
      end;

  end;
end;

constructor TEditText.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  WidthPadrao := -1;


end;

destructor TEditText.Destroy;
begin

  inherited;
end;

procedure TEditText.SetTipoEdit(Value: TTipoEdit);
begin
//  if (AutoSize) and (WidthPadrao = -1)  then
//    WidthPadrao := Self.Width;


  fTipoEdit := Value;
  case fTipoEdit of
    tpTelefone: begin
      Self.Mascara := '(99)9999-99999';
//      if Self.AutoSize then
//        Self.Width := 90;
    end;
    tpCep: begin
      Self.Mascara := '99.999-999';
//      if Self.AutoSize then
//        Self.Width := 80;
    end;
    tpData: begin
      Self.Mascara := '99/99/9999';
//      if Self.AutoSize then
//        Self.Width := 80;
    end;
    tpInteiro: begin
      Self.Mascara := '';
      if Self.AutoSize then
//        Self.Width := 80;
    end;
    tpMac: begin
      Self.Mascara := '99:99:99:99:99:99';
    end
    else begin
      Self.Mascara := '';
//      if Self.AutoSize then
//        Self.Width := WidthPadrao;
    end;
  end;
end;

procedure TEditText.WMChar(var Message: TWMChar);
  function SomenteNumeros(valor: string): string;
  var i: Integer;
  begin
    Result := '';
    for i := 1 to Length(valor) do
        if CharInSet(valor[i], ['0'..'9']) then
          Result := Result+valor[i];
  end;
var
  posicao_mascara,i: integer;
  Retorno: string;
begin
  if TipoEdit in [tpTelefone, tpCep, tpData, tpNumerico, tpInteiro] then begin
    if not CharInSet(char(Message.CharCode), ['0'..'9', #08, #13,#3,#$18,#$16]) then
      Exit
    else
      Inherited;
    if TipoEdit = tpInteiro then begin
      Self.Text := SomenteNumeros(Self.Text);
      if Trim(Self.Text) <> '' then
        Self.Text := FormatFloat(',###', StrToFloat(Self.Text));
      Self.SetSelStart(Length(Self.Text)+1);

    end
    else if Trim(fMascara)<>'' then begin
        Self.Text := SomenteNumeros(Self.Text);
        Self.Text := Formatar(Self.Text);
        Self.SetSelStart(Length(Self.Text)+1);
    end;
  end
  else if TipoEdit = tpMac then
  begin
    posicao_mascara := 0;
    Retorno := '';
    inherited;
    for i := 1 to Length(Self.Text) do begin
      posicao_mascara := posicao_mascara + 1;
      if CharInSet(fMascara[posicao_mascara],[':']) then begin
        Retorno := Retorno + fMascara[posicao_mascara];
        posicao_mascara := posicao_mascara +1;
      end;
      Retorno := Retorno + String(Self.Text[i]);
    end;
    Self.Text := Retorno;
    Self.SetSelStart(Length(Self.Text)+1);

  end
  else
  inherited;
end;

{ TeditPadrao }


procedure TeditPadrao.CMTextChanged(var Message: TMessage);
begin
  Inherited;
  if Self.Text = Self.Name then
    Self.Text := '';
//  if Self.Parent <> nil then
//    Self.SetSelStart(Length(Self.Text));
end;

constructor TeditPadrao.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);

end;

destructor TeditPadrao.Destroy;
begin

  inherited;
end;
function TeditPadrao.Formatar(value: string): string;
var
  i: Integer;
  posicao_mascara: Integer;
begin
  posicao_mascara := 0;
  for i := 1 to Length(value) do begin
    posicao_mascara := posicao_mascara + 1;
    if not CharInSet(fMascara[posicao_mascara],['0'..'9','#']) and
    not CharInSet(fMascara[posicao_mascara], [value[i]]) then begin
      Result := Result + fMascara[posicao_mascara];
      posicao_mascara := posicao_mascara +1;
    end;
    Result := Result + String(value[i]);
  end;
end;

function TeditPadrao.Numeros(value: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(value) do
    if CharInSet(Value[i], ['0'..'9']) then
      Result := Result + Value[i];

end;
procedure TeditPadrao.SetStyle(const Value: TStyle);
var
  rgn: HRGN;
  dc : HDC;
begin
  fStyle := Value;
  if fStyle = sRedonda then begin
    rgn := CreateRoundRectRgn(0, 0, Self.Width, Self.Height, 10, 10);
    dc := GetDC(Self.Handle);
    SetWindowRgn(Self.Handle, rgn, true);
    ReleaseDC(Self.Handle, dc);
    DeleteObject(rgn);
  end;
end;

procedure TeditPadrao.WMSize(var Message: TWMSize);
begin
  inherited;
  Self.SetStyle(Self.fStyle);
end;

{ THComboBox }

procedure THComboBox.AdicionarItem(descricao, valor: string);
begin
  Self.Items.Add(descricao);
  Self.Values.Add(valor);
end;

procedure THComboBox.Clear;
begin
  Self.Items.Clear;
  Self.Values.Clear;
end;

constructor THComboBox.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  fValues := TStringList.Create;
end;

destructor THComboBox.Destroy;
begin

  inherited;
end;

function THComboBox.GetValorSelecionado: String;
begin
  if (Self.ItemIndex > -1) and (Self.Values.Count > 0) then
    Result := fValues[Self.ItemIndex]
  else
    Result := '';
end;

function THComboBox.SetIndexValue(Value: string): Integer;
begin
  Result := Self.Values.IndexOf(Value);
  Self.ItemIndex := Result;
  Self.Change;
  Self.Click;
end;

procedure THComboBox.SetValues(const Value: TStrings);
begin
  if Assigned(fValues) then
    fValues.Assign(Value)
  else
    fValues := Value;
end;

end.
