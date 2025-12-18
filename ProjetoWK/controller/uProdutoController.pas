unit uProdutoController;

interface

uses
  FireDAC.Comp.Client, uProduto, uProdutoDAO, System.Generics.Collections;

type
  TProdutoController=class
  private
    FConn:TFDConnection;
  public
    constructor Create(AConn:TFDConnection);
    function BuscarProduto(ACodigo:Integer):TProduto;
    function Listar(const AFiltro: string): TObjectList<TProduto>;
  end;

implementation

constructor TProdutoController.Create(AConn:TFDConnection);
begin
  FConn:=AConn;
end;

function TProdutoController.Listar(
  const AFiltro: string): TObjectList<TProduto>;
begin
  Result := TProdutoDAO.Listar(FConn, AFiltro);
end;

function TProdutoController.BuscarProduto(ACodigo:Integer):TProduto;
begin
  Result:=TProdutoDAO.BuscarPorCodigo(FConn,ACodigo);
end;

end.