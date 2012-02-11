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
    miFileSep02: TMenuItem;
    miOpen: TMenuItem;
    miNew: TMenuItem;
    miSaveAs: TMenuItem;
    miPageSetup: TMenuItem;
    miPrinterSetup: TMenuItem;
    miExit: TMenuItem;
    miFileSep01: TMenuItem;
    miAbout: TMenuItem;
    miHelp: TMenuItem;
    miFile: TMenuItem;
    mnMain: TMainMenu;
    nbMain: TNotebook;
    spVerticalSplitter: TSplitter;
    tvNavigator: TTreeView;
    procedure acHelpAboutExecute(Sender: TObject);
    procedure tvNavigatorChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
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

procedure TfrmMain.tvNavigatorChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin

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

