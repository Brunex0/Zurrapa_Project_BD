unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, MSSQLConn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBCtrls, DBGrids, ExtCtrls, Grids, ValEdit;

var stSQLText:String;
type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    ValueListEditor1: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;
Function setNumBar(var numBar:Integer):Boolean;
var ID_Pedido, ID_Empregado, N_Mesa:Integer;
var dia, hora:String;

implementation
uses Unit1;

{$R *.lfm}

{ TForm3 }



procedure TForm3.FormCreate(Sender: TObject);
begin
     with  SQLQuery1 do
     begin
          DataBase := Form1.MSSQLConnection1;
          Transaction := Form1.MSSQLConnection1.Transaction;
          SQL.Clear;
          SQL.Add('Select Designacao');
          SQL.Add('From Produto');
     end;

     with SQLQuery1 do
     begin
          if Active then
             Close;
          Open;
     end;
end;

procedure TForm3.Button1Click(Sender: TObject);
var NumPedidosAdd, i, qtdPedida, qtd_StockBar, qtd_Armazem,IDProduto, tempo, Unidade, IDPedidoAnterior:Integer;
var Estado:String;
begin

     ID_Pedido:=0;
     with  SQLQuery1 do
       begin
        DataBase := Form1.MSSQLConnection1;
        Transaction := Form1.MSSQLConnection1.Transaction;
        SQL.Clear;
        SQL.Add('Select MAX(IDPedido)');
        SQL.Add('From Pedido');
       end;
      with SQLQuery1 do
      begin
        if Active then
           Close;
        Open;
      end;
     IDPedidoAnterior:= SQLQuery1.Fields[0].AsInteger;
     ID_Pedido:= SQLQuery1.Fields[0].AsInteger;
     ID_Pedido:=ID_Pedido+1;

     //conta quantos produtos foram adicionados
     NumPedidosAdd:=ValueListEditor1.RowCount-1;

     for i:=1 to NumPedidosAdd do
     begin
       IDProduto:=ValueListEditor1.Cells[0,i].ToInteger;
       qtdPedida:=ValueListEditor1.Cells[1,i].ToInteger;
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
        SQLQuery1.Fields[0].Visible:=false;
        qtd_StockBar:=SQLQuery1.Fields[0].AsInteger;
        if(qtd_StockBar<qtdPedida) then
        begin
               with  SQLQuery1 do
               begin
                DataBase := Form1.MSSQLConnection1;
                Transaction := Form1.MSSQLConnection1.Transaction;
                SQL.Clear;
                SQL.Add('Select S.Qtd, U.Unidade ');
                SQL.Add('From Stock S, Unidade_Medida U');
                SQL.Add('Where IDProduto='+IntToStr(IDProduto)+'AND IDLocal=3 AND S.Codigo_Unid=U.Codigo_Unid');
               end;

               with SQLQuery1 do
               begin
                if Active then
                   Close;
                Open;
               end;
               SQLQuery1.Fields[0].Visible:=false;
               SQLQuery1.Fields[1].Visible:=false;
               qtd_Armazem:=SQLQuery1.Fields[0].AsInteger;
               Unidade:=SQLQuery1.Fields[1].ASInteger;
               qtd_Armazem:=qtd_Armazem*Unidade;
               if(qtd_Armazem<qtdPedida) then
               begin
                  Panel1.Caption:='Stock Bar Insuficiente! Produto não existente em armazém';

                  with  SQLQuery1 do
                  begin
                      DataBase := Form1.MSSQLConnection1;
                      Transaction := Form1.MSSQLConnection1.Transaction;
                      SQL.Clear;
                      SQL.Add('Select Designacao');
                      SQL.Add('From Produto');
                  end;

                  with SQLQuery1 do
                  begin
                       if Active then
                            Close;
                       Open;
                  end;

               end
               else
               begin
                  with  SQLQuery1 do
                  begin
                    DataBase := Form1.MSSQLConnection1;
                    Transaction := Form1.MSSQLConnection1.Transaction;
                    SQL.Clear;
                    SQL.Add('Select Tempo');
                    SQL.Add('From Deslocacao');
                    SQL.Add('Where De = 3 AND Para='+IntToStr(num_Bar));
                  end;
                  with SQLQuery1 do
                  begin
                    if Active then
                       Close;
                    Open;
                  end;

                  tempo:= SQLQuery1.Fields[0].AsInteger;
                  Panel1.Caption:='Stock Bar Insuficiente! Produto existente em armazém demora '+IntToStr(tempo)+'min a ser reposto';
                  with  SQLQuery1 do
                  begin
                      DataBase := Form1.MSSQLConnection1;
                      Transaction := Form1.MSSQLConnection1.Transaction;
                      SQL.Clear;
                      SQL.Add('Select Designacao');
                      SQL.Add('From Produto');
                  end;

                  with SQLQuery1 do
                  begin
                       if Active then
                            Close;
                       Open;
                  end;

               end;
      end
      else
      if(qtd_StockBar>=qtdPedida) then
      begin
         //Mesa estiver Limpa atualizar emp responsável
         with  SQLQuery1 do
         begin
          DataBase := Form1.MSSQLConnection1;
          Transaction := Form1.MSSQLConnection1.Transaction;
          SQL.Clear;
          SQL.Add('Select Estado');
          SQL.Add('From Mesa M, Estado_Mesa E');
          SQL.Add('Where M.Cod_EstadoMesa=E.Cod_EstadoMesa AND N_Mesa='+IntToStr(N_Mesa)+'AND IDLocal='+IntToStr(num_Bar));
         end;
         with SQLQuery1 do
         begin
           if Active then
               Close;
           Open;
         end;
      Estado:=SQLQuery1.Fields[0].AsString;
      if(Estado='Limpa') then
      begin
        stSQLText := 'UPDATE Mesa SET IDEmpregado= '+IntToStr(ID_Empregado)+', Cod_EstadoMesa=2 Where N_Mesa='+IntToStr(N_Mesa)+'AND IDLocal='+IntToStr(num_Bar);
        SQLQuery1.Sql.Text:= stSQLText;
        SQLQuery1.Prepare;
        //Insere na base de dados
        SQLQuery1.ExecSQL;
        //Confirma as alterações
        SQLQuery1.SQLTransaction.Commit;
      end;

      //Cria novo Pedido
      if(i=1)then
        begin
             //Criar novo Pedido
             //Prepara o SQL a submeter à BD
             stSQLText := 'Insert into Pedido(IDPedido, Cod_EstadoPedido, IDLocal, N_Mesa, IDEmpregado, Dia, Hora) ';
             stSQLText:=stSQLText+'values (:IDPedido,:Cod_EstadoPedido,:IDLocal,:N_Mesa,:IDEmpregado,:Dia,:Hora)';
             SQLQuery1.sql.Text:= stSQLText;

             SQLQuery1.Prepare;
             SQLQuery1.ParamByName('IDPedido').AsInteger:= ID_Pedido;
             SQLQuery1.ParamByName('Cod_EstadoPedido').AsInteger:= 1;
             SQLQuery1.ParamByName('IDLocal').AsInteger:= num_Bar;
             SQLQuery1.ParamByName('N_Mesa').AsInteger:= N_Mesa;
             SQLQuery1.ParamByName('IDEmpregado').AsInteger:= ID_Empregado;
             SQLQuery1.ParamByName('Dia').AsString:= DateToStr(Date);
             SQLQuery1.ParamByName('Hora').AsString:= TimeToStr(Time);

             //Insere na base de dados
             SQLQuery1.ExecSQL;
             SQLQuery1.SQLTransaction.Commit;
        end;

        //Insere Produtos relacionados com determinado pedido
        stSQLText := 'Insert into Linha_Pedido(IDPedido, IDProduto, Qtd_Pedida, Qtd_Consumida, Qtd_Paga) ';
        stSQLText:=stSQLText+'values (:IDPedido,:IDProduto, :Qtd_Pedida, :Qtd_Consumida, :Qtd_Paga)';

        SQLQuery1.sql.Text:= stSQLText;
        SQLQuery1.Prepare;
        SQLQuery1.ParamByName('IDPedido').AsInteger:= ID_Pedido;
        SQLQuery1.ParamByName('IDProduto').AsInteger:= IDProduto;
        SQLQuery1.ParamByName('Qtd_Pedida').AsInteger:= qtdPedida;
        SQLQuery1.ParamByName('Qtd_Consumida').AsInteger:= 0;
        SQLQuery1.ParamByName('Qtd_Paga').AsInteger:= 0;
        SQLQuery1.ExecSQL;
        SQLQuery1.SQLTransaction.Commit;
        if(i=NumPedidosAdd) then
        begin
          Edit1.Clear;
          Edit5.Clear;
          Label5.Caption:='';
          Label7.Caption:='';
          ValueListEditor1.clear;
          Close;
        end;


     end;

     end;

     DataSource1.DataSet := SQLQuery1;
     DBGrid1.DataSource := DataSource1;

     with  SQLQuery1 do
     begin
          DataBase := Form1.MSSQLConnection1;
          Transaction := Form1.MSSQLConnection1.Transaction;
          SQL.Clear;
          SQL.Add('Select Designacao');
          SQL.Add('From Produto');
     end;

     with SQLQuery1 do
     begin
          if Active then
             Close;
          Open;
     end;



