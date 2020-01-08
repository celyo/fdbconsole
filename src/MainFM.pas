unit MainFM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls, BaseEditor, ConnectionsView;

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
  private
    FConnectionsView: IConnectionsView;

    function ActiveEditor: IBaseEditor;
    procedure HandleException(Sender: TObject; E: Exception);
    procedure SetFormCaption;

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses
  Globals, LogUtils, ConnectionsFM, SQLEditorFM;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.AddOnExceptionHandler(@HandleException);

  LogUtils.SetLogMode(LogUtils.StrToLogMode(gSettings.LogMode));

  SetFormCaption;

  FConnectionsView := CreateConnectionsView(LeftPanel);

  CreateSQLEditor(PageControl.AddTabSheet, nil);
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


end.

