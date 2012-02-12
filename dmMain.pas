unit dmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Dialogs, Controls;

type

  { Tdm }

  Tdm = class(TDataModule)
    ImageList: TImageList;
    OpenDialog: TOpenDialog;
  private
    { private declarations }
  public
    { public declarations }
  end;

procedure LoadOptions;
function LoadFile(AFileName: string): boolean;


var
  dm: Tdm;

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

