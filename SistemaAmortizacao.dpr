program SistemaAmortizacao;

uses
  Vcl.Forms,
  menu in 'menu.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMenu, formMenu);
  Application.Run;
end.
