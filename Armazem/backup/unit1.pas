unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, MSSQLConn, SQLDB, DB, Forms, Controls, Graphics,
  Dialogs, Menus, DBGrids, ExtCtrls, StdCtrls;


var stSQLText:String;
var quantidade:double;
   var Memo1:TList;
type

  { TForm1 }

  TForm1 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    MenuItem16: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem7: TMenuItem;
    MSSQLConnection1: TMSSQLConnection;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private


  public

  end;

var
  Form1: TForm1;

implementation
uses Unit3, Unit4, Unit5;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var aHostName, aDatabase, aUserName, aPassword :String;
begin
  if not GetLoginData( aHostName, aDatabase, aUserName, aPassword) then
    Application.Terminate;   //Terminar a aplicação

  //Configurar o acesso à Base de Dados
    With MSSQLConnection1 do
    begin
      Connected := False;

      HostName  := aHostName;
      UserName := aUserName;
      Password := aPassword;

      Params.Clear;
      Params.Add('AutoCommit=true');
      Params.Add('TextSize=16777216');
      Params.Add('ApplicationName=EX1');
        // Connected := True;  // See below
    end;

    //Configurar o component SQLTransaction
     with SQLTransaction1 do
     begin
       if Active then
         Active := False;
       DataBase := MSSQLConnection1;

       //Base de dados...
     MSSQLConnection1.DatabaseName:= aDatabase;
     end;

     //Aceder aos dados
    Try
      //1. Ligar ao servidor
      with MSSQLConnection1 do
      begin
        if Connected then
          Connected := False;
        Connected := True;
      end;

      //2. Activar a componente de transacções
      with SQLTransaction1 do
      begin
        if Active then
          Active := False;
        Active := True;
      end;

      //Se alguma coisa funcionou mal...
    //... mostrar uma mensagem e...
    //... terminar a aplicação!
    Except
      on E:exception do
      begin
        ShowMessage(e.message);

        if MSSQLConnection1.Connected then
          MSSQLConnection1.Connected:= False;

        //Terminar a aplicação
        Application.Terminate;
      end;
    end;
end;
    //valor stock de um dado local

procedure TForm1.MenuItem7Click(Sender: TObject);
var qtdProdutos, Local, qtd, i, unidades:Integer;
var StringLocal:String;
var preco_custo, ValorTotal:Double;
begin
  Panel1.Caption:= '';
  Form4.showmodal;
  StringLocal:=Form4.Edit1.Text;
  if(StringLocal<>'') then
  begin
      Local:=StrToInt(StringLocal);
      with  SQLQuery1 do
      begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select Count(IDProduto)');
           SQL.Add('From Produto ');
      end;
      with SQLQuery1 do
      begin
           if Active then
              Close;
              Open;
      end;
      DBGrid1.Columns[0].Visible:=false;
      qtdProdutos:=SQLQuery1.Fields[0].AsInteger;
      valorTotal:=0;
      for i:=1 to qtdProdutos do
      begin
         qtd:=0;
         preco_custo:=0;
      with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select IDProduto, Qtd');
           SQL.Add('From Stock ');
           SQL.Add('Where IDLocal = '+IntToStr(Local)+' AND IDProduto='+FloatToStr(i));
         end;
      with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;
      qtd:=SQLQuery1.Fields[1].AsInteger;
      with  SQLQuery1 do
           begin
             DataBase := MSSQLConnection1;
             Transaction := MSSQLConnection1.Transaction;
             SQL.Clear;
             SQL.Add('Select Unidade');
             SQL.Add('From Unidade_Medida U,Stock S');
             SQL.Add('Where U.Codigo_Unid=S.Codigo_Unid AND S.IDLocal = '+IntToStr(Local)+'AND S.IDProduto='+FloatToStr(i));
           end;
        with SQLQuery1 do
             begin
              if Active then
                Close;
              Open;
             end;
      DBGrid1.Columns[0].Visible:=false;
      unidades:=SQLQuery1.Fields[0].AsInteger;
      qtd:=qtd*unidades;

      if (qtd>=0) then
      begin
           Panel1.Caption:= '';
        with  SQLQuery1 do
           begin
             DataBase := MSSQLConnection1;
             Transaction := MSSQLConnection1.Transaction;
             SQL.Clear;
             SQL.Add('Select Preco_Compra');
             SQL.Add('From Produto');
             SQL.Add('Where IDProduto='+FloatToStr(i));
           end;
        with SQLQuery1 do
             begin
              if Active then
                Close;
              Open;
             end;
        DBGrid1.Columns[0].Visible:=false;
        preco_custo:=SQLQuery1.Fields[0].AsInteger;
        valorTotal:=valorTotal+(preco_custo)*qtd;
        Panel1.caption:='Valor do Local '+IntToStr(Local)+' (Preço custo): '+ FloatToStr(valorTotal)+' €';
      end
   end;
  end;
  Form4.Edit1.Clear;

