program warren;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  SysUtils, Forms, MainFrm, ProgramDialogs;

{$R *.res}

begin
  Application.Title:='Warren';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);

  if ParamCount > 0 then
    MainForm.FileName:= ParamStr(1)  //TODO: test this!!!
  else
    MainForm.FileName:= ProgramDialogs.GetAFileName;

  if FileExists(MainForm.FileName) then
    Application.Run
  else
    Application.Terminate;
end.

