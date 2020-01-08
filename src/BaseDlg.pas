unit BaseDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, LCLType, Buttons;

type

  { TBaseDialog }

  TBaseDialog = class(TForm)
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    pnlMain: TPanel;
    pnlButtons: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  protected
//    function  DialogChar(var Message: TLMKey): boolean; override;
  public
    constructor Create(TheOwner: TComponent); override;
  end;

var
  BaseDialog: TBaseDialog;

implementation

{$R *.lfm}

{ TBaseDialog }

procedure TBaseDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    btnCancel.Click;
  end
  else if (Key = VK_RETURN) and (ssCtrl in Shift) then
  begin
    btnOK.Click;
  end;
end;

constructor TBaseDialog.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  btnOK.ModalResult := mrNone;
  btnCancel.ModalResult := mrCancel;
  KeyPreview := true;
end;

end.

