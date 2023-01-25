//-----------------------------------------------------------------------------------------------------
//     This code was generated by the Wmi Delphi Code Creator (WDCC) Version [VERSIONAPP]
//     https://github.com/RRUZ/wmi-delphi-code-creator
//     Blog http://theroadtodelphi.wordpress.com/wmi-delphi-code-creator/
//     Author Rodrigo Ruz V. (RRUZ) Copyright (C) 2011-2023 
//----------------------------------------------------------------------------------------------------- 
//
//     LIABILITY DISCLAIMER
//     THIS GENERATED CODE IS DISTRIBUTED "AS IS". NO WARRANTY OF ANY KIND IS EXPRESSED OR IMPLIED.
//     YOU USE IT AT YOUR OWN RISK. THE AUTHOR NOT WILL BE LIABLE FOR DATA LOSS,
//     DAMAGES AND LOSS OF PROFITS OR ANY OTHER KIND OF LOSS WHILE USING OR MISUSING THIS CODE.
//
//----------------------------------------------------------------------------------------------------
program GetWMI_Info;

{$mode objfpc} {$H+}

uses
  SysUtils,
  ActiveX,
  ComObj,
  Variants;
                
[HELPER_FUNCTIONS]
				
[WMICLASSDESC]
procedure  Get[WMICLASSNAME]Info;
const
  WbemUser            ='';
  WbemPassword        ='';
  WbemComputer        ='localhost';
  wbemFlagForwardOnly = $00000020;
var
  FSWbemLocator: OLEVariant;
  FWMIService: OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject: Variant;
  oEnum: IEnumvariant;
  sValue: string;   
begin;
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService   := FSWbemLocator.ConnectServer(WbemComputer, '[WMINAMESPACE]', WbemUser, WbemPassword);
  FWbemObjectSet:= FWMIService.ExecQuery('SELECT * FROM [WMICLASSNAME]','WQL',wbemFlagForwardOnly);
  oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
  while oEnum.Next(1, FWbemObject, nil) = 0 do
  begin
[DELPHICODE]	    
    Writeln('');
    FWbemObject:=Unassigned;
  end;
end;


begin
 try
    Get[WMICLASSNAME]Info;
 except
    on E:EOleException do
        Writeln(Format('EOleException %s %x', [E.Message,E.ErrorCode]));      
	on E:Exception do
        Writeln(E.Classname, ':', E.Message);
 end;
 Writeln('Press Enter to exit');
 Readln;    
end.