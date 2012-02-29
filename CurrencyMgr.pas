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

unit CurrencyMgr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TCurrencyManager }

  TCurrencyManager = class
  private
    fAmendmentList: TList;
    fCurrencyList: TStringList;
    fPopulateTableSQL: TStringList;
    function GetCurrencyList: TStringList;
    function GetPopulateTableSQL: TStringList;
    procedure AddCurrency(Name, Country, AlphabeticCode, UnitsName, CentsName, PrefixName, SuffixName: string; NegotiatedFraction: Double);
  protected
    procedure PopulateData;
  public
    constructor Create;
    destructor Destroy;
    function GetUpdateTableSQL(FromAmendment: Integer): TStringList;
    property CurrencyList: TStringList read GetCurrencyList;
    property PopulateTableSQL: TStringList read GetPopulateTableSQL;

  end;

implementation

{ TCurrencyManager }

function TCurrencyManager.GetCurrencyList: TStringList;
begin
  Result:= TStringList.Create;
  Result.Assign(fCurrencyList);
end;

function TCurrencyManager.GetPopulateTableSQL: TStringList;
begin
  Result:= TStringList.Create;
  Result.Assign(fPopulateTableSQL);
end;

procedure TCurrencyManager.AddCurrency(Name, Country, AlphabeticCode,
  UnitsName, CentsName, PrefixName, SuffixName: string;
  NegotiatedFraction: Double);
var
  SQL: string;
begin
  SQL:= ''; //TODO: add SQL statement
  fPopulateTableSQL.Add(SQL);
  fCurrencyList.Add(Name);
end;

procedure TCurrencyManager.PopulateData;
begin
  AddCurrency('Real','Brasil','BRL','Real','Centavos','R$','',100);
end;

constructor TCurrencyManager.Create;
begin
  fAmendmentList:= TList.Create;
  fCurrencyList:= TStringList.Create;
  fPopulateTableSQL:= TStringList.Create;
  PopulateData;
end;

destructor TCurrencyManager.Destroy;
var
  i: Integer;
begin
{  for i:= (fAmendmentList.Count - 1) downto 0 do
    if Assigned(fAmendmentList.Items[i]) then
      (fAmendmentList.Items[i] as TStringList).Free;
}
  fAmendmentList.Clear;
  fAmendmentList.Free;
  fCurrencyList.Free;
  fPopulateTableSQL.Free;
end;

function TCurrencyManager.GetUpdateTableSQL(FromAmendment: Integer
  ): TStringList;
begin
//TODO: create amendment list
end;

end.