end;

Function setNumBar(var numBar:Integer):Boolean;
begin
  num_Bar:=numBar;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
   Panel1.Caption:='';
   Edit1.Clear;
   Edit5.Clear;
   Label5.Caption:='';
   Label7.Caption:='';
   with  SQLQuery1 do
        begin
         DataBase := Form1.MSSQLConnection1;
         Transaction := Form1.MSSQLConnection1.Transaction;
         SQL.Clear;
         SQL.Add('Select Designacao');
         SQL.Add('From Produto');
        end;

        with SQLQuery1 do
             begin
              if Active then
                Close;
              Open;
             end;
   ValueListEditor1.clear;
   Form3.Close;
end;

procedure TForm3.DBGrid1CellClick(Column: TColumn);
var rand:Double;
var IDProduto:Integer;
var produto:String;
begin
   //Coloca na ValueListEditor1 o valor selecionado para o empregado introduzir a quantidade pedida
   produto:=SQLQuery1.Fields[0].AsString ;
   with  SQLQuery1 do
        begin
         DataBase := Form1.MSSQLConnection1;
         Transaction := Form1.MSSQLConnection1.Transaction;
         SQL.Clear;
         SQL.Add('Select IDProduto');
         SQL.Add('From Produto');
         SQL.Add('Where Designacao = '''+produto+'''');
        end;

        with SQLQuery1 do
             begin
              if Active then
                Close;
              Open;
             end;
      IDProduto:=SQLQuery1.Fields[0].AsInteger;
      ID_Empregado := StrToInt(Edit1.Text);
      N_Mesa:=StrToInt(Edit5.Text);
      ValueListEditor1.InsertRow(IntToStr(IDProduto),'',true);
      DBGrid1.Columns[0].Visible:=false;
      with  SQLQuery1 do
        begin
         DataBase := Form1.MSSQLConnection1;
         Transaction := Form1.MSSQLConnection1.Transaction;
         SQL.Clear;
         SQL.Add('Select Designacao');
         SQL.Add('From Produto');
        end;

        with SQLQuery1 do
        begin
             if Active then
                Close;
             Open;
        end;
end;




end.

