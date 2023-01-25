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
  Windows,
  {$IF CompilerVersion > 18.5}
  Forms,
  {$IFEND}
  SysUtils,
  ActiveX,
  ComObj,
  WbemScripting_TLB;

type
  TWmiAsyncEvent = class
  private
    FWQL: string;
    FSink: TSWbemSink;
    FLocator: ISWbemLocator;
    FServices: ISWbemServices;
    procedure EventReceived(ASender: TObject; const objWbemObject: ISWbemObject; const objWbemAsyncContext: ISWbemNamedValueSet);
  public
    procedure  Start;
    constructor Create;
    Destructor Destroy;override;
  end;
  
//Detect when a key was pressed in the console window
function KeyPressed:Boolean;
var
  lpNumberOfEvents: DWORD;
  lpBuffer: TInputRecord;
  lpNumberOfEventsRead: DWORD;
  nStdHandle: THandle;
begin
  Result:=false;
  nStdHandle := GetStdHandle(STD_INPUT_HANDLE);
  lpNumberOfEvents:=0;
  GetNumberOfConsoleInputEvents(nStdHandle,lpNumberOfEvents);
  if lpNumberOfEvents<> 0 then
  begin
    PeekConsoleInput(nStdHandle,lpBuffer,1,lpNumberOfEventsRead);
    if lpNumberOfEventsRead <> 0 then
    begin
      if lpBuffer.EventType = KEY_EVENT then
      begin
        if lpBuffer.Event.KeyEvent.bKeyDown then
          Result:=true
        else
          FlushConsoleInputBuffer(nStdHandle);
      end
      else
      FlushConsoleInputBuffer(nStdHandle);
    end;
  end;
end;

{ TWmiAsyncEvent }

constructor TWmiAsyncEvent.Create;
const
  strServer    ='.';
  strNamespace ='[WMINAMESPACE]';
  strUser      ='';
  strPassword  ='';
begin
  inherited Create;
  CoInitializeEx(nil, COINIT_MULTITHREADED);
  FLocator  := CoSWbemLocator.Create;
  FServices := FLocator.ConnectServer(strServer, strNamespace, strUser, strPassword, '', '', wbemConnectFlagUseMaxWait, nil);
  FSink     := TSWbemSink.Create(nil);
  FSink.OnObjectReady := EventReceived;
[DELPHIEVENTSWQL]
end;

destructor TWmiAsyncEvent.Destroy;
begin
  if FSink<>nil then
    FSink.Cancel;
  FLocator  :=nil;
  FServices :=nil;
  FSink     :=nil;
  CoUninitialize;
  inherited;
end;

procedure TWmiAsyncEvent.EventReceived(ASender: TObject;
  const objWbemObject: ISWbemObject;
  const objWbemAsyncContext: ISWbemNamedValueSet);
var
  PropVal: OLEVariant;
begin
  PropVal := objWbemObject;
[DELPHIEVENTSOUT] 
end;

procedure TWmiAsyncEvent.Start;
begin
  Writeln('Listening events...Press Any key to exit');
  FServices.ExecNotificationQueryAsync(FSink.DefaultInterface,FWQL,'WQL', 0, nil, nil);
end;

var
   AsyncEvent: TWmiAsyncEvent;
begin
 try
    AsyncEvent:=TWmiAsyncEvent.Create;
    try
      AsyncEvent.Start;
      //The next loop is only necessary in this sample console sample app
      //In VCL forms Apps you don't need use a loop
      while not KeyPressed do
      begin
          {$IF CompilerVersion > 18.5}
          Sleep(100);
          Application.ProcessMessages;
          {$IFEND}
      end;
    finally
      AsyncEvent.Free;
    end;
 except
    on E:EOleException do
        Writeln(Format('EOleException %s %x', [E.Message,E.ErrorCode]));  
    on E:Exception do
        Writeln(E.Classname, ':', E.Message);
 end;
end.