unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.FileCtrl,
  DataModule;

type
  TfrmLogin = class(TFrame)
    fldUsername: TEdit;
    fldPassword: TEdit;
    btnLogin: TButton;
    btnLoginGuest: TButton;
    lblLoginText: TLabel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    function User_Login(var Guest:Boolean):Boolean;
  private
    var
      user: String;
      pass: String;
    { Private declarations }
  public
    path: String;
    { Public declarations }
  end;

implementation

{$R *.dfm}



function TfrmLogin.User_Login(var Guest:Boolean):Boolean;
{Find given credentials in DB}
begin
  if Guest then
    begin
      user := 'Guest';
      pass := 'password';
    end
  else
    begin
      user := fldUsername.Text;
      pass := fldPassword.Text;
    end;

  if DataModule1.User_Login_Check(user, pass) then
    Result := True
  else
    Result := False;
end;


end.
