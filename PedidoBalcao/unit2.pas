unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, MSSQLConn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls;

type
  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    Edit1: TEdit;
    Label1: TLabel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

  public

  end;

var
  Form2: TForm2;

Function GetNumBar(var numBar:integer):Boolean;

implementation

Uses Unit1;

{$R *.lfm}

{ TForm2 }
Function GetNumBar(var numBar:integer):Boolean;
var tempBar:String;
var num_Bar:Integer;
begin
  Result:=False;
  numBar:=0;
  Try
    with TForm2.Create(Nil) do
    Try
      Result:= ShowModal=mrOk;
      if Result then
      begin
        num_Bar := StrToInt(Edit1.Text);
        with  SQLQuery1 do
        begin
         DataBase := Form1.MSSQLConnection1;
         Transaction := Form1.MSSQLConnection1.Transaction;
         SQL.Clear;
         SQL.Add('Select IDLocal');
         SQL.Add('From Local');
         SQL.Add('Where IDLocal ='+FloatToStr(num_Bar) + ' AND Tipo=''Bar''');
        end;
        with SQLQuery1 do
             begin
              if Active then
                Close;
              Open;
             end;
        tempBar:=SQLQuery1.Fields[0].AsAnsiString;
        if (tempBar='') then
           Application.Terminate
        else
           numBar:=num_Bar;
      end;
    finally
      Free
    end;
  except
    Result:=False
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
end;

end.

