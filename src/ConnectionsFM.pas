unit ConnectionsFM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus, ConnectionsView;

type

  { TConnectionsForm }

  TConnectionsForm = class(TForm, IConnectionsView)
    tvConnections: TTreeView;
    pmConnections: TPopupMenu;
    miRegisterDB: TMenuItem;
    miNewDomain: TMenuItem;
    miNewTable: TMenuItem;
    miNewView: TMenuItem;
    miNewProcedure: TMenuItem;
    miNewTrigger: TMenuItem;
    miNewGenerator: TMenuItem;
    miNewException: TMenuItem;
    miNewUDF: TMenuItem;
    miNewRole: TMenuItem;
    miUnregisterDB: TMenuItem;
    miConnect: TMenuItem;
    miDisconnect: TMenuItem;
    miCreateDB: TMenuItem;
    miDropDB: TMenuItem;
    miBackupDB: TMenuItem;
    miRestoreDB: TMenuItem;
    MenuItem9: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    miDBRegistrationInfo: TMenuItem;
  private

  public
     function AsForm: TForm;
  end;

var
  ConnectionsForm: TConnectionsForm;

function CreateConnectionsView(pParent: TWinControl): IConnectionsView;

implementation

{$R *.lfm}

function CreateConnectionsView(pParent: TWinControl): IConnectionsView;
var
  aForm: TConnectionsForm;
begin
  aForm := TConnectionsForm.Create(pParent);
  aForm.Parent := pParent;
  aForm.Align := alClient;
  aForm.BorderStyle := bsNone;
  aForm.Show;
  pParent.Caption := aForm.Caption;

  Result := aForm;
end;

{ TConnectionsForm }

function TConnectionsForm.AsForm: TForm;
begin
  Result := Self;
end;

end.

