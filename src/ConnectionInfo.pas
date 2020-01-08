unit ConnectionInfo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TConnectionInfo }

  TConnectionInfo = class(TPersistent)
  private
    FCharSet: String;
    FDatabase: String;
    FDialect: Integer;
    FHost: String;
    FName: String;
    FPassword: String;
    FPort: Integer;
    FRole: String;
    FUser: String;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    procedure Clear;

    property Name: String read FName write FName;
    property Host: String read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property Database: String read FDatabase write FDatabase;
    property Dialect: Integer read FDialect write FDialect;
    property CharSet: String read FCharSet write FCharSet;
    property Role: String read FRole write FRole;
    property User: String read FUser write FUser;
    property Password: String read FPassword write FPassword;
  end;

implementation

{ TConnectionInfo }

procedure TConnectionInfo.AssignTo(Dest: TPersistent);
begin
  if Dest <> nil then
  begin
    Dest.Name := Name;
    Dest.Host := Host;
    Dest.Port := Port;
    Dest.Database := Database;
    Dest.Dialect := Dialect;
    Dest.CharSet := CharSet;
    Dest.Role := Role;
    Dest.User := User;
    Dest.Password := Password;
  end;
end;

procedure TConnectionInfo.Clear;
begin
  Name := '';
  Host := '';
  Port := 0;
  Database := '';
  Dialect := 0;
  CharSet := '';
  Role := '';
  User := '';
  Password := '';
end;

end.

