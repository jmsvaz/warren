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
    cbAccountType: TComboBox;
    cbCurrency: TComboBox;
    cbFavorite: TCheckBox;
    cbInactive: TCheckBox;
    dtInitialDate: TDateEdit;
    edAccountName: TLabeledEdit;
    edInitialBalance: TFloatSpinEdit;
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