end;
//fim do valor de um dado stock



procedure TForm1.Panel1Click(Sender: TObject);
begin

end;
 // consultar o stock
procedure TForm1.MenuItem2Click(Sender: TObject);
var StringLocal:String;
var Local:Integer;
begin
  Panel1.Caption:= '';
  Form4.showmodal;
  StringLocal:=Form4.Edit1.Text;
  if(StringLocal<>'') then
  begin
    Local:=StrToInt(StringLocal);
    with  SQLQuery1 do
             begin
               DataBase := MSSQLConnection1;
               Transaction := MSSQLConnection1.Transaction;
               SQL.Clear;
               SQL.Add('Select IDProduto, Qtd, Codigo_Unid');
               SQL.Add('From Stock ');
               SQL.ADD('Where IDLocal='+IntToStr(Local));
             end;
          with SQLQuery1 do
               begin
                if Active then
                  Close;
                Open;
               end;
  end;
  Form4.Edit1.Clear;
end;
//fim de consultar o stock

procedure TForm1.MenuItem3Click(Sender: TObject);
var Local, qtdProdutos:Integer;
var qtd, qtdRetirada, qtdBar, UnidadeMedida, Unidade,qtdColocada, i:integer;
var StringLocal:String;
begin
  Panel1.Caption:= '';
  Form4.showmodal;
  StringLocal:=Form4.Edit1.Text;
  if(StringLocal<>'') then
  begin
     Local:=StrToInt(Form4.Edit1.Text);

        with  SQLQuery1 do
             begin
               DataBase := MSSQLConnection1;
               Transaction := MSSQLConnection1.Transaction;
               SQL.Clear;
               SQL.Add('Select Count(IDProduto)');
               SQL.Add('From Produto ');
             end;
          with SQLQuery1 do
               begin
                if Active then
                  Close;
                Open;
               end;
          DBGrid1.Columns[0].Visible:=false;
          qtdProdutos:=SQLQuery1.Fields[0].AsInteger;

        for i:=1 to qtdProdutos do
        begin
             qtd:=0;
             qtdRetirada:=5;
        if(Local=3) then
        begin
                 qtdColocada:=20;
                 Panel1.Caption:='';
              with  SQLQuery1 do
                 begin
                   DataBase := MSSQLConnection1;
                   Transaction := MSSQLConnection1.Transaction;
                   SQL.Clear;
                   SQL.Add('Select Qtd');
                   SQL.Add('From Stock ');
                   SQL.Add('Where IDLocal = 3 AND IDProduto='+FloatToStr(i));
                 end;
              with SQLQuery1 do
                   begin
                    if Active then
                      Close;
                    Open;
                   end;
              DBGrid1.Columns[0].Visible:=false;
              qtd:=SQLQuery1.Fields[0].AsInteger;
              if (qtd<20) and (qtd>=0)  then
              begin
                   Panel1.Caption:= '';
                 //Prepara o SQL a submeter à BD
                      stSQLText := 'UPDATE Stock SET Qtd='+ FloatToStr(qtdColocada) +'Where IDLocal=3 AND IDProduto='+FloatToStr(i);
                      SQLQuery1.Sql.Text:= stSQLText;
                      SQLQuery1.Prepare;

                      //Insere na base de dados
                      SQLQuery1.ExecSQL;

                      //Confirma as alterações
                      SQLQuery1.SQLTransaction.Commit;
              end
              else
              begin
                   Panel1.Caption:= 'Quantidade de Produto ' + FloatToStr(i)+' com stock cheio em armazém';
              end;
        end
        else
        begin
               with  SQLQuery1 do
                   begin
                     DataBase := MSSQLConnection1;
                     Transaction := MSSQLConnection1.Transaction;
                     SQL.Clear;
                     SQL.Add('Select Qtd, Codigo_Unid');
                     SQL.Add('From Stock ');
                     SQL.Add('Where IDLocal = 3 AND IDProduto='+FloatToStr(i));
                   end;
                with SQLQuery1 do
                     begin
                      if Active then
                        Close;
                      Open;
                     end;
                DBGrid1.Columns[0].Visible:=false;
                DBGrid1.Columns[1].Visible:=false;
                qtd:=SQLQuery1.Fields[0].AsInteger;
                UnidadeMedida:=SQLQuery1.Fields[1].AsInteger;
                if (qtd>=5) then
                begin
                     Panel1.Caption:= '';
                  with  SQLQuery1 do
                     begin
                       DataBase := MSSQLConnection1;
                       Transaction := MSSQLConnection1.Transaction;
                       SQL.Clear;
                       SQL.Add('Select Qtd ');
                       SQL.Add('From Stock ');
                       SQL.Add('Where IDLocal = '+IntToStr(Local)+' AND IDProduto='+FloatToStr(i));
                     end;
                  with SQLQuery1 do
                       begin
                        if Active then
                          Close;
                        Open;
                       end;
                  qtdBar:=SQLQuery1.Fields[0].AsInteger;
                  with  SQLQuery1 do
                     begin
                       DataBase := MSSQLConnection1;
                       Transaction := MSSQLConnection1.Transaction;
                       SQL.Clear;
                       SQL.Add('Select Unidade ');
                       SQL.Add('From Unidade_Medida ');
                       SQL.Add('Where Codigo_Unid ='+FloatToStr(UnidadeMedida));
                     end;
                  with SQLQuery1 do
                       begin
                        if Active then
                          Close;
                        Open;
                       end;
                   DBGrid1.Columns[0].Visible:=false;
                   Unidade:=SQLQuery1.Fields[0].AsInteger;
                   qtdBar:=qtdBar + (qtdRetirada*Unidade);
                   //Panel1.Caption:= FloatToStr(qtdBar);

                   //Prepara o SQL a submeter à BD
                        stSQLText := 'UPDATE Stock SET Qtd='+ FloatToStr(qtdBar) +'Where IDLocal='+IntToStr(Local)+' AND IDProduto='+FloatToStr(i);
                        SQLQuery1.Sql.Text:= stSQLText;
                        SQLQuery1.Prepare;

                        //Insere na base de dados
                        SQLQuery1.ExecSQL;

                        //Confirma as alterações
                        SQLQuery1.SQLTransaction.Commit;

                         //Prepara o SQL a submeter à BD
                        stSQLText := 'UPDATE Stock SET Qtd='+ FloatToStr(qtd-qtdRetirada) +'Where IDLocal=3 AND IDProduto='+FloatToStr(i);
                        SQLQuery1.Sql.Text:= stSQLText;
                        SQLQuery1.Prepare;

                        //Insere na base de dados
                        SQLQuery1.ExecSQL;

                        //Confirma as alterações
                        SQLQuery1.SQLTransaction.Commit;

                end
                else
                begin
                     Panel1.Caption:= 'Quantidade do produto '+IntToStr(i)+'insuficiente em armazém';
                end;
        end;


        end;

  end;
  Form4.Edit1.Clear;

