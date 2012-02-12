{
Copyright (C) 2012 João Marcelo S. Vaz

This file is part of Warren, a personal finance software.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

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

