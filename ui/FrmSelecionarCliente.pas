unit FrmSelecionarCliente;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.Grids,
  System.Generics.Collections, FireDAC.Comp.Client, uUtilidades,
  uCliente, uClienteController, Vcl.Controls;

type
  TFormSelecionarCliente = class(TForm)
    EdtBuscar: TEdit;
    Grid: TStringGrid;
    BtnSelecionar: TButton;
    BtnCancelar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtBuscarChange(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FController: TClienteController;
    FClientes: TObjectList<TCliente>;
    FClienteSelecionado: TCliente;
    Conn: TFDConnection;
    FUtilidades: TUtilidades;
    procedure ConfigurarGrid;
    procedure AjustarColunas(Grid: TStringGrid);
    procedure CarregarClientes(const AFiltro: string = '');
  public
    property ClienteSelecionado: TCliente read FClienteSelecionado;
  end;

var FormSelecionarCliente: TFormSelecionarCliente;

implementation

{$R *.dfm}

uses Conexao, FrmPedido, Database;

procedure TFormSelecionarCliente.FormCreate(Sender: TObject);
begin
  FUtilidades:= TUtilidades.Create();
  FUtilidades.AplicarArredondamento(self,10);
  Conn := DBConnection;
  FController := TClienteController.Create(Conn);
  FClientes := TObjectList<TCliente>.Create(True);
  ConfigurarGrid;
  CarregarClientes;
end;

procedure TFormSelecionarCliente.FormDestroy(Sender: TObject);
begin
  FClientes.Free;
  FController.Free;
  FUtilidades.Free;
end;

procedure TFormSelecionarCliente.FormResize(Sender: TObject);
begin
  AjustarColunas(Grid);
end;

procedure TFormSelecionarCliente.FormShow(Sender: TObject);
begin
  AjustarColunas(Grid);
end;

procedure TFormSelecionarCliente.ConfigurarGrid;
begin
  Grid.ColCount := 4;
  Grid.FixedRows := 1;
  Grid.Cells[0,0] := 'Código';
  Grid.Cells[1,0] := 'Nome';
  Grid.Cells[2,0] := 'Cidade';
  Grid.Cells[3,0] := 'UF';
end;

procedure TFormSelecionarCliente.AjustarColunas(Grid: TStringGrid);
begin
  var LarguraDisponivel := Grid.ClientWidth;

  Grid.ColWidths[0] := 80;
  Grid.ColWidths[2] := 100;
  Grid.ColWidths[3] := 60;
  Grid.ColWidths[1] := LarguraDisponivel -
                       Grid.ColWidths[0] -
                       Grid.ColWidths[2] -
                       Grid.ColWidths[3];
end;

procedure TFormSelecionarCliente.CarregarClientes(const AFiltro: string);
begin
  FClientes.Clear;
  FClientes.AddRange(FController.Listar(AFiltro));
  Grid.RowCount := FClientes.Count + 1;
  for var I := 0 to FClientes.Count - 1 do
  begin
    Grid.Cells[0, I+1] := FClientes[I].Codigo.ToString;
    Grid.Cells[1, I+1] := FClientes[I].Nome;
    Grid.Cells[2, I+1] := FClientes[I].Cidade;
    Grid.Cells[3, I+1] := FClientes[I].UF;
  end;
end;

procedure TFormSelecionarCliente.EdtBuscarChange(Sender: TObject);
begin
  CarregarClientes(EdtBuscar.Text);
end;

procedure TFormSelecionarCliente.BtnSelecionarClick(Sender: TObject);
begin
  if Grid.Row <= 0 then Exit;
  FClienteSelecionado := FClientes[Grid.Row - 1];
  ModalResult := mrOk;
end;

procedure TFormSelecionarCliente.GridDblClick(Sender: TObject);
begin
  BtnSelecionarClick(Sender);
end;

end.
