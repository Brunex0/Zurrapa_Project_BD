unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, MSSQLConn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Grids, ExtCtrls, ValEdit;
var NumProdutos, Pedido, PedidoID, NumPedidos:Integer;
var StringPedido:String;


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

var
  Form4: TForm4;
var indiceOk, indiceAnterior:Integer;
Function setnumBar(var numBar:Integer):Boolean;
implementation
Uses Unit1;

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
var i, verEstado ,indice,Cod_EstadoPedido:Integer;
var ProdutoID, Qtd_Pedida, Qtd_Consumida, EstadoPedido:String;
begin

     StringGrid1.Cols[1].Clear;
     StringGrid1.Cols[2].Clear;
     StringGrid1.Cols[3].Clear;
     Panel1.Caption:='';
     StringPedido:=Edit1.Text;
     ValueListEditor1.clear;
     //StringGrid1.clear;
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
           Label2.Caption:= IntToStr(PedidoID);
           indice:=1;
           indiceok:=0;
                 StringGrid1.Columns.Items[0].Title.Caption := 'IDProduto';
                 StringGrid1.Columns.Items[1].Title.Caption := 'QtdPedida';
                 StringGrid1.Columns.Items[2].Title.Caption := 'QtdConsumida';
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
                          SQL.Add('Select IDProduto, Qtd_Pedida, Qtd_Consumida');
                          SQL.Add('From Linha_Pedido');
                          SQL.Add('Where IDProduto='+IntToStr(i)+'AND IDPedido='+IntToStr(PedidoID));
                        end;
                     with SQLQuery1 do
                          begin
                           if Active then
                             Close;
                           Open;
                          end;
                 ProdutoID:=SQLQuery1.Fields[0].AsString;
                 Qtd_Pedida:=SQLQuery1.Fields[1].AsString;
                 Qtd_Consumida:=SQLQuery1.Fields[2].AsString;

                 if(ProdutoID<>'') or (Qtd_Pedida<>'') then
                 begin
                   ValueListEditor1.InsertRow(Qtd_Pedida,'',true);
                   StringGrid1.Cells[1,indice]:= ProdutoID;
                   StringGrid1.Cells[2,indice]:= Qtd_Pedida;
                   StringGrid1.Cells[3,indice]:= Qtd_Consumida;
                   indice:=indice+1;
                   indiceok:=indice-1;
                   indiceAnterior:=indice;
                 end;

                end;
     end
     else
           Panel1.Caption:= 'ID Pedido Inválido';

  end;

end;

procedure TForm4.Button2Click(Sender: TObject);
var QtdPedido, QtdConsumida,QtdArmazem,IDProduto, i,o, QtdBar, Unidade:integer;
begin

  i:=1;
  for o:=1 to indiceok do
  begin
       QtdConsumida:=ValueListEditor1.Cells[1,o].ToInteger;
       IDProduto:= StringGrid1.Cells[1,o].ToInteger;
       QtdPedido:=StringGrid1.Cells[2,o].ToInteger;
      with  SQLQuery1 do
        begin
          DataBase := Form1.MSSQLConnection1;
          Transaction := Form1.MSSQLConnection1.Transaction;
          SQL.Clear;
          SQL.Add('Select Qtd');
          SQL.Add('From Stock');
          SQL.Add('Where IDProduto='+IntToStr(IDProduto)+'AND IDLocal='+IntToStr(num_Bar));
        end;
       with SQLQuery1 do
            begin
             if Active then
               Close;
             Open;
            end;

    QtdBar:=SQLQuery1.Fields[0].AsInteger;
    if(QtdConsumida > QtdPedido) then
    begin
       Form1.Panel1.Caption:='Quantidade inserida Inválida!';
    end
    else
    begin
       if(QtdBar<QtdPedido) then
       begin
            with  SQLQuery1 do
            begin
                 DataBase := Form1.MSSQLConnection1;
                 Transaction := Form1.MSSQLConnection1.Transaction;
                 SQL.Clear;
                 SQL.Add('Select S.Qtd, U.Unidade');
                 SQL.Add('From Stock S, Unidade_Medida U');
                 SQL.Add('Where IDProduto='+IntToStr(IDProduto)+'AND IDLocal=3 AND S.Codigo_Unid=U.Codigo_Unid');
            end;
            with SQLQuery1 do
            begin
                 if Active then
                    Close;
                 Open;
            end;
            QtdArmazem:=SQLQuery1.Fields[0].AsInteger;
            Unidade:=SQLQuery1.Fields[1].AsInteger;
            QtdArmazem:= QtdArmazem*Unidade;
            if(QtdArmazem>=QtdPedido) then
            begin
                 Form1.Panel1.Caption:='Sem Stock Bar! Produto disponível em armazém';
                 if(o=indiceok)then
                 begin
                      Edit1.Clear;
                      Label2.Caption:='';
                      StringGrid1.Cols[1].Clear;
                      StringGrid1.Cols[2].Clear;
                      StringGrid1.Cols[3].Clear;
                      ValueListEditor1.clear;
                      Close;
                 end;
            end
            else
            begin
                 Form1.Panel1.Caption:='Sem Stock Bar! Não disponível em armazém';
            if(o=indiceok)then
            begin
                 Edit1.Clear;
                 Label2.Caption:='';
                 StringGrid1.Cols[1].Clear;
                 StringGrid1.Cols[2].Clear;
                 StringGrid1.Cols[3].Clear;
                 ValueListEditor1.clear;
                 Close;
            end;
            end;

       end;
       if(QtdBar>=QtdPedido) then
       begin
             QtdBar:=QtdBar-QtdPedido;
             stSQLText := 'UPDATE Stock SET Qtd='+ IntToStr(QtdBar) +'Where IDLocal='+IntToStr(num_Bar)+' AND IDProduto='+IntToStr(IDProduto);
             SQLQuery1.Sql.Text:= stSQLText;
             SQLQuery1.Prepare;

             //Insere na base de dados
             SQLQuery1.ExecSQL;
             //Confirma as alterações
             SQLQuery1.SQLTransaction.Commit;

             stSQLText := 'UPDATE Linha_Pedido SET Qtd_Consumida='+ IntToStr(QtdPedido) +'Where IDPedido='+IntToStr(PedidoID)+' AND IDProduto='+IntToStr(IDProduto);
             SQLQuery1.Sql.Text:= stSQLText;
             SQLQuery1.Prepare;

             //Insere na base de dados
             SQLQuery1.ExecSQL;

             //Confirma as alterações
             SQLQuery1.SQLTransaction.Commit;

             stSQLText := 'UPDATE Pedido SET Cod_EstadoPedido=2 Where IDPedido='+IntToStr(PedidoID);
             SQLQuery1.Sql.Text:= stSQLText;
             SQLQuery1.Prepare;

             //Insere na base de dados
             SQLQuery1.ExecSQL;

             //Confirma as alterações
             SQLQuery1.SQLTransaction.Commit;
        end;
    end;


  end;
            Edit1.Clear;
            Label2.Caption:='';
            StringGrid1.Cols[1].Clear;
            StringGrid1.Cols[2].Clear;
            StringGrid1.Cols[3].Clear;
            ValueListEditor1.clear;
            Close;


end;

procedure TForm4.Button3Click(Sender: TObject);
begin
     Edit1.Clear;
     Label2.Caption:='';
     StringGrid1.Cols[1].Clear;
     StringGrid1.Cols[2].Clear;
     StringGrid1.Cols[3].Clear;
     Panel1.Caption:='';
     StringPedido:=Edit1.Text;
     ValueListEditor1.clear;
     Close;
end;


end.
