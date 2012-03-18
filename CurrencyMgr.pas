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
     function GetCurrencyListName: string; virtual; abstract; //returns the name of the list
     function GetCurrencyCount: Integer; virtual; abstract; // returns the number of currencies will be added
     function ToCurrency(ACurrency: TStringList): TCurrency; virtual; abstract; // convert a stored currency to a curency record
     function ToStringList(ACurrencyIndex: Integer): TStringList; virtual; abstract;
     function GetPropertyNames: TStringList; virtual; abstract;
   public
     constructor Create;
     destructor Destroy; override;
     property CurrencyPropertyNames: TStringList read GetPropertyNames;
     property CurrencyListName: string read GetCurrencyListName;
     function PropertiesByCurrencyName(AName: string): TStringList;
     function PropertiesByCurrencyIndex(AIndex: Integer): TStringList;
     function CurrencyByName(AName: string): TCurrency;
     function CurrencyByIndex(AIndex: Integer): TCurrency;
     property Count: Integer read GetCount;

 end;

  { TISO4217CurrencyList }

  TISO4217CurrencyList = class(TCustomCurrencyList)
    protected
      function GetCurrencyListName: string;  override;
      function GetCurrencyCount: Integer; override;
      function ToCurrency(ACurrency: TStringList): TCurrency; override;
      function ToStringList(ACurrencyIndex: Integer): TStringList; override;
      function GetPropertyNames: TStringList; override;
    end;


   type
    { TCurrencyManager }

    TCurrencyManager = class
    private
      fCurrencyList: TStringList;
      function GetCurrencyLists: TStringList;
      function GetISO4217Currencies: TStringList;
    protected
      procedure RegisterCurrencyList(ACurrencyList: TCustomCurrencyList);
    public
      constructor Create;
      destructor Destroy; override;
      function ISO4217CurrencyByName(AName: string): TCurrency;
      property CurrencyLists: TStringList read GetCurrencyLists;
      property ISO4217Currencies: TStringList read GetISO4217Currencies;

    end;



var
  CurrencyManager: TCurrencyManager; //TODO: change this to specific currency types manager (ISO4217, Stocks, Mutua Funds, etc)

implementation

uses math;

{ TISO4217CurrencyList }

const

  //TODO: add other currencies....
  ISO4217CurrencyCount = 2;
  ISO4217Currency: array[0..ISO4217CurrencyCount-1,0..4] of string =
    (('Real','Brasil','BRL','986','2'),
     ('US Dollar','United States','USD','840','2')
    );

function TISO4217CurrencyList.GetCurrencyListName: string;
begin
  Result:= 'ISO4217 Currency';
end;

function TISO4217CurrencyList.GetCurrencyCount: Integer;
begin
  Result:= ISO4217CurrencyCount;
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
  Result:= TStringList.Create;
  if (ACurrencyIndex < 0) or (ACurrencyIndex >= ISO4217CurrencyCount) then exit;

  Result.Add(ISO4217Currency[ACurrencyIndex,0]);
  Result.Add(ISO4217Currency[ACurrencyIndex,1]);
  Result.Add(ISO4217Currency[ACurrencyIndex,2]);
  Result.Add(ISO4217Currency[ACurrencyIndex,3]);
  Result.Add(ISO4217Currency[ACurrencyIndex,4]);
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

function TCurrencyManager.GetCurrencyLists: TStringList;
begin
  Result:= TStringList.Create;
  Result.Assign(fCurrencyList);
end;

procedure TCurrencyManager.RegisterCurrencyList(
  ACurrencyList: TCustomCurrencyList);
begin
  fCurrencyList.AddObject(ACurrencyList.CurrencyListName ,ACurrencyList);
end;

constructor TCurrencyManager.Create;
begin
  fCurrencyList:= TStringList.Create;
  RegisterCurrencyList(TISO4217CurrencyList.Create);
end;

destructor TCurrencyManager.Destroy;
begin
  fCurrencyList.Free;
  inherited Destroy;
end;

function TCurrencyManager.GetISO4217Currencies: TStringList;
var
  i: integer;
  ISO4217: TCustomCurrencyList;
begin
  Result:= TStringList.Create;
  ISO4217:= fCurrencyList.Objects[0] as TISO4217CurrencyList;
  for i:= 0 to ISO4217.Count - 1 do
    Result.Add(ISO4217.CurrencyByIndex(i).Name);
end;


function TCurrencyManager.ISO4217CurrencyByName(AName: string): TCurrency;
var
  ISO4217: TCustomCurrencyList;
begin
  ISO4217:= fCurrencyList.Objects[0] as TISO4217CurrencyList;
  Result:= ISO4217.CurrencyByName(AName);
end;



initialization
  CurrencyManager:= TCurrencyManager.Create;

finalization
  CurrencyManager.Free;

end.

