object FormSelecionarPedido: TFormSelecionarPedido
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Selecionar Pedido'
  ClientHeight = 420
  ClientWidth = 560
  Color = 16248550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object EdtBuscar: TEdit
    Left = 16
    Top = 16
    Width = 400
    Height = 23
    TabOrder = 0
    TextHint = 'Buscar pedido...'
    OnChange = EdtBuscarChange
  end
  object Grid: TStringGrid
    Left = 16
    Top = 48
    Width = 528
    Height = 300
    TabOrder = 1
    OnDblClick = GridDblClick
  end
  object BtnSelecionar: TButton
    Left = 360
    Top = 368
    Width = 90
    Height = 30
    Caption = 'Selecionar'
    TabOrder = 2
    OnClick = BtnSelecionarClick
  end
  object BtnCancelar: TButton
    Left = 454
    Top = 368
    Width = 90
    Height = 30
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = BtnCancelarClick
  end
end
