unit Settings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms;

type

  { TSettings }

  TSettings = class
    private
      FDBName: String;
      FDBPass: String;
      FDBServer: String;
      FDBUser: String;
      FFileName : String;
      FLogMode: String;
    private
      function IsTime(pStr : String) : Boolean;
    public
      constructor Create;reintroduce; overload;
      constructor Create(pFileName : String);reintroduce; overload;
      destructor Destroy;override;
      procedure LoadSettings;overload;
      procedure LoadSettings(pFileName : String);overload;
      procedure SaveSettings;overload;
      procedure SaveSettings(pFileName : String);overload;

      //Database
      property DBServer : String read FDBServer write FDBServer;
      property DBName : String read FDBName write FDBName;
      property DBUser : String read FDBUser write FDBUser;
      property DBPass : String read FDBPass write FDBPass;

      //Common
      property LogMode : String read FLogMode write FLogMode;
  end;

implementation

uses
  IniFiles;

{ TSettings }

function TSettings.IsTime(pStr: String): Boolean;
begin
  Result := false;
  if Length(pStr) <> 5 then Exit;
  if not (pStr[1] in ['0'..'9']) then Exit;
  if not (pStr[2] in ['0'..'9']) then Exit;
  if not (pStr[3] = ':') then Exit;
  if not (pStr[4] in ['0'..'9']) then Exit;
  if not (pStr[5] in ['0'..'9']) then Exit;
  if StrToIntDef(Copy(pStr, 1, 2),-1) < 0 then Exit;
  if StrToIntDef(Copy(pStr, 1, 2),-1) > 24 then Exit;
  if StrToIntDef(Copy(pStr, 4, 2),-1) < 0 then Exit;
  if StrToIntDef(Copy(pStr, 4, 2),-1) > 59 then Exit;

  Result := true;
end;

constructor TSettings.Create;
begin
  FFileName := '';

  FDBServer := 'localhost';
  FDBName := ChangeFileExt(Application.ExeName,'.fdb');
  FDBUser := 'SYSDBA';
  FDBPass := 'masterkey';

  FLogMode := 'ERROR';
end;

constructor TSettings.Create(pFileName: String);
begin
  Create;
  FFileName := pFileName;
end;

destructor TSettings.Destroy;
begin
  //just in case
  inherited Destroy;
end;

procedure TSettings.LoadSettings;
begin
  LoadSettings(FFileName);
end;

procedure TSettings.LoadSettings(pFileName: String);
var
  aFile : TIniFile;
begin
  aFile := TIniFile.Create(pFileName);
  try
    FDBServer := aFile.ReadString('Database','Server','localhost');
    FDBName := aFile.ReadString('Database','Name',ChangeFileExt(pFileName,'.fdb'));
    FDBUser := aFile.ReadString('Database','User','SYSDBA');
    FDBPass := aFile.ReadString('Database','Password','masterkey');

    if FDBName <> '' then
    begin
      if (copy(FDBName,1,1) <> '/') and (copy(FDBName,1,2) <> '//')       // not linux abs path
         and (copy(FDBName,1,1) <> '\') and (copy(FDBName,1,2) <> '\\')   // not network path
         and (copy(FDBName,2,2) <> ':\') then                             // not windows abs path
      begin
        FDBName := IncludeTrailingPathDelimiter(ExtractFileDir(pFileName)) + FDBName;
      end;
      FDBName := ExpandFileName(FDBName);
    end;

    FLogMode := aFile.ReadString('Common','LogMode','ERROR');

  finally
    aFile.Free;
  end;
end;

procedure TSettings.SaveSettings;
begin
  SaveSettings(FFileName);
end;

procedure TSettings.SaveSettings(pFileName: String);
var
  aFile : TIniFile;
begin
  aFile := TIniFile.Create(pFileName);
  try
    aFile.WriteString('Database','Server',FDBServer);
    aFile.WriteString('Database','Name',FDBName);
    aFile.WriteString('Database','User',FDBUser);
    aFile.WriteString('Database','Password',FDBPass);

    aFile.WriteString('Common','LogMode',FLogMode);

    aFile.UpdateFile;
  finally
    aFile.Free;
  end;
end;

end.

