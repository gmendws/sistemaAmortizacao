unit menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus,
  Vcl.Imaging.pngimage;

type
  TformMenu = class(TForm)
    panelPrincipal: TPanel;
    StatusBar1: TStatusBar;
    panelTopo: TPanel;
    MainMenu1: TMainMenu;
    este1: TMenuItem;
    Pagamentonico1: TMenuItem;
    imageDatapar: TImage;
    procedure Pagamentonico1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMenu: TformMenu;

implementation

uses
  pagamentoUnico;

{$R *.dfm}

procedure TformMenu.Pagamentonico1Click(Sender: TObject);
begin
  formPagamentoUnico := TformPagamentoUnico.Create(nil);
  formPagamentoUnico.ShowModal;
  formPagamentoUnico.Free;
end;

end.
