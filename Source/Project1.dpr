program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  dec in 'dec.pas',
  FlashForm in 'FlashForm.pas' {MUFlash},
  ConfigForm in 'ConfigForm.pas' {CfgForm},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CMT Auto Backup Tools';
  Application.CreateForm(TMUFlash, MUFlash);
  Application.CreateForm(TCfgform, Cfgform);
  Application.CreateForm(TForm3, Form3);
  muflash.iniciar;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
