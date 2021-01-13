unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, MSSQLConn, Forms, Controls, Graphics, Dialogs,
  Menus, DBGrids, ExtCtrls;

var stSQLText:String;

type

  { TForm1 }

  TForm1 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MSSQLConnection1: TMSSQLConnection;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MSSQLConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var num_Bar:Integer;

 var
  Form1: TForm1;


implementation
uses Unit2, Unit4, Unit5;
{$R *.lfm}

{ TForm1 }
procedure TForm1.FormCreate(Sender: TObject);
var aHostName, aDatabase, aUserName, aPassword :String;
var numBar:integer;
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

  Panel1.Caption:='';;
   if not GetNumBar(numBar) then
      Application.Terminate;
   num_Bar:=numBar;
   setnumBar(num_Bar);
   with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select P.IDPedido, P.N_Mesa, Dia, Hora, E.Estado');
           SQL.Add('From Pedido P, Estado_Pedido E');
           SQL.Add('Where P.Cod_EstadoPedido=E.Cod_EstadoPedido AND P.IDLocal='+IntToStr(numBar));
         end;
   with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
      Panel1.Caption:='';
      with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select P.IDPedido, P.Dia, P.Hora, E.Estado');
           SQL.Add('From Pedido P, Estado_Pedido E');
           SQL.Add('Where P.IDLocal='+IntToStr(num_Bar)+ 'AND P.Cod_EstadoPedido=E.Cod_EstadoPedido AND E.Cod_EstadoPedido=1' );

         end;
      with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;

end;


procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  Panel1.Caption:='';
  with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select P.IDPedido, IDProduto, Qtd_Pedida, Qtd_Consumida, Qtd_Paga');
           SQL.Add('From Pedido P, Linha_Pedido L');
           SQL.Add('Where P.IDPedido=L.IDPedido AND P.IDPedido=' + SQLQuery1.Fields[0].AsAnsiString);
         end;
      with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
     Panel1.Caption:='';
      with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select P.IDPedido, P.Dia, P.Hora, E.Estado');
           SQL.Add('From Pedido P, Estado_Pedido E');
           SQL.Add('Where P.IDLocal='+IntToStr(num_Bar)+ 'AND P.Cod_EstadoPedido=E.Cod_EstadoPedido AND E.Cod_EstadoPedido=3' );

         end;
      with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
   Panel1.Caption:='';
      with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select P.IDPedido, P.Dia, P.Hora, E.Estado');
           SQL.Add('From Pedido P, Estado_Pedido E');
           SQL.Add('Where P.IDLocal='+IntToStr(num_Bar)+ 'AND P.Cod_EstadoPedido=E.Cod_EstadoPedido AND E.Cod_EstadoPedido=4' );

         end;
      with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
     Panel1.Caption:='';
      with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select P.IDPedido, P.Dia, P.Hora, E.Estado');
           SQL.Add('From Pedido P, Estado_Pedido E');
           SQL.Add('Where P.IDLocal='+IntToStr(num_Bar)+ 'AND P.Cod_EstadoPedido=E.Cod_EstadoPedido AND E.Cod_EstadoPedido=2' );

         end;
      with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;

end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
   Panel1.Caption:='';
    with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select P.IDPedido, P.N_Mesa, Dia, Hora, E.Estado');
           SQL.Add('From Pedido P, Estado_Pedido E');
           SQL.Add('Where P.Cod_EstadoPedido=E.Cod_EstadoPedido AND P.IDLocal='+IntToStr(num_Bar));
         end;
   with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  Panel1.Caption:='';
  with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select P.IDPedido, E.Estado');
           SQL.Add('From Pedido P, Estado_Pedido E');
           SQL.Add('Where P.Cod_EstadoPedido=E.Cod_EstadoPedido AND P.Cod_EstadoPedido=1 AND P.IDLocal='+IntToStr(num_Bar));
         end;
   with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
            end;
  Form4.Show;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MSSQLConnection1AfterConnect(Sender: TObject);
begin

end;

end.

