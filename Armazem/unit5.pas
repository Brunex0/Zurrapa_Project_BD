unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    buOk: TButton;
    buCancel: TButton;
    edHostName: TEdit;
    edDataBase: TEdit;
    edUserName: TEdit;
    edPassword: TEdit;
    laHostName: TLabel;
    laDataBase: TLabel;
    laUserName: TLabel;
    laPassword: TLabel;
    paIpAddress: TPanel;
    procedure buCancelClick(Sender: TObject);
    procedure buOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

Function GetLoginData(var aHostName, aDatabase, aUserName, aPassword :String):Boolean;

implementation

{$R *.lfm}

Uses Winsock;

Function GetLoginData(var aHostName, aDatabase, aUserName, aPassword :String):Boolean;
begin
  //Inicializar os parâmetros
  Result    := False;

  aHostName := '';
  aDatabase := '';
  aUserName := '';
  aPassword := '';

  Try
    With  TForm5.Create(Nil) do
    Try
      Result := ShowModal = mrOk;
      if Result then
      begin
        aHostName := edHostName.Text;
        aDatabase := edDatabase.Text;
        aUserName := edUserName.Text;
        aPassword := edPassword.Text;
      end
    finally
      Free
    end;
  except
    Result := False
  end;
end;


// How to get you local IP address in Windows with Pascal:
// https://afuriza.wordpress.com/2016/01/27/how-to-get-you-local-ip-address-in-windows-with-pascal/
function getlocalip:string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe : PHostEnt;
  pptr : PaPInAddr;
  buffer : array [0..63] of char;
  i : integer;
  GInitData : TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result:='';
  GetHostName(buffer, sizeof(buffer));
  phe:=gethostbyname(buffer);
  if phe = nil then
  begin
    Exit;
  end;
  pptr:= PaPInAddr(phe^.h_addr_list);
  i:=0;
  while not (pptr^[i] = nil) do
  begin
    result:=StrPas(inet_ntoa(pptr^[i]^));
    Inc(i);
  end;
  WSACleanup;
end;

{ TForm5 }

procedure TForm5.buOkClick(Sender: TObject);
begin
  ModalResult := mrOk
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  paIpAddress.Caption:= 'My IP: '+ getlocalip;
end;

procedure TForm5.buCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

end.

