unit Account;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  System.UITypes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  DataModule;

type
  TfrmAccount = class(TFrame)
    lblAccountID: TLabel;
    lblAccountName: TLabel;
    lblAccountPhone: TLabel;
    lblAccountPContact: TLabel;
    lblAccountAddress: TLabel;
    lblAccountCreatedBy: TLabel;
    lblAccountCreatedDate: TLabel;
    lblAccountModifiedBy: TLabel;
    lblAccountModifiedDate: TLabel;
    fldAccountID: TEdit;
    fldAccountName: TEdit;
    fldAccountCreatedBy: TEdit;
    fldAccountCreatedDate: TEdit;
    fldAccountModifiedBy: TEdit;
    fldAccountModifiedDate: TEdit;
    fldAccountPhone: TEdit;
    fldAccountPContact: TEdit;
    fldAccountAddress: TMemo;
    fldAccountFind: TEdit;
    btnAccountFind: TButton;
    btnEditAccount: TButton;
    btnEditAccountSave: TButton;
    btnEditAccountCancel: TButton;
    FDTable2: TFDTable;
    DataSource2: TDataSource;
    lblAccountText: TLabel;
    btnAccountCreate: TButton;
    btnAccountDelete: TButton;
    procedure btnAccountFindClick(Sender: TObject);
    procedure btnEditAccountClick(Sender: TObject);
    procedure btnEditAccountCancelClick(Sender: TObject);
    procedure btnEditAccountSaveClick(Sender: TObject);
    procedure btnAccountCreateClick(Sender: TObject);
    procedure btnAccountDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  accountData: TArray<String>;
  newAccountFlag: Boolean;

implementation

{$R *.dfm}

procedure TfrmAccount.btnAccountFindClick(Sender: TObject);
{ Manages Account "Find" process }
var
  id: Integer;
begin
  try
    begin
      id := StrToInt(fldAccountFind.Text);
      { DB Query }
      accountData := DataModule1.Find_Account_ID(id);
      { AutoFill fields using DB Query results }
      fldAccountID.Text := accountData[0];
      fldAccountName.Text := accountData[1];
      fldAccountCreatedDate.Text := accountData[2];
      fldAccountCreatedBy.Text := accountData[3];
      fldAccountModifiedDate.Text := accountData[4];
      fldAccountModifiedBy.Text := accountData[5];
      fldAccountPhone.Text := accountData[6];
      fldAccountAddress.Text := accountData[7];
      fldAccountPContact.Text := accountData[8];
      if DataModule1.Is_Admin_User(UserID) then
      { if user has admin status, re-enable edit and delete buttons }
      begin
        btnEditAccount.Enabled := True;
        btnAccountDelete.Enabled := True;
      end;

    end;

  except
    on E: Exception do
      ShowMessage('btnAccountFindClick: ' + E.Message);
  end;

end;

procedure TfrmAccount.btnAccountCreateClick(Sender: TObject);
{ Manages Account "Create" process }
begin
  var
  timeStamp := Now;
  try
    begin
      newAccountFlag := True;
      { Enabled / Disabled }
      fldAccountID.Enabled := False;
      fldAccountCreatedBy.Enabled := False;
      fldAccountCreatedDate.Enabled := False;
      fldAccountModifiedBy.Enabled := False;
      fldAccountModifiedDate.Enabled := False;
      btnAccountFind.Enabled := False;
      btnAccountCreate.Enabled := False;
      btnEditAccount.Enabled := False;
      btnEditAccountSave.Enabled := True;
      btnEditAccountCancel.Enabled := True;
      btnAccountDelete.Enabled := False;
      { ReadOnly }
      fldAccountFind.ReadOnly := True;
      fldAccountName.ReadOnly := False;
      fldAccountPhone.ReadOnly := False;
      fldAccountAddress.ReadOnly := False;
      fldAccountPContact.ReadOnly := False;
      { Show / Hide }
      btnEditAccountSave.Show;
      btnEditAccountCancel.Show;
      { AutoFill }
      fldAccountID.Text := IntToStr(DataModule1.Next_Account_ID());
      fldAccountFind.Text := fldAccountID.Text;
      fldAccountCreatedBy.Text := IntToStr(UserID);
      fldAccountCreatedDate.Text := FormatDateTime('yyyy-mm-dd hh:nn:ss',
        timeStamp);
    end

  except
    on E: Exception do
      ShowMessage('btnAccountCreateClick: ' + E.Message);
  end;

end;

