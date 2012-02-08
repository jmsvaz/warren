{
    Copyright (C) 2010-2012 João Marcelo S. Vaz

    This file is part of jmUtils.

    jmUtils is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    jmUtils is distributed in the hope that it will be useful,
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
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type

  { TAboutDialog }

  TAboutDialog = class(TForm)
    lbCopyright: TLabel;
    lbHomePage: TLabel;
    mmHistory: TMemo;
    mmInfo: TMemo;
    mmCredits: TMemo;
    mmLicense: TMemo;
    mmAbout: TMemo;
    PageControl: TPageControl;
    ProgramIcon: TImage;
    lbProgramVersion: TLabel;
    lbProgramTitle: TLabel;
    tsHistory: TTabSheet;
    tsInfo: TTabSheet;
    tsLicense: TTabSheet;
    tsCredits: TTabSheet;
    tsAbout: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure lbHomePageClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AboutDialog: TAboutDialog;

implementation

{$R *.lfm}

uses  LCLIntf;

{ TAboutDialog }

procedure TAboutDialog.FormShow(Sender: TObject);
begin
  PageControl.ActivePage:= tsAbout;

  ProgramIcon.Picture.Icon:= Application.Icon;
end;

procedure TAboutDialog.lbHomePageClick(Sender: TObject);
begin
  OpenURL(lbHomePage.Caption);
end;


end.

