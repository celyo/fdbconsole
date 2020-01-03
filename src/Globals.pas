unit Globals;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Settings;

const
  AppVersion : String = '0.1.0';

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

