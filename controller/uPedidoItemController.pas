unit uPedidoItemController;

interface

uses
  FireDAC.Comp.Client, uPedidoItem, System.Generics.Collections, uPedidoItemDAO;

type
  TPedidoItemController = class
  private
    FConn: TFDConnection;
  public
    constructor Create(AConn: TFDConnection);

    procedure Inserir(Item: TPedidoItem);
    procedure Atualizar(Item: TPedidoItem);
    procedure Excluir(AutoInc: Integer);
    function CarregarItens(NumeroPedido: Integer): TObjectList<TPedidoItem>;
  end;

implementation

constructor TPedidoItemController.Create(AConn: TFDConnection);
begin
  FConn := AConn;
end;

procedure TPedidoItemController.Inserir(Item: TPedidoItem);
begin
  TPedidoItemDAO.Inserir(FConn, Item);
end;

procedure TPedidoItemController.Atualizar(Item: TPedidoItem);
begin
  TPedidoItemDAO.Atualizar(FConn, Item);
end;

procedure TPedidoItemController.Excluir(AutoInc: Integer);
begin
  TPedidoItemDAO.Excluir(FConn, AutoInc);
end;

function TPedidoItemController.CarregarItens(NumeroPedido: Integer): TObjectList<TPedidoItem>;
begin
  Result := TPedidoItemDAO.CarregarItens(FConn, NumeroPedido);
end;

end.
