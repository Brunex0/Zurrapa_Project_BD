unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, MSSQLConn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ValEdit, Grids, ExtCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DataSource1: TDataSource;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    StringGrid1: TStringGrid;
    ValueListEditor1: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var num_Bar, PedidoID, NumPedidos, indiceok, NumProdutos, indiceAnterior:Integer;
var StringPedido, stSQLText:String;
var
  Form4: TForm4;

Function setnumBar(var numBar:Integer):Boolean;

implementation
uses Unit1;

Function setnumBar(var numBar:Integer):Boolean;
begin
    num_Bar:=numBar;
end;

{$R *.lfm}

{ TForm4 }

procedure TForm4.FormCreate(Sender: TObject);
begin

end;

procedure TForm4.Button1Click(Sender: TObject);
var i, indice:Integer;
var ProdutoID, Qtd_Paga, Qtd_Consumida:String;
begin
     StringGrid1.Cols[1].Clear;
     StringGrid1.Cols[2].Clear;
     StringGrid1.Cols[3].Clear;
     Panel1.Caption:='';
     StringPedido:=Edit1.Text;
     ValueListEditor1.clear;
  if(StringPedido<>'') then
  begin
    PedidoID:=StrToInt(StringPedido);
    with  SQLQuery1 do
           begin
             DataBase := Form1.MSSQLConnection1;
             Transaction := Form1.MSSQLConnection1.Transaction;
             SQL.Clear;
             SQL.Add('Select COUNT(IDPedido)');
             SQL.Add('From Pedido');
           end;
     with SQLQuery1 do
             begin
              if Active then
                Close;
              Open;
             end;
         NumPedidos:=SQLQuery1.Fields[0].AsInteger;
     if(PedidoID>=1) and (PedidoID<=NumPedidos) then
     begin
           Label3.Caption:= IntToStr(PedidoID);
           indice:=1;
           indiceok:=0;
                 StringGrid1.Columns.Items[0].Title.Caption := 'IDProduto';
                 StringGrid1.Columns.Items[1].Title.Caption := 'QtdConsumida';
                 StringGrid1.Columns.Items[2].Title.Caption := 'QtdPaga';
                 with  SQLQuery1 do
                        begin
                          DataBase := Form1.MSSQLConnection1;
                          Transaction := Form1.MSSQLConnection1.Transaction;
                          SQL.Clear;
                          SQL.Add('Select Count(*)');
                          SQL.Add('From Produto');
                        end;
                     with SQLQuery1 do
                          begin
                           if Active then
                             Close;
                           Open;
                          end;
                 NumProdutos:=SQLQuery1.Fields[0].AsInteger;
                 for i:=1 to NumProdutos do
                 begin
                      with  SQLQuery1 do
                        begin
                          DataBase := Form1.MSSQLConnection1;
                          Transaction := Form1.MSSQLConnection1.Transaction;
                          SQL.Clear;
                          SQL.Add('Select L.IDProduto, L.Qtd_Consumida, L.Qtd_Paga');
                          SQL.Add('From Linha_Pedido L,Pedido P');
                          SQL.Add('Where L.IDProduto='+IntToStr(i)+'AND P.IDPedido=L.IDPedido AND P.Cod_EstadoPedido<> 1 AND P.Cod_EstadoPedido<>4 AND L.IDPedido='+IntToStr(PedidoID)+'AND P.IDLocal='+IntToStr(num_Bar));
                        end;
                     with SQLQuery1 do
                          begin
                           if Active then
                             Close;
                           Open;
                          end;
                 ProdutoID:=SQLQuery1.Fields[0].AsString;
                 Qtd_Consumida:=SQLQuery1.Fields[1].AsString;
                 Qtd_Paga:=SQLQuery1.Fields[2].AsString;
                 Panel1.Caption:=IntToStr(num_Bar);

                 if(ProdutoID<>'') or (Qtd_Consumida<>'') then
                 begin
                   ValueListEditor1.InsertRow(Qtd_Consumida,'0',true);
                   StringGrid1.Cells[1,indice]:= ProdutoID;
                   StringGrid1.Cells[2,indice]:= Qtd_Consumida;
                   StringGrid1.Cells[3,indice]:= Qtd_Paga;
                   indice:=indice+1;
                   indiceok:=indice-1;
                 end;

                end;
     end
     else
           Panel1.Caption:= 'ID Pedido Inválido';

  end;

end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Edit1.Clear;
  Label3.Caption:='';
  StringGrid1.Cols[1].Clear;
  StringGrid1.Cols[2].Clear;
  StringGrid1.Cols[3].Clear;
  Panel1.Caption:='';
  StringPedido:=Edit1.Text;
  ValueListEditor1.clear;
  Close;
end;

