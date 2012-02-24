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

unit DatabaseDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  ExtCtrls, Buttons, StdCtrls;

type

  { TDatabaseDialog }

  TDatabaseDialog = class(TForm)
    btCancel: TBitBtn;
    btHelp: TBitBtn;
    btOK: TBitBtn;
    bvBottomLine: TBevel;
    cbCurrency: TComboBox;
    edFileName: TFileNameEdit;
    edName: TEdit;
    lbCurrency: TLabel;
    lbFile: TLabel;
    lbName: TLabel;
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
    function CheckValues(out msg: String): Boolean;
  public
    { public declarations }
  end;

  { TCreateFileDialog }

  TCreateFileDialog = class
  private
    fFileName: string;
  public
    constructor Create;
    function Execute: boolean;
    property FileName: string read fFileName;
  end;

var
  DatabaseDialog: TDatabaseDialog;

implementation

uses ProgramStrings, MainDM;

{ TCreateFileDialog }


function TCreateFileDialog.Execute: boolean;
begin
  Result:= False;
  with TDatabaseDialog.Create(nil) do
    try
      if ShowModal = mrOK then
        begin
          Result:= True;
          fFileName:= edFileName.Text;
        end;
    finally
      Release;
    end;
end;

constructor TCreateFileDialog.Create;
begin
  fFileName:= '';
end;

{$R *.lfm}

{ TDatabaseDialog }

procedure TDatabaseDialog.FormCreate(Sender: TObject);
begin
  edFileName.DefaultExt:= sDefaultExt;
  edFileName.Filter:= GetSaveDialogFilter;
  edFileName.DialogTitle:= sDatabaseDialogCaption;
  cbCurrency.Items.Assign(dm.CurrencyManager.CurrencyList);
end;

procedure TDatabaseDialog.FormShow(Sender: TObject);
begin

  if cbCurrency.Items.Count > 0 then
    cbCurrency.ItemIndex:= 0;
end;

function TDatabaseDialog.CheckValues(out msg: String): Boolean;
var
  path,filename: string;
begin
  // TODO: choose a better error message and transform to resourcestring
  Result:= False;
  if Length(cbCurrency.Text) = 0 then
    begin
      msg:= 'Choose a base currency!';
      cbCurrency.SetFocus;
      Exit;
    end;
  path:= ExtractFilePath(edFileName.Text);
  filename:= ExtractFileName(edFileName.Text);
  if (Length(path) = 0) or (Length(filename) = 0) then
    begin
      msg:= 'Choose a filename!';
      edFileName.SetFocus;
      Exit;
    end;
  Result:= True;
end;

procedure TDatabaseDialog.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TDatabaseDialog.btOKClick(Sender: TObject);
var
  error: String;
begin
  // TODO: choose a better error message and transform to resourcestring
  if CheckValues(error) then
    begin
      if CreateADatabase(edName.Text,cbCurrency.Text,edFileName.Text) then
        ModalResult:= mrOK
      else
        error:= 'could not create database';
    end
  else
    ShowMessage(error);
end;

end.

