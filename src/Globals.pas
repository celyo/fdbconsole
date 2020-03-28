unit Globals;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Settings;

const
  AppVersion : String = '0.1.0';
  DEFAULT_HOST: String = 'localhost';
  DEFAULT_PORT: Integer = 3050;
  DEFAULT_DIALECT: Integer = 3;
  DEFAULT_CHARSET: String = 'NONE';


var
  gSettings : TSettings;

implementation

initialization
begin
  gSettings := TSettings.Create(ChangeFileExt(Application.ExeName,'.cfg'));
  gSettings.LoadSettings;
end;

finalization
begin
  if gSettings <> nil then FreeAndNil(gSettings);
end;

end.