procedure TForm4.Button3Click(Sender: TObject);
var QtdConsumida, QtdPaga, PedidoPago, i, IDProduto, QtdPagaAnterior, PedidosMesa, NMesa, PedidosMesaPagos:Integer;
begin
  PedidoPago:=0;
  //obtém se o numero da mesa
  with  SQLQuery1 do
  begin
       DataBase := Form1.MSSQLConnection1;
       Transaction := Form1.MSSQLConnection1.Transaction;
       SQL.Clear;
       SQL.Add('Select N_mesa');
       SQL.Add('From Pedido');
       SQL.Add('Where IDPedido='+IntToStr(PedidoID));
  end;
  with SQLQuery1 do
  begin
       if Active then
          Close;
       Open;
   end;
  NMesa:=SQLQuery1.Fields[0].AsInteger;

  //Quantos Pedidos tem essa mesa
  with  SQLQuery1 do
  begin
       DataBase := Form1.MSSQLConnection1;
       Transaction := Form1.MSSQLConnection1.Transaction;
       SQL.Clear;
       SQL.Add('Select count(IDPedido)');
       SQL.Add('From Pedido');
       SQL.Add('Where N_Mesa='+IntToStr(NMesa)+'AND IDLocal='+IntToStr(num_Bar));
  end;
  with SQLQuery1 do
  begin
       if Active then
          Close;
       Open;
   end;
  PedidosMesa:=SQLQuery1.Fields[0].AsInteger;



  for i:=1 to indiceok do
  begin
      QtdPaga:=ValueListEditor1.Cells[1,i].ToInteger;
      IDProduto:=StringGrid1.Cells[1,i].ToInteger;
      QtdConsumida:= StringGrid1.Cells[2,i].ToInteger;
      QtdPagaAnterior:=StringGrid1.Cells[3,i].ToInteger;

      if((QtdPagaAnterior+QtdPaga)<>QtdPagaAnterior) and ((QtdPagaAnterior+QtdPaga)<=QtdConsumida)then
      begin
           stSQLText := 'UPDATE Linha_Pedido SET Qtd_Paga='+ IntToStr(QtdPagaAnterior+QtdPaga) +'Where IDProduto='+IntToStr(IDProduto)+'AND IDPedido='+IntToStr(PedidoID);
           SQLQuery1.Sql.Text:= stSQLText;
           SQLQuery1.Prepare;
           //Insere na base de dados
           SQLQuery1.ExecSQL;
           //Confirma as alterações
           SQLQuery1.SQLTransaction.Commit;
      end;

      if((QtdPagaAnterior+QtdPaga)=QtdConsumida) then
      begin
         PedidoPago:=PedidoPago+1;
      end;
  end;
  if(PedidoPago=indiceok) then
  begin
       //altera estado pedido para pago
       stSQLText := 'UPDATE Pedido SET Cod_EstadoPedido= 4 Where IDPedido='+IntToStr(PedidoID);
       SQLQuery1.Sql.Text:= stSQLText;
       SQLQuery1.Prepare;
       //Insere na base de dados
       SQLQuery1.ExecSQL;
       //Confirma as alterações
       SQLQuery1.SQLTransaction.Commit;

       //Quantos Pedidos tem essa mesa Pagos
       with  SQLQuery1 do
       begin
            DataBase := Form1.MSSQLConnection1;
            Transaction := Form1.MSSQLConnection1.Transaction;
            SQL.Clear;
            SQL.Add('Select Count(IDPedido)');
            SQL.Add('From Pedido');
            SQL.Add('Where N_Mesa='+IntToStr(NMesa)+'AND IDLocal='+IntToStr(num_Bar)+'AND Cod_EstadoPedido=4');
       end;
       with SQLQuery1 do
       begin
            if Active then
               Close;
            Open;
       end;
       PedidosMesaPagos:=SQLQuery1.Fields[0].AsInteger;

       //Altera estado da mesa para suja
       if(PedidosMesaPagos=PedidosMesa) then
       begin
            stSQLText := 'UPDATE M SET M.Cod_EstadoMesa = 3 From Mesa As M INNER JOIN Pedido As P ON P.N_Mesa=M.N_Mesa Where P.IDPedido='+IntToStr(PedidoID);
            SQLQuery1.Sql.Text:= stSQLText;
            SQLQuery1.Prepare;
            //Insere na base de dados
            SQLQuery1.ExecSQL;
            //Confirma as alterações
            SQLQuery1.SQLTransaction.Commit;
       end;



  end
  else
  if(PedidoPago<indiceok) then
  begin
       stSQLText := 'UPDATE Pedido SET Cod_EstadoPedido= 3 Where IDPedido='+IntToStr(PedidoID);
       SQLQuery1.Sql.Text:= stSQLText;
       SQLQuery1.Prepare;
       //Insere na base de dados
       SQLQuery1.ExecSQL;
       //Confirma as alterações
       SQLQuery1.SQLTransaction.Commit;
  end;
  if ((QtdPagaAnterior+QtdPaga)> QtdConsumida) then
  begin
       Form1.Panel1.Caption:='Inserida quantidade a pagar Inválida!'
  end;

  Edit1.Clear;
  Label3.Caption:='';
  StringGrid1.Cols[1].Clear;
  StringGrid1.Cols[2].Clear;
  StringGrid1.Cols[3].Clear;
  Panel1.Caption:='';
  StringPedido:=Edit1.Text;
  ValueListEditor1.clear;
  Close;
end;

end.

