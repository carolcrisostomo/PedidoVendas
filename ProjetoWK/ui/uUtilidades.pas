unit uUtilidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPanels, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, VCLTee.TeCanvas, Vcl.Imaging.pngimage, Vcl.Grids;

type
  TUtilidades = class
 public
   class procedure ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);
   class procedure AplicarArredondamento(AForm: TComponent; ARaio: Integer = 10);
 end;

implementation

class procedure TUtilidades.ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);
var
  R : TRect;
  Rgn : HRGN;
begin
  with Componente do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Radius, Radius);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

class procedure TUtilidades.AplicarArredondamento(AForm: TComponent; ARaio: Integer);
var
  I: Integer;
  Comp: TComponent;
begin
  if not Assigned(AForm) then
    Exit;

  for I := 0 to AForm.ComponentCount - 1 do
  begin
    Comp := AForm.Components[I];

    if Comp is TEdit then
    begin
      ArredondarComponente(TEdit(Comp), ARaio);
    end
    else
    if Comp is TCardPanel then
    begin
      ArredondarComponente(TCardPanel(Comp), ARaio);
    end
    else
    if Comp is TStackPanel then
    begin
      ArredondarComponente(TStackPanel(Comp), ARaio);
    end
    else
    if Comp is TForm then
    begin
      ArredondarComponente(TForm(Comp), ARaio);
    end
    else
    if Comp is TStringGrid then
    begin
      ArredondarComponente(TStringGrid(Comp), ARaio);
    end;
  end;
end;

end.
