program MiniCRM;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  Account in 'Account.pas' {frmAccount: TFrame},
  Contact in 'Contact.pas' {frmContact: TFrame},
  Search in 'Search.pas' {frmSearch: TFrame},
  Login in 'Login.pas' {frmLogin: TFrame},
  DataModule in 'DataModule.pas' {DataModule1: TDataModule},
  User in 'User.pas' {frmUser: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