procedure TfrmAccount.btnEditAccountClick(Sender: TObject);
{ Manages Account "Edit" process }
begin
  try
    newAccountFlag := False;
    if Length(fldAccountID.Text) > 0 then
    begin
      { Enabled / Disabled }
      fldAccountID.Enabled := True;
      fldAccountCreatedBy.Enabled := False;
      fldAccountCreatedDate.Enabled := False;
      fldAccountModifiedBy.Enabled := False;
      fldAccountModifiedDate.Enabled := False;
      btnAccountFind.Enabled := False;
      btnAccountCreate.Enabled := False;
      btnEditAccount.Enabled := False;
      btnEditAccountSave.Enabled := True;
      btnEditAccountCancel.Enabled := True;
      btnAccountDelete.Enabled := False;
      { ReadOnly }
      fldAccountFind.ReadOnly := True;
      fldAccountName.ReadOnly := False;
      fldAccountPhone.ReadOnly := False;
      fldAccountAddress.ReadOnly := False;
      fldAccountPContact.ReadOnly := False;
      { Show / Hide }
      btnEditAccountSave.Show;
      btnEditAccountCancel.Show;
    end

    else
      ShowMessage('No account selected')

  except
    on E: Exception do
      ShowMessage('btnEditAccountClick: ' + E.Message);
  end;

end;

procedure TfrmAccount.btnEditAccountSaveClick(Sender: TObject);
{ Manages Account "Save" process. Used by "Edit" and "Create" }
var
  Aid: String;
  Aname: String;
  Aphone: String;
  Aaddress: String;
  Apcontact: String;
  Acdate: String;

begin
  try
    begin
      Aid := fldAccountID.Text;
      Aname := fldAccountName.Text;
      Aphone := fldAccountPhone.Text;
      Aaddress := fldAccountAddress.Text;
      Apcontact := fldAccountPContact.Text;

      if newAccountFlag = True then
        { if creating a new account, rather than updating an existing one, this adds create date info }
        Acdate := fldAccountCreatedDate.Text;

      if DataModule1.Update_DB_Account_Details(Aid, Aname, Aphone, Aaddress,
        Apcontact, Acdate) then
        { if the update account details DB query was successful }
        btnEditAccountCancelClick(Sender)

      else
        // possibly add a transaction rollback here, maybe do same with delete and create functions?
        raise Exception(Exception);
    end

  except
    on E: Exception do
      ShowMessage('btnEditAccountSaveClick: ' + E.Message);
  end;

end;

procedure TfrmAccount.btnEditAccountCancelClick(Sender: TObject);
{ Manages Account "Cancel" process. Used by "Edit", "Create" and "Delete" }
begin
  try
    { Enabled / Disabled }
    fldAccountID.Enabled := True;
    fldAccountCreatedBy.Enabled := True;
    fldAccountCreatedDate.Enabled := True;
    fldAccountModifiedBy.Enabled := True;
    fldAccountModifiedDate.Enabled := True;
    btnAccountFind.Enabled := True;
    btnAccountCreate.Enabled := True;
    btnEditAccountSave.Enabled := False;
    btnEditAccountCancel.Enabled := False;
    { ReadOnly }
    fldAccountFind.ReadOnly := False;
    fldAccountName.ReadOnly := True;
    fldAccountPhone.ReadOnly := True;
    fldAccountAddress.ReadOnly := True;
    fldAccountPContact.ReadOnly := True;
    { Show / Hide }
    btnEditAccountSave.Hide;
    btnEditAccountCancel.Hide;
    { do }
    btnAccountFindClick(Sender);
  except
    on E: Exception do
      ShowMessage('btnEditAccountCancelClick: ' + E.Message);
  end;
end;

procedure TfrmAccount.btnAccountDeleteClick(Sender: TObject);
{ Manages Account "Delete" process }
var
  id: Integer;
begin
  try
    begin
      id := StrToInt(fldAccountID.Text);
      if (id > 0) and (Length(fldAccountID.Text) > 0) and
        (DataModule1.Is_Admin_User(UserID)) and
        (MessageDlg
        ('This action cannot be undone. Are you sure you wish to proceed?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes) then
      { if id is in acceptable ranges and the user has admin status and the user accepts the confirmation dialog,
        process the delete DB query }
      begin
        DataModule1.Delete_Account(id);
        btnEditAccountCancelClick(Sender);
      end
      else
        raise Exception(Exception);
    end;
  except
    on E: Exception do
      ShowMessage('btnAccountDeleteClick: ' + E.Message);
  end;
end;

end.
