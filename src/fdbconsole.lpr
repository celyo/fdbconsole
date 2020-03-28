program fdbconsole;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainFM, Settings, LogUtils, Globals, ConnectionInfo, MainDM,
  ConnectionsFM, ConnectionsView, BaseView, BaseEditor, SQLEditorFM, SQLEditor,
  EditConnectionDlg, DBUtils
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='FDBonsole';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TMainDataModule, MainDataModule);
  Application.CreateForm(TConnectionsForm, ConnectionsForm);
  Application.CreateForm(TSQLEditorForm, SQLEditorForm);
  Application.CreateForm(TEditConnectionDialog, EditConnectionDialog);
  Application.Run;
end.

