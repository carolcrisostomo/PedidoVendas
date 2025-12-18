unit uProdutoDAO;

interface

uses
  FireDAC.Comp.Client, uProduto, System.Generics.Collections, FireDAC.Stan.Param,
  Data.DB;

type
  TProdutoDAO=class
  public
    class function BuscarPorCodigo(Conn:TFDConnection;ACodigo:Integer):TProduto;
    class function Listar( Conn: TFDConnection; const AFiltro: string): TObjectList<TProduto>;
  end;

implementation

class function TProdutoDAO.BuscarPorCodigo(Conn:TFDConnection;ACodigo:Integer):TProduto;
begin Result:=nil;
  var QProduto:=TFDQuery.Create(nil);
  try
    QProduto.Connection:=Conn;
    QProduto.SQL.Text:='SELECT CODIGO,DESCRICAO,PRECO_VENDA FROM PRODUTOS WHERE CODIGO=:CODIGO';
    QProduto.ParamByName('CODIGO').AsInteger:=ACodigo;
    QProduto.Open;
    if not QProduto.IsEmpty then
    begin
      Result:=TProduto.Create;
      Result.Codigo:=QProduto.FieldByName('CODIGO').AsInteger;
      Result.Descricao:=QProduto.FieldByName('DESCRICAO').AsString;
      Result.Valor:=QProduto.FieldByName('PRECO_VENDA').AsCurrency;
    end;
  finally
    QProduto.Free;
  end;
end;

class function TProdutoDAO.Listar(Conn: TFDConnection;
  const AFiltro: string): TObjectList<TProduto>;
begin
  Result := TObjectList<TProduto>.Create(True);

  var QProduto := TFDQuery.Create(nil);
  try
    QProduto.Connection := Conn;
    QProduto.SQL.Text :=
      'SELECT CODIGO, DESCRICAO, PRECO_VENDA ' +
      'FROM PRODUTOS ' +
      'WHERE DESCRICAO LIKE :FILTRO ' +
      'ORDER BY DESCRICAO';

    QProduto.ParamByName('FILTRO').AsString := '%' + AFiltro + '%';
    QProduto.Open;

    while not QProduto.Eof do
    begin
      var Prod := TProduto.Create;
      Prod.Codigo := QProduto.FieldByName('CODIGO').AsInteger;
      Prod.Descricao := QProduto.FieldByName('DESCRICAO').AsString;
      Prod.Valor := QProduto.FieldByName('PRECO_VENDA').AsCurrency;

      Result.Add(Prod);
      QProduto.Next;
    end;
  finally
    QProduto.Free;
  end;

end;

end.