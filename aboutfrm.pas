{
Copyright (C) 2012 João Marcelo S. Vaz

This file is part of Rifas - a raffle generator program.

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

unit AboutFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TAboutDialog }

TAboutDialog = class(TForm)
    btOK: TButton;
    btLicense: TButton;
    imIcon: TImage;
    lbCopyright: TLabel;
    lbHomepage: TLabel;
    lbTitle: TLabel;
    mmInfo: TMemo;
    pnAboutBox: TPanel;
    procedure btLicenseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbHomepageClick(Sender: TObject);
    procedure lbTitleDblClick(Sender: TObject);
  private
    { private declarations }
      LicenseFile: string;
      ApplicationVersion: string;
      Target: string;
      BuildDate: string;
      CompiledWith: string;
  public
    { public declarations }
  end; 

implementation

uses LCLIntf, uStrings, VersionInfo;

{$R *.lfm}

{ TAboutDialog }

procedure TAboutDialog.FormCreate(Sender: TObject);
var
  PI: TProductInfo;
begin
  LicenseFile:= ExtractFilePath(Application.ExeName) + 'license.txt';
  PI:= TProductInfo.Create;
  try
    ApplicationVersion:= VersionInfo3ToStr(PI.FileVersion);
    Target:= PI.CPU + '-' + PI.OS + '-' + PI.WidgetSet;
    BuildDate:= DateToStr(PI.BuildDate);
    CompiledWith:= 'FPC v' + VersionInfo3ToStr(PI.FPCVersion)  + ' / LCL v' + VersionInfo3ToStr(pi.LCLVersion)
  finally
    PI.Free;
  end;
end;

procedure TAboutDialog.FormShow(Sender: TObject);
begin
  btLicense.Enabled:= FileExists(LicenseFile);
  Caption:= Format(sAboutDialogCaption,[Application.Title]);
  lbTitle.Caption:= Format('%s %s', [Application.Title, ApplicationVersion]);
//  imIcon.Picture.Assign(Application.Icon);
  lbCopyright.Caption:=  'Copyright © 2011 João Marcelo S. Vaz';
  lbHomepage.Caption:= 'http://rifas.sourceforge.net/';
  mmInfo.Lines.Clear;
  mmInfo.Lines.Add(sLicenseIntro);
  mmInfo.Lines.Add('');
  mmInfo.Lines.Add(sAsIs);
end;

procedure TAboutDialog.btLicenseClick(Sender: TObject);
begin
  OpenDocument(LicenseFile);
end;

procedure TAboutDialog.lbHomepageClick(Sender: TObject);
begin
  OpenURL(lbHomepage.Caption);
end;

procedure TAboutDialog.lbTitleDblClick(Sender: TObject);
begin
  ShowMessage(Format(sProgramInfo,[lbTitle.Caption,Target,BuildDate,CompiledWith]));
end;

end.



