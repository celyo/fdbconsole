unit BaseEditor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, BaseView, sqldb;

type
  IBaseEditor = interface(IBaseView)
    ['{EA776318-7E3D-4E75-BD6F-B91E2BF008A3}']
    function GetConnection: TSQLConnection;
    function IsModified: Boolean;
  end;

implementation

end.

