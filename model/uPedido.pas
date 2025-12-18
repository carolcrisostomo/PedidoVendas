unit uPedido;

interface

type
  TPedido=class
  private
    FNumero:Integer;
    FData:TDateTime;
    FCodigoCliente:Integer;
    FValorTotal:Currency;
  public
    property Numero:Integer read FNumero write FNumero;
    property Data:TDateTime read FData write FData;
    property CodigoCliente:Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal:Currency read FValorTotal write FValorTotal;
  end;

implementation

end.
