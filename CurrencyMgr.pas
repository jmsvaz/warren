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

 TCurrency = record
   Name: string;
   Code: string;
   PrefixSymbol: string;
   SuffixSymbol: string;
   NegotiatedFraction: Double;
 end;

 { TCustomCurrencyList }

 TCustomCurrencyList = class
   private
     fCurrencyList: TStringList;
     fCurrencyProperties: TStringList;
     function GetCount: Integer;
   protected // to be overriden
     function GetCurrencyCount: Integer; virtual; abstract; // returns the number of currencies will be added
     function ToCurrency(ACurrency: TStringList): TCurrency; virtual; abstract; // convert a stored currency to a curency record
     function ToStringList(ACurrencyIndex: Integer): TStringList; virtual; abstract;
     function GetPropertyNames: TStringList; virtual; abstract;
   public
     constructor Create;
     destructor Destroy; override;
     property CurrencyPropertyNames: TStringList read GetPropertyNames;
     function PropertiesByCurrencyName(AName: string): TStringList;
     function PropertiesByCurrencyIndex(AIndex: Integer): TStringList;
     function CurrencyByName(AName: string): TCurrency;
     function CurrencyByIndex(AIndex: Integer): TCurrency;
     property Count: Integer read GetCount;

 end;

  { TISO4217CurrencyList }

  TISO4217CurrencyList = class(TCustomCurrencyList)
    protected
      function GetCurrencyCount: Integer; override;
      function ToCurrency(ACurrency: TStringList): TCurrency; override;
      function ToStringList(ACurrencyIndex: Integer): TStringList; override;
      function GetPropertyNames: TStringList; override;
    end;


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



var
  CurrencyManager: TCurrencyManager; //TODO: change this to specific currency types manager (ISO4217, Stocks, Mutua Funds, etc)

implementation

uses math;

{ TISO4217CurrencyList }

function TISO4217CurrencyList.GetCurrencyCount: Integer;
begin
  Result:= 1; //TODO: add other currencies....
end;

function TISO4217CurrencyList.ToCurrency(ACurrency: TStringList): TCurrency;
begin
  with Result do
    begin
      Name:= ACurrency[0];
      Code:= ACurrency[2];
      PrefixSymbol:= ACurrency[2];
      SuffixSymbol:= '';
      NegotiatedFraction:= Power(10,StrToInt(ACurrency[4]));
    end;
end;

function TISO4217CurrencyList.ToStringList(ACurrencyIndex: Integer
  ): TStringList;
begin
  //TODO: add other currencies....
    Result:= TStringList.Create;
    Result.Add('Real');
    Result.Add('Brasil');
    Result.Add('BRL');
    Result.Add('986');
    Result.Add('2');
end;

function TISO4217CurrencyList.GetPropertyNames: TStringList;
begin
  Result:= TStringList.Create;
  Result.Add('Name');
  Result.Add('Country');
  Result.Add('Alphabetic Code');
  Result.Add('Numeric Code');
  Result.Add('Minor Unit');
end;


{ TCustomCurrencyList }

function TCustomCurrencyList.GetCount: Integer;
begin
  Result:= fCurrencyList.Count;
end;

constructor TCustomCurrencyList.Create;
var
  i: Integer;
begin
  fCurrencyList:= TStringList.Create;
  fCurrencyProperties:= TStringList.Create;
  fCurrencyList.BeginUpdate;
  for i:= 0 to (GetCurrencyCount - 1) do
    fCurrencyList.AddObject(ToStringList(i)[0],ToStringList(i));
  fCurrencyList.EndUpdate;
end;

destructor TCustomCurrencyList.Destroy;
begin
  fCurrencyProperties.Free;
  fCurrencyList.Free;
end;

function TCustomCurrencyList.PropertiesByCurrencyName(AName: string
  ): TStringList;
begin
  Result:= TStringList.Create;
  Result.Assign(fCurrencyList.Objects[fCurrencyList.IndexOf(AName)] as TStringList);
end;

function TCustomCurrencyList.PropertiesByCurrencyIndex(AIndex: Integer
  ): TStringList;
begin
  Result:= TStringList.Create;
  Result.Assign(fCurrencyList.Objects[AIndex] as TStringList);
end;

function TCustomCurrencyList.CurrencyByName(AName: string): TCurrency;
begin
  Result:= ToCurrency(PropertiesByCurrencyName(AName));
end;


function TCustomCurrencyList.CurrencyByIndex(AIndex: Integer): TCurrency;
begin
  Result:= ToCurrency(PropertiesByCurrencyIndex(AIndex));
end;




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


initialization
  CurrencyManager:= TCurrencyManager.Create;

finalization
  CurrencyManager.Free;

end.

