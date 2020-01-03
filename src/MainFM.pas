unit MainFM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    LeftPanel: TPanel;
    MainPanel: TPanel;
    PageControl: TPageControl;
    Splitter1: TSplitter;
    StatusBar: TStatusBar;
    ToolBar: TToolBar;
    procedure FormCreate(Sender: TObject);
  private
    procedure HandleException(Sender: TObject; E: Exception);
    procedure SetFormCaption;

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses
  Globals, LogUtils;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.AddOnExceptionHandler(@HandleException);

  LogUtils.SetLogMode(LogUtils.StrToLogMode(gSettings.LogMode));

  SetFormCaption;
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

