unit LogUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, LCLProc;

type
  TLogMode = (lmNone, lmTrace, lmDebug, lmInfo, lmWarning, lmError);

  function LogModeToStr(pMode : TLogMode) : String;
  function StrToLogMode(pMode : String) : TLogMode;

  procedure SetLogFile(pFileName : String);
  function GetLogFile : String;
  procedure SetLogMode(pMode : TLogMode);
  function GetLogMode : TLogMode;

  procedure LogError(pText : String);
  procedure LogWarning(pText : String);
  procedure LogInfo(pText : String);
  procedure LogDebug(pText : String);
  procedure LogTrace(pText : String);

implementation

var
  FFileName : String = '';
  FLogMode : TLogMode = lmNone;
  FHandle : THandle = THandle(-1);

procedure InternalCloseFile;
begin
  if FHandle <> feInvalidHandle then
  begin
    FileClose(FHandle);
    FHandle := feInvalidHandle;
  end;
end;

procedure InternalOpenFile;
begin
  if FFileName = '' then FFileName := ChangeFileExt(Application.ExeName,'.log');
  if FHandle <> feInvalidHandle then InternalCloseFile;
  if FileExists(FFileName) then
  begin
    FHandle := FileOpen(FFileName, fmOpenWrite or fmShareDenyWrite);
  end
  else
  begin
    FHandle := FileCreate(FFileName);
  end;
  if FHandle = feInvalidHandle then Raise Exception.CreateFmt('Cannot open file "%s"!',[FFileName]);
  FileSeek(FHandle,0,fsFromEnd);
end;

procedure SetLogFile(pFileName: String);
begin
  FFileName := pFileName;
  InternalCloseFile;
end;

function GetLogFile: String;
begin
  Result := FFileName;
end;

function LogModeToStr(pMode : TLogMode) : String;
begin
  case pMode of
    lmNone : Result := 'NONE';
    lmTrace : Result := 'TRACE';
    lmDebug : Result := 'DEBUG';
    lmInfo : Result := 'INFO';
    lmWarning : Result := 'WARNING';
    lmError : Result := 'ERROR';
    else Result := '';
  end; // case
end;

function StrToLogMode(pMode: String): TLogMode;
begin
  case UpperCase(pMode) of
    'NONE' : Result := lmNone;
    'TRACE' : Result := lmTrace;
    'DEBUG' : Result := lmDebug;
    'INFO' : Result := lmInfo;
    'WARNING' : Result := lmWarning;
    'ERROR' : Result := lmError;
    else Result := lmNone;
  end; // case
end;

procedure LogMessage(pMode : TLogMode; pText : String);
var
  aStr : String;
  aMode : String;
begin
  if FHandle = feInvalidHandle then InternalOpenFile;
  aMode := LogModeToStr(pMode);
//  if aMode <> '' then aMode := '[' + aMode + ']';
  aStr := '[' + FormatDateTime('DD.MM.YYYY HH:nn:ss.zzz',Now) + '] ' + aMode + ': ' + pText + LineEnding;
  FileWrite(FHandle,&aStr[1], Length(aStr));
  if IsConsole then Writeln(aStr);
end;


procedure SetLogMode(pMode: TLogMode);
begin
  FLogMode := pMode;
end;

function GetLogMode: TLogMode;
begin
  Result := FLogMode;
end;

procedure LogError(pText: String);
begin
  if FLogMode <= lmError then LogMessage(lmError, pText);
end;

procedure LogWarning(pText: String);
begin
  if FLogMode <= lmWarning then LogMessage(lmWarning, pText);
end;

procedure LogInfo(pText: String);
begin
  if FLogMode <= lmInfo then LogMessage(lmInfo, pText);
end;

procedure LogDebug(pText: String);
begin
  if FLogMode <= lmDebug then LogMessage(lmDebug, pText);
end;

procedure LogTrace(pText: String);
begin
  if FLogMode <= lmTrace then LogMessage(lmTrace, pText);
end;

initialization

finalization
  InternalCloseFile;
end.

