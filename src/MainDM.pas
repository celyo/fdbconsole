unit MainDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls;

type

  { TMainDataModule }

  TMainDataModule = class(TDataModule)
    ImageList32: TImageList;
    ImageList16: TImageList;
  private

  public

  end;

var
  MainDataModule: TMainDataModule;

implementation

{$R *.lfm}

end.

