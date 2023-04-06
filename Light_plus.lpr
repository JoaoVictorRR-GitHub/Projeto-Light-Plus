program Light_plus;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Forms, Interfaces, unit_Principal
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Light Plus';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tform_Principal_, form_Principal_);
  Application.Run;
end.

