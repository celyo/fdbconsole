unit MainDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls;

type

  { TMainDataModule }

  TMainDataModule = class(TDataModule)
    ImageList: TImageList;
  private

  public

  end;

var
  MainDataModule: TMainDataModule;

implementation

{$R *.lfm}

end.

