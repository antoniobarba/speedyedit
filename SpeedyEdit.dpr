program SpeedyEdit;

uses
  Forms,
  Principale in 'Principale.pas' {Form1},
  About in 'About.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SpeedyEdit 2.5';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
