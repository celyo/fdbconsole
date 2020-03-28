unit EditConnectionDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, EditBtn, Spin, BaseDlg, ConnectionInfo;

type

  { TEditConnectionDialog }

  TEditConnectionDialog = class(TBaseDialog)
    btnTest: TBitBtn;
    CkbRemoteServer: TCheckBox;
    cbCharSet: TComboBox;
    edConnName: TEdit;
    edUserName: TEdit;
    edPassword: TEdit;
    edHost: TEdit;
    edRole: TEdit;
    edDBName: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    sePort: TSpinEdit;
    procedure btnOKClick(Sender: TObject);
    procedure CkbRemoteServerChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FItem: TConnectionInfo;

    procedure Clear;
    procedure Load(pObject: TConnectionInfo);
    procedure Save(pObject: TConnectionInfo);
  public
    property Item: TConnectionInfo read FItem;
  end;

var
  EditConnectionDialog: TEditConnectionDialog;

implementation

{$R *.lfm}

uses
  Globals;

{ TEditConnectionDialog }

procedure TEditConnectionDialog.FormCreate(Sender: TObject);
begin
  FItem := TConnectionInfo.Create;
  Clear;
end;

procedure TEditConnectionDialog.CkbRemoteServerChange(Sender: TObject);
begin
  edHost.Enabled := CkbRemoteServer.Checked;
  sePort.Enabled := CkbRemoteServer.Checked;

  if not CkbRemoteServer.Checked then
  begin
    edHost.Text := DEFAULT_HOST;
    sePort.Value := DEFAULT_PORT;
  end;
end;

procedure TEditConnectionDialog.btnOKClick(Sender: TObject);
begin
  Save(FItem);
  ModalResult := mrOK;
end;

procedure TEditConnectionDialog.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FItem);
end;

procedure TEditConnectionDialog.FormShow(Sender: TObject);
begin
  Load(FItem);
end;

procedure TEditConnectionDialog.Clear;
begin
  edConnName.Text := '';
  CkbRemoteServer.Checked := false;
  edHost.Text := DEFAULT_HOST;
  sePort.Value := DEFAULT_PORT;
  edDBName.Text := '';
  edUserName.Text := '';
  edPassword.Text := '';
  edRole.Text := '';
  cbCharSet.ItemIndex := cbCharSet.Items.IndexOf(DEFAULT_CHARSET);
  CkbRemoteServerChange(CkbRemoteServer);
end;

procedure TEditConnectionDialog.Load(pObject: TConnectionInfo);
begin
  edConnName.Text := pObject.Name;
  CkbRemoteServer.Checked := not (SameText(pObject.Host, DEFAULT_HOST) and (pObject.Port = DEFAULT_PORT));
  edHost.Text := pObject.Host;
  sePort.Value := pObject.Port;
  edDBName.Text := pObject.Database;
  edUserName.Text := pObject.User;
  edPassword.Text := pObject.Password;
  edRole.Text := pObject.Role;
  cbCharSet.ItemIndex := cbCharSet.Items.IndexOf(pObject.CharSet);
  CkbRemoteServerChange(CkbRemoteServer);
end;

procedure TEditConnectionDialog.Save(pObject: TConnectionInfo);
begin
  pObject.Name := edConnName.Text;
  pObject.Host := edHost.Text;
  pObject.Port := sePort.Value;
  pObject.Database := edDBName.Text;
  pObject.Dialect := DEFAULT_DIALECT;
  pObject.CharSet := cbCharSet.Text;
  pObject.Role := edRole.Text;
  pObject.User := edUserName.Text;
  pObject.Password := edPassword.Text;
end;

end.

