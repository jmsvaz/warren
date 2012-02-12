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

unit AccountDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, EditBtn, Spin, Buttons;

type

  { TAccountEditorDialog }

  TAccountEditorDialog = class(TForm)
    btCancel: TBitBtn;
    btHelp: TBitBtn;
    btOK: TBitBtn;
    bvBottomLine: TBevel;
    cbAccountType: TComboBox;
    cbCurrency: TComboBox;
    cbFavorite: TCheckBox;
    cbInactive: TCheckBox;
    dtInitialDate: TDateEdit;
    edAccountName: TEdit;
    edInitialBalance: TEdit;
    lbAccountName: TLabel;
    lbAccountStatus: TLabel;
    lbAccountType: TLabel;
    lbCurrency: TLabel;
    lbInitialBalance: TLabel;
    lbInitialDate: TLabel;
    lbNotes: TLabel;
    mmNotes: TMemo;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AccountEditorDialog: TAccountEditorDialog;

implementation

{$R *.lfm}

end.

