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

unit dmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, FileUtil, Dialogs, Controls,
  VersionInfo;

type

  { Tdm }

  Tdm = class(TDataModule)
    ImageList: TImageList;
    OpenDialog: TOpenDialog;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    PI: TProductInfo;
  end;

procedure LoadOptions;
function LoadFile(AFileName: string): boolean;
function GetAnExistingFile: string;
function GetACreatedFile: string;

function CreateADatabase(AFileName: string): Boolean;

procedure ShowAboutBox;


var
  dm: Tdm;

implementation

uses ProgramStrings, WelcomeDlg, AboutDlg, DatabaseDlg;

procedure LoadOptions;
begin

end;

function LoadFile(AFileName: string): boolean;
begin
  Result:= True; //TODO: implement this!!!
end;

function GetACreatedFile: string;
begin
  with TCreateFileDialog.Create do
    try
      if Execute then
        Result:= FileName;
    finally
      Free;
    end;
end;

function GetAnExistingFile: string;
begin
  with TWelcomeDialog.Create(nil) do
    try
      if ShowModal = mrOK then
        Result:= FileName;
    finally
      Release;
    end;
end;

function CreateADatabase(AFileName: string): Boolean;
var
  AConnection: TSQLite3Connection;
  ATransaction: TSQLTransaction;
begin
  Result:= False;
  AConnection:= TSQLite3Connection.Create(nil);
  try
    AConnection.DatabaseName:= AFileName;
    ATransaction:= TSQLTransaction.Create(nil);
    try
      ATransaction.DataBase:= AConnection;
      AConnection.Transaction:= ATransaction;
      AConnection.Open;
      ATransaction.StartTransaction;
      AConnection.ExecuteDirect('create table t1 (t1key INTEGER PRIMARY KEY, data TEXT, num DOUBLE);');    // create table 1
//      AConnection.ExecuteDirect();    // create table 2 ...
      ATransaction.Commit;
      ATransaction.StartTransaction;
//      AConnection.ExecuteDirect();    // insert data
//      AConnection.ExecuteDirect();    // insert data ...
      ATransaction.Commit;
      AConnection.Close;
      Result:= True;
    finally
      ATransaction.Free;
    end;
  finally
    AConnection.Free;
  end;
end;

procedure ShowAboutBox;
begin
  with TAboutDialog.Create(nil) do
    try
      ShowModal
    finally
      Release;
    end;
end;

{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  OpenDialog.DefaultExt:= sDefaultExt;
  OpenDialog.Filter:= GetSaveDialogFilter;
  OpenDialog.Title:= sOpenDialogCaption;
  PI:= TProductInfo.Create;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  PI.Free;
end;



{$R *.lfm}

end.