end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
    Panel1.Caption:= '';
    Application.Terminate;
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
  Close
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
var StringData:String;
var qtdPaga, qtdPedida, produto, i, o, qtdBar, qtdProdutos:integer;
var Despesa, Recebido, preco_venda,preco_compra:Double;
begin
  Despesa:=0;
  Recebido:=0;
  produto:=0;

  with  SQLQuery1 do
      begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select Distinct Dia');
           SQL.Add('From Pedido');
       end;
      with SQLQuery1 do
      begin
           if Active then
              Close;
              Open;
      end;
  Panel1.Caption:= '';
  Form3.showmodal;
  StringData:=Form3.Edit1.Text;
  if(StringData<>'') then
  begin

     //Quantos bares existem
     with  SQLQuery1 do
      begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select COUNT(IDLocal)');
           SQL.Add('From Local ');
           SQL.Add('Where Tipo=''Bar''');
      end;
      with SQLQuery1 do
      begin
           if Active then
              Close;
              Open;
      end;
      DBGrid1.Columns[0].Visible:=false;
      qtdBar:=SQLQuery1.Fields[0].AsInteger;

      //Quantos Produtos existem
      with  SQLQuery1 do
      begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select COUNT(IDProduto)');
           SQL.Add('From Produto ');
      end;
      with SQLQuery1 do
      begin
           if Active then
              Close;
              Open;
      end;
      DBGrid1.Columns[0].Visible:=false;
      qtdProdutos:=SQLQuery1.Fields[0].AsInteger;
     for o:=1 to qtdBar do
     begin
          for i:=1 to qtdProdutos do
          begin
               produto:=0;
               qtdPaga:=0;
               qtdPedida:=0;
               with  SQLQuery1 do
                begin
                   DataBase := MSSQLConnection1;
                   Transaction := MSSQLConnection1.Transaction;
                   SQL.Clear;
                   SQL.Add('Select IDProduto,Qtd_Paga, Qtd_Pedida');
                   SQL.Add('From Pedido P, Linha_Pedido L');
                   SQL.Add('Where P.IDLocal = '+ IntToStr(o)+'AND P.Cod_EstadoPedido=4 AND P.IDPedido=L.IDPedido AND Dia = '''+data+''' AND IDProduto='+IntToStr(i));
                end;

               with SQLQuery1 do
                     begin
                      if Active then
                        Close;
                      Open;
                     end;

               produto:=SQLQuery1.Fields[0].AsInteger;
               qtdPaga:=SQLQuery1.Fields[1].AsInteger;
               qtdPedida:=SQLQuery1.Fields[2].AsInteger;

               with  SQLQuery1 do
                begin
                   DataBase := MSSQLConnection1;
                   Transaction := MSSQLConnection1.Transaction;
                   SQL.Clear;
                   SQL.Add('Select Preco_Compra, Preco_Venda');
                   SQL.Add('From Produto');
                   SQL.Add('Where IDProduto= '+ FloatToStr(produto));
                end;
               with SQLQuery1 do
                   begin
                    if Active then
                      Close;
                    Open;
           end;

                   DBGrid1.Columns[0].Visible:=false;
                   DBGrid1.Columns[1].Visible:=false;
                   preco_compra:=SQLQuery1.Fields[0].AsFloat;
                   preco_venda:=SQLQuery1.Fields[1].AsFloat;
                   Despesa:= Despesa + (preco_compra*qtdPedida);
                   Recebido:=Recebido + (preco_venda*qtdPaga);
                 end;

           Panel1.Caption:='Bares: - Despesas: '+FloatToStr(Despesa) + '€  - Recebido: '+FloatToStr(Recebido) + '€   - Lucro: '+FloatToStr(Recebido-Despesa) + '€';

     end;
  end;
  Form3.Edit1.Clear;
end;

end.

