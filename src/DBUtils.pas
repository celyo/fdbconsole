unit DBUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fgl, sqldb, ConnectionInfo;

type

  { TConnectionHolder }

  TConnectionHolder = class
  private
    FConnection: TSQLConnection;
    FConnInfo: TConnectionInfo;
  public
    constructor Create(pConnInfo: TConnectionInfo; pConnection: TSQLConnection); reintroduce; overload;
    constructor Create(pConnInfo: TConnectionInfo); reintroduce; overload;
    destructor Destroy(); override;

    property ConnInfo: TConnectionInfo read FConnInfo;
    property Connection: TSQLConnection read FConnection;
  end;

  TConnectionHolderList = specialize TFPGObjectList<TConnectionHolder>;



  function CreateConnection(pConnInfo: TConnectionInfo): TSQLConnection;
  procedure UpdateConnection(pConnection: TSQLConnection; pConnInfo: TConnectionInfo);

implementation

uses
  Globals, IBConnection;

function CreateConnection(pConnInfo: TConnectionInfo): TSQLConnection;
var
  aConn: TIBConnection;
  aTrn: TSQLTransaction;
begin
  aConn := TIBConnection.Create(nil);

  UpdateConnection(aConn, pConnInfo);

  aTrn := TSQLTransaction.Create(aConn);
  aTrn.DataBase := aConn;
  aTrn.Action := caRollback;
  aTrn.Params.Add('isc_tpb_write');
  aTrn.Params.Add('isc_tpb_read_committed');
  aTrn.Params.Add('isc_tpb_nowait');
  aTrn.Params.Add('isc_tpb_rec_version');

  aConn.Transaction := aTrn;

  Result := aConn;
end;

procedure UpdateConnection(pConnection: TSQLConnection;
  pConnInfo: TConnectionInfo);
begin
  pConnection.HostName := pConnInfo.Host;
  if (pConnInfo.Port <> DEFAULT_PORT) then
  begin
    pConnection.HostName := pConnection.HostName + '/' + IntToStr(pConnInfo.Port);
  end;
  pConnection.DatabaseName := pConnInfo.Database;
  pConnection.UserName := pConnInfo.User;
  pConnection.Password := pConnInfo.Password;
  pConnection.Role := pConnInfo.Role;
  pConnection.CharSet := pConnInfo.CharSet;
  if pConnection is TIBConnection then
  begin
    (pConnection as TIBConnection).Dialect := pConnInfo.Dialect;
  end;
  pConnection.LoginPrompt := false;
end;

{ TConnectionHolder }

constructor TConnectionHolder.Create(pConnInfo: TConnectionInfo;
  pConnection: TSQLConnection);
begin
  inherited Create();

  FConnInfo := pConnInfo;
  FConnection := pConnection;
end;

constructor TConnectionHolder.Create(pConnInfo: TConnectionInfo);
begin
  Create(pConnInfo, CreateConnection(pConnInfo));
end;

destructor TConnectionHolder.Destroy();
begin
  inherited Destroy();
end;

end.

