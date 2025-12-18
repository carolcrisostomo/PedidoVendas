unit uClienteController;

interface

uses
  FireDAC.Comp.Client, uCliente, uClienteDAO, System.Generics.Collections;

type
  TClienteController = class
  private
    FConn: TFDConnection;
  public
    constructor Create(AConn: TFDConnection);
    function BuscarCliente(ACodigo: Integer): TCliente;
    function Listar(const AFiltro: string): TObjectList<TCliente>;
  end;

implementation

constructor TClienteController.Create(AConn: TFDConnection);
begin
  FConn := AConn;
end;

function TClienteController.Listar(
  const AFiltro: string): TObjectList<TCliente>;
begin
  Result := TClienteDAO.Listar(FConn, AFiltro);
end;

function TClienteController.BuscarCliente(ACodigo: Integer): TCliente;
begin
  Result := TClienteDAO.BuscarPorCodigo(FConn, ACodigo);
end;

end.
