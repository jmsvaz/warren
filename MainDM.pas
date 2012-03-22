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

unit MainDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, sqlite3conn, sqldb, FileUtil, Dialogs, Controls,
  VersionInfo, CurrencyMgr;

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

function CreateADatabase(ATitle,AFileName: string; ACurrency: TCurrency): Boolean;

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

function CreateADatabase(ATitle, AFileName: string; ACurrency: TCurrency): Boolean;
var
  AConnection: TSQLite3Connection;
  ATransaction: TSQLTransaction;
const
  DBVersion = 1;
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
      // create ProgramInfo table
      AConnection.ExecuteDirect(
                  'CREATE TABLE IF NOT EXISTS PROGRAMINFO (' +
                  'PROGRAMINFOID INTEGER PRIMARY KEY,' +
                  'PROPERTY TEXT,' +
                  'VALUE TEXT);');
      // create DBInfo table
      AConnection.ExecuteDirect(
                  'CREATE TABLE IF NOT EXISTS DBINFO (' +
                  'DBINFOID INTEGER PRIMARY KEY,' +
                  'PROPERTY TEXT,' +
                  'VALUE TEXT);');
      // create Currency table
      AConnection.ExecuteDirect(
                  'CREATE TABLE IF NOT EXISTS CURRENCY (' +
                  'CURRENCYID INTEGER PRIMARY KEY,' +
                  'NAME TEXT,' +
                  'CODE TEXT,' +
                  'PREFIXSYMBOL TEXT,' +
                  'SUFFIXSYMBOL TEXT,' +
                  'FRACTION DOUBLE);');

//      AConnection.ExecuteDirect();    // create another table ...
      ATransaction.Commit;
      ATransaction.StartTransaction;
      // insert CreatedDate property on table PROGRAMINFO
      AConnection.ExecuteDirect(
                  'INSERT INTO PROGRAMINFO ' +
                  '(PROPERTY,VALUE) VALUES ' +
                  '(' + QuotedStr('CreatedDate') + ',' + QuotedStr(FormatDateTime('yyyy/mm/dd hh:nn:ss',Now)) + ');');
      // insert ProgramName property on table PROGRAMINFO
      AConnection.ExecuteDirect(
                  'INSERT INTO PROGRAMINFO ' +
                  '(PROPERTY,VALUE) VALUES ' +
                  '(' + QuotedStr('ProgramName') + ',' + QuotedStr(Application.Title) + ');');
      // insert ProgramVersion property on table PROGRAMINFO
      AConnection.ExecuteDirect(
                  'INSERT INTO PROGRAMINFO ' +
                  '(PROPERTY,VALUE) VALUES ' +
                  '(' + QuotedStr('ProgramVersion') + ',' + QuotedStr(VersionInfo3ToStr(dm.PI.FileVersion)) + ');');
      // insert DBVersion property on table PROGRAMINFO
      AConnection.ExecuteDirect(
                  'INSERT INTO PROGRAMINFO ' +
                  '(PROPERTY,VALUE) VALUES ' +
                  '(' + QuotedStr('DBVersion') + ',' + QuotedStr(IntToStr(DBVersion)) + ');');
      // insert ModifiedDate property on table PROGRAMINFO
      AConnection.ExecuteDirect(
                  'INSERT INTO PROGRAMINFO ' +
                  '(PROPERTY,VALUE) VALUES ' +
                  '(' + QuotedStr('ModifiedDate') + ',' + QuotedStr(FormatDateTime('yyyy/mm/dd hh:nn:ss',Now)) + ');');

      // insert BaseCurrency property on table CURRENCY
       AConnection.ExecuteDirect(
                   'INSERT INTO CURRENCY ' +
                   '(NAME,CODE,PREFIXSYMBOL,SUFFIXSYMBOL,FRACTION) VALUES ' +
                   '(' + QuotedStr(ACurrency.Name) + ',' + QuotedStr(ACurrency.Code) + ',' + QuotedStr(ACurrency.PrefixSymbol) + ',' + QuotedStr(ACurrency.SuffixSymbol) + ',' + FloatToStr(ACurrency.NegotiatedFraction) + ');');


      // insert DBTitle property on table DBINFO
      AConnection.ExecuteDirect(
                  'INSERT INTO DBINFO ' +
                  '(PROPERTY,VALUE) VALUES ' +
                  '(' + QuotedStr('DBTitle') + ',' + QuotedStr(ATitle) + ');');
      // insert BaseCurrency property on table DBINFO
{       AConnection.ExecuteDirect(
                   'INSERT INTO DBINFO ' +
                   '(PROPERTY,VALUE) VALUES ' +
                   '(' + QuotedStr('BaseCurrency') + ',' + QuotedStr(ACurrency) + ');');
}



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

