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
    lbWebsite: TLabel;
    OpenDialog: TOpenDialog;
    procedure btExitClick(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    FileName: string;
  end;


implementation

{$R *.lfm}

{ TWelcomeDialog }

procedure TWelcomeDialog.btExitClick(Sender: TObject);
begin
  Close;
end;

procedure TWelcomeDialog.btOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    begin
      FileName:= OpenDialog.FileName;
      ModalResult:= mrOK;
    end;
end;

end.

