unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ExtCtrls, ActnList, StdActns;

type

  { TMainForm }

  TMainForm = class(TForm)
    acHelpAbout: TAction;
    alActions: TActionList;
    acFileExit: TFileExit;
    miHelpSep01: TMenuItem;
    miHelpHelp: TMenuItem;
    miFileSep02: TMenuItem;
    miFileOpen: TMenuItem;
    miFileNew: TMenuItem;
    miFileSaveAs: TMenuItem;
    miFilePageSetup: TMenuItem;
    miFilePrinterSetup: TMenuItem;
    miFileExit: TMenuItem;
    miFileSep01: TMenuItem;
    miHelpAbout: TMenuItem;
    miHelp: TMenuItem;
    miFile: TMenuItem;
    mnMain: TMainMenu;
    nbMain: TNotebook;
    spVerticalSplitter: TSplitter;
    tvNavigator: TTreeView;
    procedure acHelpAboutExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvNavigatorClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    FileName: string;
  end;

var
  MainForm: TMainForm;

implementation

uses ProgramDialogs, dmMain;

{$R *.lfm}

{ TMainForm }

procedure TMainForm.tvNavigatorClick(Sender: TObject);
begin
  if not Assigned(tvNavigator.Selected) then exit;
  ShowMessage(tvNavigator.Selected.Text);




end;

procedure TMainForm.acHelpAboutExecute(Sender: TObject);
begin
  with TAboutBoxDialog.Create do
    try
      // fill properties
      Execute;
    finally
      Free;
    end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if dmMain.LoadFile(FileName) then
    Caption:= Application.Title + ' - ' + FileName
  else
    begin
      ShowMessage('Erro ao carregar o arquivo');
      Close;
    end;
end;

end.

