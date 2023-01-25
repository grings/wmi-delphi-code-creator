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

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ActiveX,
  ComObj,
  WbemScripting_TLB,
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
  FSWbemLocator: ISWbemLocator;
  FWMIService: ISWbemServices;
  FWbemObjectSet: ISWbemObjectSet;
  FWbemObject: ISWbemObject;
  FWbemPropertySet: ISWbemPropertySet; 
  TempObj: OleVariant;  
  oEnum: IEnumvariant;
  iValue: Cardinal;
begin                
  FSWbemLocator := CoSWbemLocator.Create;
  FWMIService   := FSWbemLocator.ConnectServer(WbemComputer, '[WMINAMESPACE]', WbemUser, WbemPassword, '', '', 0, nil);
  FWbemObjectSet:= FWMIService.ExecQuery('SELECT * FROM [WMICLASSNAME]','WQL', wbemFlagForwardOnly, nil);
  oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
  while oEnum.Next(1, TempObj, iValue) = 0 do
  begin
    FWbemObject     := IUnknown(TempObj) as ISWBemObject;
    FWbemPropertySet:= FWbemObject.Properties_;
  
[DELPHICODE]	    
    Writeln('');
    TempObj:=Unassigned;
  end;
end;


begin
 try
    CoInitialize(nil);
    try
      Get[WMICLASSNAME]Info;
    finally
      CoUninitialize;
    end;
 except
    on E:EOleException do
        Writeln(Format('EOleException %s %x', [E.Message,E.ErrorCode])); 
    on E:Exception do
        Writeln(E.Classname, ':', E.Message);
 end;
 Writeln('Press Enter to exit');
 Readln;      
end.