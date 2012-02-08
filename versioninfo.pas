{
This file is part of Rifas - a raffle generator program.
Copyright (C) 2011 João Marcelo S. Vaz

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

unit VersionInfo;

{$mode objfpc}

interface

uses
  Classes, SysUtils, versionresource;

type

  { TVersionInfo }
   TVersionInfo = record
     MajorVersion: Integer;
     MinorVersion: Integer;
     Release: Integer;
     Build: Integer;
   end;

  { TProductInfo }

  TProductInfo = class
  private
    fVersionResource: TVersionResource;
    fFPCVersion: TVersionInfo;
    fLCLVersion: TVersionInfo;
    function GetBuildDate: TDateTime;
    function GetComments: String;
    function GetCompanyName: String;
    function GetCPU: String;
    function GetFileDescription: String;
    function GetFileVersion: TVersionInfo;
    function GetInternalName: String;
    function GetLegalCopyright: String;
    function GetLegalTrademarks: String;
    function GetOriginalFilename: String;
    function GetOS: String;
    function GetProductName: String;
    function GetProductVersion: TVersionInfo;
    function GetWidgetSet: String;
  public
    constructor Create;
    destructor Destroy; override;
    property FileVersion: TVersionInfo read GetFileVersion; // Version number of the file — for example, "3.10"
    property ProductVersion: TVersionInfo read GetProductVersion; // Version of the product with which the file is distributed — for example, "3.10"
    property ProductName: String read GetProductName; // Name of the product with which the file is distributed.
    property CompanyName: String read GetCompanyName; // Company that produced the file — for example, "Standard Microsystems Corporation, Inc."
    property FileDescription: String read GetFileDescription; // File description to be presented to users.
    property InternalName: String read GetInternalName; // Internal name of the file, if one exists
    property OriginalFilename: String read GetOriginalFilename; // Original name of the file, not including a path. This information enables an application to determine whether a file has been renamed by a user.
    property LegalCopyright: String read GetLegalCopyright; // Copyright notices that apply to the file. This should include the full text of all notices, legal symbols, copyright dates, and so on.
    property LegalTrademarks: String read GetLegalTrademarks; // Trademarks and registered trademarks that apply to the file. This should include the full text of all notices, legal symbols, trademark numbers, and so on.
    property Comments: String read GetComments;  // Additional information that can be displayed for diagnostic purposes.
    property BuildDate: TDateTime read GetBuildDate;
    property CPU: String read GetCPU;
    property OS: String read GetOS;
    property WidgetSet: String read GetWidgetSet;
    property FPCVersion: TVersionInfo read fFPCVersion; // FreePascal Compiler version
    property LCLVersion: TVersionInfo read fLCLVersion;  // Lazarus Component Library version
  end;

  function VersionInfoToStr(VI: TVersionInfo): String;
  function VersionInfo3ToStr(VI: TVersionInfo): String;

implementation

uses
   resource, versiontypes, lclversion, interfacebase;

function VersionInfoToStr(VI: TVersionInfo): String;
begin
  Result := Format('%d.%d.%d.%d', [VI.MajorVersion,VI.MinorVersion,VI.Release,VI.Build])
end;

function VersionInfo3ToStr(VI: TVersionInfo): String;
begin
  Result := Format('%d.%d.%d', [VI.MajorVersion,VI.MinorVersion,VI.Release])
end;


{ TProductInfo }

function TProductInfo.GetComments: String;
begin
  Result:= '';
end;

function TProductInfo.GetBuildDate: TDateTime;
var
  dt: string;
  SlashPos1, SlashPos2: integer;
begin
  // code from Lazarus IDE aboutfrm.pas
  dt:= {$I %date%};
  SlashPos1:= Pos('/',dt);
  SlashPos2:= SlashPos1 + Pos('/', Copy(dt, SlashPos1+1, Length(dt)-SlashPos1));
  Result:= EncodeDate(StrToInt(Copy(dt,1,SlashPos1-1)),
           StrToInt(Copy(dt,SlashPos1+1,SlashPos2-SlashPos1-1)),
           StrToInt(Copy(dt,SlashPos2+1,Length(dt)-SlashPos2)));
end;

function TProductInfo.GetCompanyName: String;
begin
  Result:= '';
end;

function TProductInfo.GetCPU: String;
begin
  Result:= {$I %FPCTARGETCPU%};
end;

function TProductInfo.GetFileDescription: String;
begin
  Result:= '';
end;

function TProductInfo.GetFileVersion: TVersionInfo;
begin
  Result.MajorVersion:= fVersionResource.FixedInfo.FileVersion[0];
  Result.MinorVersion:= fVersionResource.FixedInfo.FileVersion[1];
  Result.Release:= fVersionResource.FixedInfo.FileVersion[2];
  Result.Build:= fVersionResource.FixedInfo.FileVersion[3];
end;

function TProductInfo.GetInternalName: String;
begin
  Result:= '';
end;

function TProductInfo.GetLegalCopyright: String;
begin
  Result:= '';
end;

function TProductInfo.GetLegalTrademarks: String;
begin
  Result:= '';
end;

function TProductInfo.GetOriginalFilename: String;
begin
  Result:= '';
end;

function TProductInfo.GetOS: String;
begin
  Result:= {$I %FPCTARGETOS%};
end;

function TProductInfo.GetProductName: String;
begin
  Result:= '';
end;

function TProductInfo.GetProductVersion: TVersionInfo;
begin
  Result.MajorVersion:= fVersionResource.FixedInfo.ProductVersion[0];
  Result.MinorVersion:= fVersionResource.FixedInfo.ProductVersion[1];
  Result.Release:= fVersionResource.FixedInfo.ProductVersion[2];
  Result.Build:= fVersionResource.FixedInfo.ProductVersion[3];
end;

function TProductInfo.GetWidgetSet: String;
begin
  if Assigned(interfacebase.WidgetSet) then
    Result:= LCLPlatformDirNames[interfacebase.WidgetSet.LCLPlatform]
end;

constructor TProductInfo.Create;
var
  Stream: TResourceStream;
begin
  {$IFOPT m+}
    {$DEFINE MacroOn}
  {$ELSE}
    {$MACRO ON}
    {$UNDEF MacroOn}
  {$ENDIF}
  fFPCVersion.MajorVersion:= FPC_VERSION;
  fFPCVersion.MinorVersion:= FPC_RELEASE;
  fFPCVersion.Release:= FPC_PATCH;
  fFPCVersion.Build:= 0;
  {$IFNDEF MacroOn}
    {$MACRO OFF}
  {$ENDIF}
  {$UNDEF MacroOn}
  fLCLVersion.MajorVersion:= lcl_major;
  fLCLVersion.MinorVersion:= lcl_minor;
  fLCLVersion.Release:= lcl_release;
  fLCLVersion.Build:= lcl_patch;
  fVersionResource:= TVersionResource.Create;
  Stream := TResourceStream.CreateFromID(HINSTANCE, 1, PChar(RT_VERSION));
  try
    fVersionResource.SetCustomRawDataStream(Stream);
    // access some property to load from the stream
    fVersionResource.FixedInfo;
    // clear the stream
    fVersionResource.SetCustomRawDataStream(nil);
  finally
    Stream.Free;
  end;
end;

destructor TProductInfo.Destroy;
begin
  fVersionResource.Free;
  inherited Destroy;
end;

end.


