unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ExtCtrls, ActnList, StdActns;

type

  { TfrmMain }

  TfrmMain = class(TForm)
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
    procedure tvNavigatorClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses FinanceDialogs;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.tvNavigatorClick(Sender: TObject);
begin
  if not Assigned(tvNavigator.Selected) then exit;
  ShowMessage(tvNavigator.Selected.Text);
end;

procedure TfrmMain.acHelpAboutExecute(Sender: TObject);
begin
  with TAboutBoxDialog.Create do
    try
      // fill properties
      Execute;
    finally
      Free;
    end;
end;

end.

