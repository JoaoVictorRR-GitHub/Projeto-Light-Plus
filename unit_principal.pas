unit unit_Principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Dialogs, StdCtrls, ExtCtrls;

type

  { Tform_Principal_ }

  Tform_Principal_ = class(TForm)

    painel_Botoes_:        TPanel;
    botao_Limpar_:         TButton;
    botao_Sair_:           TButton;

    painel_Talao_:         TPanel;
    campo_Consumo_Total_:  TLabeledEdit;
    campo_Tarifa_:         TLabeledEdit;
    campo_Preco_Total_:    TLabeledEdit;

    label_Observacao_:     TStaticText;

    function moedaTexto(Valor: String): String;
    procedure botao_Limpar_Click(Sender: TObject);
    procedure botao_Sair_Click(Sender: TObject);
    procedure Calcular_Preco_(Sender: TObject; var Key: char);
    procedure campo_Tarifa_KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  form_Principal_: Tform_Principal_;

implementation
              uses LCLType;

{$R *.lfm}

{ Tform_Principal_ }



{*  Metodo para calcular o preco total ao pressionar alguma tecla. *}
procedure Tform_Principal_.Calcular_Preco_(Sender: TObject; var Key: char);
var
  Calculo: Currency;
begin

  // Key = #13 = ENTER.
  if(Key = #13)then
  begin

    try

       // Calculo = Consumo * Tarifa.
       Calculo:= StrToCurr(campo_Consumo_Total_.Text) * StrToCurr(campo_Tarifa_.Text);
       campo_Preco_Total_.Text:= CurrToStr(Calculo);

    Except on Ex: Exception do

      // Mensagem de excecao(Erro).
      MessageDlg('# OCORRÊNCIA DE ERRO', 'Verifique se foram digitados apenas números !', mtInformation, [mbOK], '');
    end;
  end;
end;



{*  Metodo para passar um texto pra o formato de moeda.      *}
function Tform_Principal_.moedaTexto(Valor: String): String;
var
  Moeda: String;
begin
  Moeda:= Valor;
  Moeda:= StringReplace(Moeda, ',', '', [rfReplaceAll]); //Remove a Vírgula.

  //Formata o valor com mais de 2 dígitos.
  if((Length(Moeda) > 2) and (Length(Valor) <= 10))then
    Moeda:= Copy(Moeda, 1, Length(Moeda)-2) +',' +Copy(Moeda, Length(Moeda)-1, 2)
  else if(Length(Valor) > 10)then Moeda:= Copy(Valor, 1, Length(Valor)-1);

  Result:= Moeda;
end;


{*  Metodo para transformar um texto em moeda ao escrever no campo.       *}
procedure Tform_Principal_.campo_Tarifa_KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //Verifica as Teclas Numéricas (+Algumas Teclas) e a Tecla "Backspace".
  if((Key in [96..107]) or (Key in [48..57]) or (key = VK_BACK)) then
      campo_Tarifa_.Text:= moedaTexto(campo_Tarifa_.Text);
  campo_Tarifa_.SelStart:= Length(campo_Tarifa_.Text);
end;



{*  Metodo para limpar os campos.  *}
procedure Tform_Principal_.botao_Limpar_Click(Sender: TObject);
begin
  campo_Consumo_Total_.Text:= '0';   // Limpa o campo de consumo total.
  campo_Tarifa_.Text:=        '0';   // Limpa o campo de tarifa.
  campo_Preco_Total_.Text:=   '0';   // Limpa o campo de preco.
  campo_Consumo_Total_.SetFocus;     // Avanca para o campo de consumo.
end;



{*  Metodo para sair da aplicacao. *}
procedure Tform_Principal_.botao_Sair_Click(Sender: TObject);
begin
  Application.Terminate;
  Inherited;
end;

end.

