unit ConnectionsFM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus, MainDM, DBUtils, ConnectionsView;

type

  { TConnectionsForm }

  TConnectionsForm = class(TForm, IConnectionsView)
    tvConnections: TTreeView;
    pmConnections: TPopupMenu;
    miNewConnection: TMenuItem;
    miNewDomain: TMenuItem;
    miNewTable: TMenuItem;
    miNewView: TMenuItem;
    miNewProcedure: TMenuItem;
    miNewTrigger: TMenuItem;
    miNewGenerator: TMenuItem;
    miNewException: TMenuItem;
    miNewUDF: TMenuItem;
    miNewRole: TMenuItem;
    miRemoveConnectiion: TMenuItem;
    miConnect: TMenuItem;
    miDisconnect: TMenuItem;
    miCreateDB: TMenuItem;
    miDropDB: TMenuItem;
    miBackupDB: TMenuItem;
    miRestoreDB: TMenuItem;
    MenuItem9: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    miEditConnection: TMenuItem;
    procedure miEditConnectionClick(Sender: TObject);
    procedure miNewConnectionClick(Sender: TObject);
    procedure miRemoveConnectiionClick(Sender: TObject);
  private
    FConnections: TConnectionHolderList;

    FNewConnectionListener: TConnectionListener;
    FEditConnectionListener: TConnectionListener;
    FRemoveConnectionListener: TConnectionListener;

    function CreateConnectionNode(pConnection: TConnectionHolder): TTreeNode;
  public
    procedure Reload;

    procedure NewConnection;
    procedure EditConnection;
    procedure RemoveConnection;

    procedure SetConnections(pConnections: TConnectionHolderList);
    function GetConnections: TConnectionHolderList;

    procedure SetNewConnectionListener(pListener: TConnectionListener);
    procedure SetEditConnectionListener(pListener: TConnectionListener);
    procedure SetRemoveConnectionListener(pListener: TConnectionListener);

    function AsForm: TForm;
  end;

var
  ConnectionsForm: TConnectionsForm;

function CreateConnectionsView(pParent: TWinControl; pConnections: TConnectionHolderList): IConnectionsView;

implementation

{$R *.lfm}

uses
  ConnectionInfo, EditConnectionDlg;

function CreateConnectionsView(pParent: TWinControl; pConnections: TConnectionHolderList): IConnectionsView;
var
  aForm: TConnectionsForm;
begin
  aForm := TConnectionsForm.Create(pParent);
  aForm.Parent := pParent;
  aForm.Align := alClient;
  aForm.BorderStyle := bsNone;
  aForm.Show;
  pParent.Caption := aForm.Caption;

  aForm.SetConnections(pConnections);

  Result := aForm;
end;

{ TConnectionsForm }

procedure TConnectionsForm.miNewConnectionClick(Sender: TObject);
begin
  NewConnection;
end;

procedure TConnectionsForm.miRemoveConnectiionClick(Sender: TObject);
begin
  RemoveConnection;
end;

procedure TConnectionsForm.miEditConnectionClick(Sender: TObject);
begin
  EditConnection;
end;

function TConnectionsForm.CreateConnectionNode(pConnection: TConnectionHolder): TTreeNode;
begin
  Result := tvConnections.Items.AddObject(nil, pConnection.ConnInfo.Name, pConnection);
  Result.ImageIndex := 0;
  Result.SelectedIndex := 0;
end;

procedure TConnectionsForm.Reload;
var
  aIndex: Integer;
begin
  tvConnections.BeginUpdate;
  try
    tvConnections.Items.Clear;

    if Assigned(FConnections) and (FConnections.Count > 0) then
    begin
      for aIndex := 0 to FConnections.Count - 1 do
      begin
        CreateConnectionNode(FConnections[aIndex]);
      end;
    end;
  finally
    tvConnections.EndUpdate;
  end;
end;

procedure TConnectionsForm.NewConnection;
var
  aEditConnDlg: TEditConnectionDialog;
  aConnHolder: TConnectionHolder;
  aConnInfo: TConnectionInfo;
begin
  aEditConnDlg := TEditConnectionDialog.Create(self);
  try
    aEditConnDlg.Caption := 'New Connection';
    if aEditConnDlg.ShowModal = mrOK then
    begin
      aConnInfo := TConnectionInfo.Create;
      aConnInfo.Assign(aEditConnDlg.Item);
      aConnHolder := TConnectionHolder.Create(aConnInfo);

      FConnections.Add(aConnHolder);
      Reload;

      if Assigned(FNewConnectionListener) then
      begin
        FNewConnectionListener(aConnHolder);
      end;
    end;
  finally
    aEditConnDlg.Free;
  end;


end;

procedure TConnectionsForm.EditConnection;
var
  aEditConnDlg: TEditConnectionDialog;
  aConnHolder: TConnectionHolder;
begin
  if (tvConnections.Selected <> nil) and (tvConnections.Selected.Data <> nil) then
  begin
    aConnHolder := TConnectionHolder(tvConnections.Selected.Data);

    aEditConnDlg := TEditConnectionDialog.Create(self);
    try
      aEditConnDlg.Caption := 'Edit Connection';
      aEditConnDlg.Item.Assign(aConnHolder.ConnInfo);

      if aEditConnDlg.ShowModal = mrOK then
      begin
        aConnHolder.ConnInfo.Assign(aEditConnDlg.Item);
        UpdateConnection(aConnHolder.Connection, aConnHolder.ConnInfo);

        if Assigned(FEditConnectionListener) then
        begin
          FEditConnectionListener(aConnHolder);
        end;
      end;
    finally
      aEditConnDlg.Free;
    end;
  end;
end;

procedure TConnectionsForm.RemoveConnection;
var
  aConnHolder: TConnectionHolder;
begin
  if (tvConnections.Selected <> nil) and (tvConnections.Selected.Data <> nil) then
  begin
    aConnHolder := TConnectionHolder(tvConnections.Selected.Data);

    if MessageDlg('Delete Connection', 'Do you realy want ot delete this connection?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      if Assigned(FRemoveConnectionListener) then
      begin
        FRemoveConnectionListener(aConnHolder);
      end;

      FConnections.Remove(aConnHolder);
      Reload;
    end;
  end;
end;

procedure TConnectionsForm.SetConnections(pConnections: TConnectionHolderList);
begin
  FConnections := pConnections;
end;

function TConnectionsForm.GetConnections: TConnectionHolderList;
begin
  Result := FConnections;
end;

procedure TConnectionsForm.SetNewConnectionListener(
  pListener: TConnectionListener);
begin
  FNewConnectionListener := pListener;
end;

procedure TConnectionsForm.SetEditConnectionListener(
  pListener: TConnectionListener);
begin
  FEditConnectionListener := pListener;
end;

procedure TConnectionsForm.SetRemoveConnectionListener(
  pListener: TConnectionListener);
begin
  FRemoveConnectionListener := pListener;
end;

function TConnectionsForm.AsForm: TForm;
begin
  Result := Self;
end;

end.

