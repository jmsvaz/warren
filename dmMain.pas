unit dmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil;

type
  TDataModule1 = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

procedure LoadOptions;
function LoadFile(AFileName: string): boolean;


var
  DataModule1: TDataModule1;

implementation

procedure LoadOptions;
begin

end;

function LoadFile(AFileName: string): boolean;
begin
  Result:= True; //TODO: implement this!!!
end;

{$R *.lfm}

end.

