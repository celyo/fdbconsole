unit ConnectionsView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, BaseView, DBUtils;

type
  TConnectionListener = procedure(pConnectionHolder: TConnectionHolder);

  { IConnectionsView }

  IConnectionsView = interface(IBaseView)
    ['{0322AA84-AE7A-4955-A4C0-B2193B798727}']

    procedure Reload;

    procedure NewConnection;
    procedure EditConnection;
    procedure RemoveConnection;

    procedure SetConnections(pConnections: TConnectionHolderList);
    function GetConnections: TConnectionHolderList;

    procedure SetNewConnectionListener(pListener: TConnectionListener);
    procedure SetEditConnectionListener(pListener: TConnectionListener);
    procedure SetRemoveConnectionListener(pListener: TConnectionListener);
  end;

implementation

end.

