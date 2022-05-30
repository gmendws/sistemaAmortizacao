unit pagamentoUnico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask,
  FnpNumericEdit, Vcl.Samples.Spin, Vcl.Imaging.pngimage;

type
  TformPagamentoUnico = class(TForm)
    panelPrincipal: TPanel;
    Panel1: TPanel;
    qAmortizacao: TFDMemTable;
    gridAmortizacao: TDBGrid;
    labelCapital: TLabel;
    labelJuros: TLabel;
    labelMeses: TLabel;
    buttomSimular: TButton;
    editJuros: TFnpNumericEdit;
    editCapital: TFnpNumericEdit;
    DataSource1: TDataSource;
    qAmortizacaoJuros: TFloatField;
    qAmortizacaosaldoAmortizacao: TFloatField;
    qAmortizacaoPagamento: TFloatField;
    qAmortizacaosaldoDevedor: TFloatField;
    editMeses: TSpinEdit;
    qAmortizacaomeses: TStringField;
    imageDatapar: TImage;
    procedure buttomSimularClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPagamentoUnico: TformPagamentoUnico;

implementation

{$R *.dfm}

procedure TformPagamentoUnico.buttomSimularClick(Sender: TObject);
var
  vMeses,
  I             : Integer;
  vSaldoDevedor,
  vTaxaJuros,
  vJuros,
  vTotalJuros,
  vCapital      : Double;
begin
  vMeses := 1;
  if editMeses.Text <> '' then
    vMeses  := StrToInt(editMeses.Text);

  vCapital   := StrToFloat(editCapital.Text);
  vTaxaJuros := StrToFloat(editJuros.Text);

  if vCapital = 0 then begin
    ShowMessage('Preencha o valor do capital.');
    Abort;
  end;

  if vTaxaJuros = 0 then begin
    ShowMessage('Preencha a porcetagem dos juros.');
    Abort;
  end;

  qAmortizacao.Close;
  qAmortizacao.Open;

  vSaldoDevedor := vCapital;
  vJuros        := 0;
  vTotalJuros   := 0;

  for I := 0 to vMeses do begin

    qAmortizacao.Append;

    if I = 0 then  begin
      qAmortizacaoMeses.AsLargeInt         := I;
      qAmortizacaoJuros.AsFloat            := 0;
      qAmortizacaosaldoDevedor.AsFloat     := vSaldoDevedor;

      qAmortizacaosaldoAmortizacao.AsFloat := 0;
      qAmortizacaoPagamento.AsFloat        := 0;
    end
    else begin

      vJuros        := (vSaldoDevedor * vTaxaJuros) / 100;

      vTotalJuros   := vTotalJuros + vJuros;

      vSaldoDevedor := vSaldoDevedor + vJuros;

      qAmortizacaoMeses.AsLargeInt         := I;
      qAmortizacaoJuros.AsFloat            := vJuros;

      if I = vMeses then begin
        qAmortizacaosaldoAmortizacao.AsFloat := vCapital;
        qAmortizacaoPagamento.AsFloat        := vSaldoDevedor;
        qAmortizacaosaldoDevedor.AsFloat     := 0;
      end
      else begin
        qAmortizacaosaldoDevedor.AsFloat     := vSaldoDevedor;
        qAmortizacaosaldoAmortizacao.AsFloat := 0;
        qAmortizacaoPagamento.AsFloat        := 0;
      end;

    end;


    qAmortizacao.Post;

  end;

  qAmortizacao.Append;
  qAmortizacaoMeses.AsString           := 'Totais';    //total
  qAmortizacaoJuros.AsFloat            := vTotalJuros;

  qAmortizacaosaldoAmortizacao.AsFloat := vCapital;
  qAmortizacaoPagamento.AsFloat        := vSaldoDevedor;
  qAmortizacao.Post;


end;

end.
