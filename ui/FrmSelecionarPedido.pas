unit FrmSelecionarPedido;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Forms, Vcl.StdCtrls, Vcl.Grids, Vcl.Controls,
  FireDAC.Comp.Client, uUtilidades,
  PedidoService, PedidoRepository,
  Database;

type
  TFormSelecionarPedido = class(TForm)
    EdtBuscar: TEdit;
    Grid: TStringGrid;
    BtnSelecionar: TButton;
    BtnCancelar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtBuscarChange(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    Conn: TFDConnection;
    Service: TPedidoService;
    QPedidos: TFDQuery;
    FPedidoSelecionado: Integer;
    FUtilidades: TUtilidades;
    procedure ConfigurarGrid;
    procedure CarregarPedidos(const AFiltro: string = '');
    procedure AjustarColunas(Grid: TStringGrid);
  public
    property PedidoSelecionado: Integer read FPedidoSelecionado;
  end;

implementation

{$R *.dfm}

procedure TFormSelecionarPedido.FormCreate(Sender: TObject);
begin
  Conn := DBConnection;
  Service := TPedidoService.Create(TPedidoRepository.Create(Conn));
  FUtilidades:= TUtilidades.Create();
  FUtilidades.AplicarArredondamento(self,10);
  QPedidos := TFDQuery.Create(nil);
  QPedidos.Connection := Conn;

  FPedidoSelecionado := 0;
  ConfigurarGrid;
  AjustarColunas(Grid);
end;

procedure TFormSelecionarPedido.FormShow(Sender: TObject);
begin
  CarregarPedidos;
end;

procedure TFormSelecionarPedido.ConfigurarGrid;
begin
  Grid.ColCount := 4;
  Grid.FixedRows := 1;
  Grid.Cells[0,0] := 'Pedido';
  Grid.Cells[1,0] := 'Cliente';
  Grid.Cells[2,0] := 'Data';
  Grid.Cells[3,0] := 'Total';
end;

procedure TFormSelecionarPedido.CarregarPedidos(const AFiltro: string);
begin
  QPedidos.Close;
  QPedidos.Connection:= Conn;
  QPedidos.SQL.Text :=
    'select p.numero_pedido, c.nome, p.data_emissao, p.valor_total ' +
    'from pedidos p join clientes c on c.codigo = p.codigo_cliente ' +
    'order by p.numero_pedido desc';

  QPedidos.Open;

  Grid.RowCount := QPedidos.RecordCount + 1;
  var i := 1;
  while not QPedidos.Eof do
  begin
    Grid.Cells[0,i] := QPedidos.FieldByName('numero_pedido').AsString;
    Grid.Cells[1,i] := QPedidos.FieldByName('nome').AsString;
    Grid.Cells[2,i] := DateToStr(QPedidos.FieldByName('data_emissao').AsDateTime);
    Grid.Cells[3,i] := FormatCurr('0.00', QPedidos.FieldByName('valor_total').AsCurrency);
    Inc(i);
    QPedidos.Next;
  end;
end;

procedure TFormSelecionarPedido.AjustarColunas(Grid: TStringGrid);
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

procedure TFormSelecionarPedido.EdtBuscarChange(Sender: TObject);
begin
  CarregarPedidos(EdtBuscar.Text);
end;

procedure TFormSelecionarPedido.BtnSelecionarClick(Sender: TObject);
begin
  if Grid.Row <= 0 then Exit;
  FPedidoSelecionado := StrToInt(Grid.Cells[0, Grid.Row]);
  ModalResult := mrOk;
end;

procedure TFormSelecionarPedido.GridDblClick(Sender: TObject);
begin
  BtnSelecionarClick(Sender);
end;

procedure TFormSelecionarPedido.BtnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
