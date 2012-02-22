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

unit WelcomeDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TWelcomeDialog }

  TWelcomeDialog = class(TForm)
    btCreateNew: TButton;
    btExit: TButton;
    btOpen: TButton;
    btViewHelp: TButton;
    imLogo: TImage;
    lbSlogan: TLabel;
    lbWebsite: TLabel;
    lbTitle: TLabel;
    lbLicense: TLabel;
    procedure btCreateNewClick(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    FileName: string;
  end;


implementation

uses ProgramStrings, MainDM, DatabaseDlg;

{$R *.lfm}

{ TWelcomeDialog }

procedure TWelcomeDialog.FormCreate(Sender: TObject);
begin
  Caption:= Format(sWelcomeDialogCaption,[Application.Title]);
  lbTitle.Caption:= GetApplicationFullTitle;
  lbSlogan.Caption:= dm.PI.ProductName;
  lbLicense.Caption:= dm.PI.LegalTrademarks;
  lbWebsite.Caption:= dm.PI.Comments;
end;


procedure TWelcomeDialog.btCreateNewClick(Sender: TObject);
var
  dlg: TCreateFileDialog;
begin
  dlg:= TCreateFileDialog.Create;
  try
    if dlg.Execute then
      begin
        FileName:= dlg.FileName;
        ModalResult:= mrOK;
      end;
  finally
    dlg.Free;
  end;
end;

procedure TWelcomeDialog.btOpenClick(Sender: TObject);
begin
  if dm.OpenDialog.Execute then
    begin
      FileName:= dm.OpenDialog.FileName;
      ModalResult:= mrOK;
    end;
end;

procedure TWelcomeDialog.btExitClick(Sender: TObject);
begin
  Close;
end;

end.

