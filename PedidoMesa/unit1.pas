unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, MSSQLConn, Forms, Controls, Graphics, Dialogs,
  DBGrids, Menus, ExtCtrls, StdCtrls;
var num_Bar, NMesa, option:Integer;
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
    MSSQLConnection1: TMSSQLConnection;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;


implementation

uses Unit2, Unit3, Unit4, Unit5;
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

  numBar:=0;
   if not GetNumBar(numBar) then
      Application.Terminate;
   num_Bar:=numBar;
    with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select M.N_Mesa, M.Cod_EstadoMesa, E.Estado');
           SQL.Add('From Mesa M, Estado_Mesa E');
           SQL.Add('Where M.Cod_EstadoMesa=E.Cod_EstadoMesa AND M.IDLocal=' + IntToStr(num_Bar));
         end;
   with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;
   if not setNumBar(num_Bar) then
     num_bar:=num_Bar;

end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
var estado:String;
var N_MesaMarcar:Integer;
begin
  N_MesaMarcar:=SQLQuery1.Fields[0].AsInteger;
  if(option=1) then
  begin
       stSQLText := 'UPDATE Mesa SET Cod_EstadoMesa= 1, IDEmpregado=NULL Where N_Mesa='+IntToStr(N_MesaMarcar);
       SQLQuery1.Sql.Text:= stSQLText;
       SQLQuery1.Prepare;
       //Insere na base de dados
       SQLQuery1.ExecSQL;
       //Confirma as alterações
       SQLQuery1.SQLTransaction.Commit;

       with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select M.N_mesa, E.Estado');
           SQL.Add('From Mesa M, Estado_Mesa E');
           SQL.Add('Where M.Cod_EstadoMesa=E.Cod_EstadoMesa AND IDLocal=' + IntToStr(num_Bar));
         end;
       with SQLQuery1 do
       begin
            if Active then
              Close;
            Open;
       end;
       option:=0;
  end
  else
  if(option=0) then
  begin
       with  SQLQuery1 do
       begin
            DataBase := MSSQLConnection1;
            Transaction := MSSQLConnection1.Transaction;
            SQL.Clear;
            SQL.Add('Select P.N_Mesa, P.IDPedido, E.Estado');
            SQL.Add('From Pedido P, Estado_Pedido E');
            SQL.Add('Where P.Cod_EstadoPedido=E.Cod_EstadoPedido AND P.Cod_EstadoPedido<>4 AND IDLocal=' + IntToStr(num_Bar)+'AND P.N_Mesa='+IntToStr(SQLQuery1.Fields[0].AsInteger));
       end;
       with SQLQuery1 do
       begin
       if Active then
          Close;
       Open;
       end;
  end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
   with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select M.N_Mesa, M.Cod_EstadoMesa, E.Estado');
           SQL.Add('From Mesa M, Estado_Mesa E');
           SQL.Add('Where M.Cod_EstadoMesa=E.Cod_EstadoMesa AND M.IDLocal=' + IntToStr(num_Bar));
         end;
   with SQLQuery1 do
           begin
            if Active then
              Close;
            Open;
           end;
   Form3.Label5.Caption:=DateToStr(Date);
   Form3.Label7.Caption:=TimeToStr(Time);
   Form3.Show;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
   option:=0;
    with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select M.N_mesa, E.Estado');
           SQL.Add('From Mesa M, Estado_Mesa E');
           SQL.Add('Where M.Cod_EstadoMesa=E.Cod_EstadoMesa AND IDLocal=' + IntToStr(num_Bar));
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
  setnumBar(num_Bar);
  with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select N_Mesa, IdPedido');
           SQL.Add('From Pedido');
           SQL.Add('Where IDLocal=' + IntToStr(num_Bar)+' AND Cod_EstadoPedido<>4 AND Cod_EstadoPedido<>1');
         end;
   with SQLQuery1 do
   begin
        if Active then
           Close;
        Open;
   end;
  Form4.Show;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  option:=1;
  with  SQLQuery1 do
         begin
           DataBase := MSSQLConnection1;
           Transaction := MSSQLConnection1.Transaction;
           SQL.Clear;
           SQL.Add('Select N_mesa');
           SQL.Add('From Mesa');
           SQL.Add('Where IDLocal=' + IntToStr(num_Bar)+' AND Cod_EstadoMesa=3');
         end;
   with SQLQuery1 do
   begin
        if Active then
           Close;
        Open;
   end

end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  Application.Terminate;
end;


end.

