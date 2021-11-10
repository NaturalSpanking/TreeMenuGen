program TreeMenuGenerator;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ABOUT in 'ABOUT.pas' {AboutBox};

{$R *.res}

begin
  PInteger(@Screen.DefaultKbLayout)^:=-1;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;

end.
