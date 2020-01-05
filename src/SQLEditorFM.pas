unit SQLEditorFM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, SynHighlighterSQL,
  SynEdit, sqldb, SQLEditor;

type

  { TSQLEditorForm }

  TSQLEditorForm = class(TForm, ISQLEditor)
    SynEdit1: TSynEdit;
    SynSQLSyn1: TSynSQLSyn;
    procedure FormCreate(Sender: TObject);
  private
    FConnection: TSQLConnection;

  public
    function AsForm: TForm;
    function GetConnection: TSQLConnection;
    function IsModified: Boolean;
  end;

var
  SQLEditorForm: TSQLEditorForm;

  function CreateSQLEditor(pParent: TWinControl; pConnection: TSQLConnection): ISQLEditor;

implementation

function CreateSQLEditor(pParent: TWinControl; pConnection: TSQLConnection): ISQLEditor;
var
  aForm: TSQLEditorForm;
begin
  aForm := TSQLEditorForm.Create(pParent);
  aForm.FConnection := pConnection;
  aForm.Parent := pParent;
  aForm.Align := alClient;
  aForm.BorderStyle := bsNone;
  aForm.Show;
  pParent.Caption := aForm.Caption;

  Result := aForm;
end;

{$R *.lfm}

{ TSQLEditorForm }

procedure TSQLEditorForm.FormCreate(Sender: TObject);
begin

end;

function TSQLEditorForm.AsForm: TForm;
begin
  Result := Self;
end;

function TSQLEditorForm.GetConnection: TSQLConnection;
begin
  Result := FConnection;
end;

function TSQLEditorForm.IsModified: Boolean;
begin
  Result := false;
end;

end.

