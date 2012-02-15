unit DatabaseDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  ExtCtrls, Buttons;

type

  { TDatabaseDialog }

  TDatabaseDialog = class(TForm)
    btCancel: TBitBtn;
    btHelp: TBitBtn;
    btOK: TBitBtn;
    bvBottomLine: TBevel;
    edFileName: TFileNameEdit;
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
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

uses ProgramStrings, dmMain;

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
end;

procedure TDatabaseDialog.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TDatabaseDialog.btOKClick(Sender: TObject);
begin
  if CreateADatabase(edFileName.Text) then
    ModalResult:= mrOK;
end;

end.

