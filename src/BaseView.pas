unit BaseView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms;

type
  IBaseView = interface(IInterface)
    ['{E2AD45B3-9ACE-450B-8235-58304E66B70B}']
    function AsForm: TForm;
  end;

implementation

end.

