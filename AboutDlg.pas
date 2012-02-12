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

unit AboutDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TAboutBox }

  TAboutBox = class(TForm)
    btOK: TButton;
    btLicense: TButton;
    imIcon: TImage;
    lbCopyright: TLabel;
    lbHomepage: TLabel;
    lbTitle: TLabel;
    mmInfo: TMemo;
    pnAboutBox: TPanel;
    procedure btLicenseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbHomepageClick(Sender: TObject);
    procedure lbTitleDblClick(Sender: TObject);
  private
    { private declarations }
    LicenseFile: string;
  public
    { public declarations }
  end; 

implementation

uses LCLIntf, ProgramStrings;

{$R *.lfm}

{ TAboutBox }

procedure TAboutBox.FormShow(Sender: TObject);
begin
  btLicense.Enabled:= FileExists(LicenseFile);
  Caption:= Format(sAboutDialogCaption,[Application.Title]);
  lbTitle.Caption:= GetApplicationFullTitle;
//  imIcon.Picture.Assign(Application.Icon);
  lbCopyright.Caption:=  sCopyright;
  lbHomepage.Caption:= sHomepage;
  mmInfo.Lines.Clear;
  mmInfo.Lines.Add(sLicenseIntro);
  mmInfo.Lines.Add('');
  mmInfo.Lines.Add(sAsIs);

  ShowMessage(IntToStr(mmInfo.Lines.Count));
end;

procedure TAboutBox.btLicenseClick(Sender: TObject);
begin
  OpenDocument(GetLicenseFile);
end;

procedure TAboutBox.lbHomepageClick(Sender: TObject);
begin
  OpenURL(lbHomepage.Caption);
end;

procedure TAboutBox.lbTitleDblClick(Sender: TObject);
begin
  ShowMessage(GetApplicationInfo);
end;

end.



