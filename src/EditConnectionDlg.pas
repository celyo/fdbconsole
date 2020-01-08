unit EditConnectionDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, EditBtn, BaseDlg, ConnectionInfo;

type

  { TEditConnectionDialog }

  TEditConnectionDialog = class(TBaseDialog)
    btnTest: TBitBtn;
    CkbRemoteServer: TCheckBox;
    cbCharSet: TComboBox;
    edConnName: TEdit;
    edUserName: TEdit;
    edPassword: TEdit;
    edServerName: TEdit;
    edRole: TEdit;
    edDBName: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

{ TEditConnectionDialog }

procedure TEditConnectionDialog.FormCreate(Sender: TObject);
begin
  FItem := TConnectionInfo.Create;
end;

procedure TEditConnectionDialog.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FItem);
end;

procedure TEditConnectionDialog.Clear;
begin

end;

procedure TEditConnectionDialog.Load(pObject: TConnectionInfo);
begin

end;

procedure TEditConnectionDialog.Save(pObject: TConnectionInfo);
begin

end;

end.

