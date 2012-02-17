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

unit ProgramStrings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

const
  sDefaultExt = '.wdb';

function GetLicenseFile: string;
function GetSaveDialogFilter: string;
function GetApplicationFullTitle: string;
function GetApplicationInfo: string;

resourcestring
  sAboutDialogCaption = 'About %s';
  sWelcomeDialogCaption = 'Welcome to %s';
  sOpenDialogCaption = 'Open existing file';
  sDatabaseDialogCaption = 'Create a new file';

  sDefaultFileDescription = 'Warren Database';
  sAllFilesDescription = 'All files';

  sProgramInfo  = '%s build for %s at %s with %s';
  sLicense      = 'Free software released under GPLv3';
  sLicenseIntro = 'This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.';
  sAsIs         = 'This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.';


implementation

uses dmMain, VersionInfo;

function GetApplicationFullTitle: string;
begin
  Result:= Format('%s %s', [Application.Title, VersionInfo3ToStr(dm.PI.FileVersion)]);
end;

function GetApplicationInfo: string;
var
  Target: string;
  BuildDate: string;
  CompiledWith: string;
begin
  Target:= dm.PI.CPU + '-' + dm.PI.OS + '-' + dm.PI.WidgetSet;
  BuildDate:= DateToStr(dm.PI.BuildDate);
  CompiledWith:= 'FPC v' + VersionInfo3ToStr(dm.PI.FPCVersion)  + ' / LCL v' + VersionInfo3ToStr(dm.PI.LCLVersion);
  Result:= Format(sProgramInfo,[GetApplicationFullTitle,Target,BuildDate,CompiledWith])
end;

function MaskFromExt(Ext: string): string;
begin
  Result:= '*' + Ext;
end;

function FormatFileDescription(Mask,Description: string; LastFilter: Boolean = False): string;
begin
  Result:= Description + '(' + Mask + ')|*' + Mask;
  if not LastFilter then
    Result:= Result + '|';
end;

function GetLicenseFile: string;
begin
  Result:= ExtractFilePath(Application.ExeName) + 'license.txt';
end;


function GetSaveDialogFilter: string;
begin
  Result:= FormatFileDescription(MaskFromExt(sDefaultExt),sDefaultFileDescription);
  Result:= Result + FormatFileDescription(GetAllFilesMask,sAllFilesDescription,True);
end;

end.

