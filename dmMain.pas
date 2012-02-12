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

