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



unit ProgramDialogs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Dialogs;

type

  { TCustomDialog }

  TCustomDialog = class
  private
    FOnCanClose: TCloseQueryEvent;
    FOnClose : TNotifyEvent;
    FOnShow: TNotifyEvent;
    FTitle : string;
    FHelpContext: THelpContext;
    function DoExecute : boolean; virtual;
    procedure DoShow; virtual;
    procedure DoCanClose(var CanClose: Boolean); virtual;
    procedure DoClose; virtual;
  protected
    Dialog: TForm;
  protected // to override
    function DefaultTitle: string; virtual;
    function CreateDialog: TForm; virtual; abstract;
    procedure SetPropertiesOnDialog; virtual;
    procedure GetPropertiesFromDialog; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute: boolean; virtual;
  published
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnCanClose: TCloseQueryEvent read FOnCanClose write FOnCanClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property Title: string read FTitle write FTitle;
  end;


function GetAFileName: string;

implementation

uses AboutDlg, WelcomeDlg;

resourcestring
  sAboutBoxCaption = 'About %s';



function GetAFileName: string;
begin
  with TWelcomeDialog.Create(nil) do
    try
      if ShowModal = mrOK then
        Result:= FileName;
    finally
      Release;
    end;
end;


{ TCustomDialog }

function TCustomDialog.DefaultTitle: string;
begin
  Result:= '';
end;

procedure TCustomDialog.SetPropertiesOnDialog;
begin
  Dialog.Caption:= Title;
end;

procedure TCustomDialog.GetPropertiesFromDialog;
begin
  //to be overriden if necessary
end;

procedure TCustomDialog.DoShow;
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TCustomDialog.DoCanClose(var CanClose: Boolean);
begin
  if Assigned(FOnCanClose) then
    OnCanClose(Self, CanClose);
end;

procedure TCustomDialog.DoClose;
begin
  if Assigned(FOnClose) then
    FOnClose(Self);
end;

function TCustomDialog.DoExecute: boolean;
var
  CanClose: boolean;
  UserChoice: integer;
begin
  if not Assigned(Dialog) then exit;
  DoShow;
  SetPropertiesOnDialog;
  UserChoice:= Dialog.ShowModal;
  if (UserChoice <> mrNone) then
    begin
      CanClose:= True;
      DoCanClose(CanClose);
      if not CanClose then
        UserChoice:= mrNone;
    end;
  Result:= (UserChoice = mrOk);
  GetPropertiesFromDialog;
  DoClose;
end;

constructor TCustomDialog.Create;
begin
  inherited Create;
  FTitle := DefaultTitle;
  Dialog:= CreateDialog;
end;

destructor TCustomDialog.Destroy;
begin
  Dialog.Release;
  inherited Destroy;
end;

function TCustomDialog.Execute: boolean;
begin
  Result:= DoExecute;
end;

end.

