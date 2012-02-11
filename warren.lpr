program warren;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainFrm, AccountDlg, AboutDlg, FinanceDialogs, TransactionDlg,
  CurrencyDlg, SecurityDlg, PayeeDlg, CategoryDlg;

{$R *.res}

begin
  Application.Title:='Warren';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

