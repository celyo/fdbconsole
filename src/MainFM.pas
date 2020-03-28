unit MainFM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls, BaseEditor, ConnectionsView, DBUtils;

type

  { TMainForm }

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    LeftPanel: TPanel;
    MainPanel: TPanel;
    miTools: TMenuItem;
    miAbout: TMenuItem;
    miHelp: TMenuItem;
    miView: TMenuItem;
    miEdit: TMenuItem;
    miDatabase: TMenuItem;
    PageControl: TPageControl;
    MainToolBar: TToolBar;
    tbbCloseTab: TToolButton;
    TabToolBar: TToolBar;
    TopPanel: TPanel;
    Splitter: TSplitter;
    StatusBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FConnectionsView: IConnectionsView;
    FConnetions: TConnectionHolderList;

    function ActiveEditor: IBaseEditor;
    procedure HandleException(Sender: TObject; E: Exception);
    procedure SetFormCaption;
    procedure LoadConnections;
  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses
  Globals, LogUtils, ConnectionsFM, SQLEditorFM, ConnectionInfo;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FConnetions := TConnectionHolderList.Create(true);

  Application.AddOnExceptionHandler(@HandleException);

  LogUtils.SetLogMode(LogUtils.StrToLogMode(gSettings.LogMode));

  SetFormCaption;

  LoadConnections;

  FConnectionsView := CreateConnectionsView(LeftPanel, FConnetions);
  FConnectionsView.Reload;


  CreateSQLEditor(PageControl.AddTabSheet, nil);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FConnetions.Free;
end;

function TMainForm.ActiveEditor: IBaseEditor;
var
  aIndex : Integer;
begin
  Result := nil;

  for aIndex := 0 to PageControl.PageCount - 1 do
  begin
    if (PageControl.Page[aIndex].ComponentCount > 0) and (PageControl.Page[aIndex].Components[0] is IBaseEditor) then
    begin
      Result := PageControl.Page[aIndex].Components[0] as IBaseEditor;
      Exit;
    end;
  end;
end;

procedure TMainForm.HandleException(Sender: TObject; E: Exception);
begin
  LogUtils.LogError(E.Message);
  MessageDlg('Error', E.Message, mtError, [mbOK], 0);
end;

procedure TMainForm.SetFormCaption;
var
  aStrVersion : String;
begin
  aStrVersion := AppVersion;

  Caption:= Format('%s (%s)',[Application.Title, aStrVersion]);
end;

procedure TMainForm.LoadConnections;
var
  aConnInfo: TConnectionInfo;
begin
  FConnetions.Clear;

  //DUMMY
  aConnInfo := TConnectionInfo.Create();
  aConnInfo.Name := 'Connection A';
  aConnInfo.Host := 'localhost';
  aConnInfo.Port := 3050;
  aConnInfo.Database := 'dba.fdb';
  aConnInfo.Dialect := 3;
  aConnInfo.CharSet := 'NONE';
  aConnInfo.Role := '';
  aConnInfo.User := 'user a';
  aConnInfo.Password := 'password a';

  FConnetions.Add(TConnectionHolder.Create(aConnInfo));

  aConnInfo := TConnectionInfo.Create();
  aConnInfo.Name := 'Connection B';
  aConnInfo.Host := 'foreignhost';
  aConnInfo.Port := 3151;
  aConnInfo.Database := 'dbb.fdb';
  aConnInfo.Dialect := 3;
  aConnInfo.CharSet := 'NONE';
  aConnInfo.Role := '';
  aConnInfo.User := 'user b';
  aConnInfo.Password := 'password b';

  FConnetions.Add(TConnectionHolder.Create(aConnInfo));


  //TODO
end;


end.

