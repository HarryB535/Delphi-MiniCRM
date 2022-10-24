unit User;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  System.UITypes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  DataModule;

type
  TfrmUser = class(TFrame)
    lblUserText: TLabel;
    lblUserID: TLabel;
    lblUserName: TLabel;
    lblUserFirstName: TLabel;
    lblUserLastName: TLabel;
    lblUserPassword: TLabel;
    lblUserCreatedDate: TLabel;
    lblUserLastLogin: TLabel;
    lblUserActive: TLabel;
    lblUserAdmin: TLabel;
    lblUserPasswordDate: TLabel;
    fldUserID: TEdit;
    fldUserName: TEdit;
    fldUserFirstName: TEdit;
    fldUserLastName: TEdit;
    fldUserPassword: TEdit;
    fldUserCreatedDate: TEdit;
    fldUserLastLogin: TEdit;
    fldUserActive: TEdit;
    fldUserAdmin: TEdit;
    fldUserPasswordDate: TEdit;
    fldUserFind: TEdit;
    btnUserFind: TButton;
    btnUserCreate: TButton;
    btnEditUser: TButton;
    btnEditUserSave: TButton;
    btnEditUserCancel: TButton;
    btnUserDelete: TButton;
    FDTable4: TFDTable;
    DataSource4: TDataSource;
    lblUserLoggedIn: TLabel;
    fldUserLoggedIn: TEdit;
    procedure btnUserFindClick(Sender: TObject);
    procedure btnUserCreateClick(Sender: TObject);
    procedure btnEditUserClick(Sender: TObject);
    procedure btnEditUserSaveClick(Sender: TObject);
    procedure btnEditUserCancelClick(Sender: TObject);
    procedure btnUserDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  userData: TArray<String>;
  newUserFlag: Boolean;
  UPW: String;

implementation

{$R *.dfm}

procedure TfrmUser.btnUserFindClick(Sender: TObject);
{ Manages User "Find" process }
var
  id: Integer;
begin
  try
    begin
      id := StrToInt(fldUserFind.Text);
      { DB Query }
      userData := DataModule1.Find_User_ID(id);
      { AutoFill fields using DB Query results }
      fldUserID.Text := userData[0];
      fldUserName.Text := userData[1];
      fldUserFirstName.Text := userData[2];
      fldUserLastName.Text := userData[3];
      fldUserPassword.Text := userData[4];
      fldUserCreatedDate.Text := userData[5];
      fldUserPasswordDate.Text := userData[6];
      fldUserLastLogin.Text := userData[7];
      fldUserActive.Text := userData[8];
      fldUserLoggedIn.Text := userData[9];
      fldUserAdmin.Text := userData[10];
      if DataModule1.Is_Admin_User(UserID) then
      { if user has admin status, re-enable edit and delete buttons }
      begin
        btnEditUser.Enabled := True;
        btnUserDelete.Enabled := True;
      end;
    end;
  except
    on E: Exception do
      ShowMessage('btnUserFindClick: ' + E.Message);
  end;
end;

procedure TfrmUser.btnUserCreateClick(Sender: TObject);
{ Manages User "Create" process }
begin
  var
  timeStamp := Now;
  try
    begin
      newUserFlag := True;
      { Enabled / Disabled }
      fldUserID.Enabled := False;
      fldUserPassword.Enabled := False;
      fldUserCreatedDate.Enabled := False;
      fldUserLastLogin.Enabled := False;
      fldUserActive.Enabled := False;
      fldUserPasswordDate.Enabled := False;
      fldUserLoggedIn.Enabled := False;
      btnUserFind.Enabled := False;
      btnUserCreate.Enabled := False;
      btnEditUser.Enabled := False;
      btnEditUserSave.Enabled := True;
      btnEditUserCancel.Enabled := True;
      btnUserDelete.Enabled := False;
      { ReadOnly }
      fldUserName.ReadOnly := False;
      fldUserFirstName.ReadOnly := False;
      fldUserLastName.ReadOnly := False;
      fldUserAdmin.ReadOnly := False;
      fldUserFind.ReadOnly := True;
      { Show / Hide }
      btnEditUserSave.Show;
      btnEditUserCancel.Show;
      { AutoFill }
      fldUserID.Text := IntToStr(DataModule1.Next_User_ID());
      fldUserFind.Text := fldUserID.Text;
      fldUserCreatedDate.Text := FormatDateTime('yyyy-mm-dd hh:nn:ss',
        timeStamp);
      fldUserPasswordDate.Text := FormatDateTime('yyyy-mm-dd hh:nn:ss',
        timeStamp);
      fldUserLastLogin.Text := '';
      fldUserActive.Text := 'True';
      fldUserLoggedIn.Text := 'False';
      fldUserAdmin.Text := 'False';
    end
  except
    on E: Exception do
      ShowMessage('btnUserCreateClick: ' + E.Message);
  end;

end;

procedure TfrmUser.btnEditUserClick(Sender: TObject);
{ Manages User "Edit" process }
begin
  UPW := fldUserPassword.Text;
  try
    newUserFlag := False;
    if Length(fldUserID.Text) > 0 then
    begin
      { Enabled / Disabled }
      fldUserID.Enabled := False;
      fldUserCreatedDate.Enabled := False;
      fldUserLastLogin.Enabled := False;
      fldUserPasswordDate.Enabled := False;
      fldUserLoggedIn.Enabled := False;
      btnUserFind.Enabled := False;
      btnUserCreate.Enabled := False;
      btnEditUser.Enabled := False;
      btnEditUserSave.Enabled := True;
      btnEditUserCancel.Enabled := True;
      btnUserDelete.Enabled := False;
      { ReadOnly }
      fldUserFind.ReadOnly := True;
      fldUserName.ReadOnly := False;
      fldUserFirstName.ReadOnly := False;
      fldUserLastName.ReadOnly := False;
      fldUserPassword.ReadOnly := False;
      fldUserActive.ReadOnly := False;
      fldUserAdmin.ReadOnly := False;
      { Show / Hide }
      btnEditUserSave.Show;
      btnEditUserCancel.Show;
    end
    else
      ShowMessage('No user selected')
  except
    on E: Exception do
      ShowMessage('btnEditUserClick: ' + E.Message);
  end;

end;

procedure TfrmUser.btnEditUserSaveClick(Sender: TObject);
{ Manages User "Save" process. Used by "Edit" and "Create" }
var
  Uid: String;
  Uusername: String;
  Ufirstname: String;
  Ulastname: String;
  Upassword: String;
  Ucdate: String;
  Update: String;
  Uldate: String;
  Uactive: String;
  Uloggedin: String;
  Uadmin: String;

begin
  var
  timeStamp := Now;
  try
    begin
      Uid := fldUserID.Text;
      Uusername := fldUserName.Text;
      Ufirstname := fldUserFirstName.Text;
      Ulastname := fldUserLastName.Text;
      Upassword := fldUserPassword.Text;
      Ucdate := fldUserCreatedDate.Text;
      Update := fldUserPasswordDate.Text;
      Uldate := fldUserLastLogin.Text;
      Uactive := fldUserActive.Text;
      Uloggedin := fldUserLoggedIn.Text;
      Uadmin := fldUserAdmin.Text;

      if UPW <> Upassword then
      begin
        UPW := '';
        fldUserPasswordDate.Text := FormatDateTime('yyyy-mm-dd hh:nn:ss',
          timeStamp);
        Update := fldUserPasswordDate.Text;
      end
      else
        UPW := '';

      if (Uadmin <> 'True') and (Uadmin <> 'False') then
        raise Exception.Create
          ('Field Admin Status needs a value of exactly "True" or "False". Save Operation Cancelled. Field value: "'
          + Uadmin + '"')

      else if (Uactive <> 'True') and (Uactive <> 'False') then
        raise Exception.Create
          ('Field Active Status needs a value of exactly "True" or "False". Save Operation Cancelled. Field value: "'
          + Uactive + '"')

      else if (Uloggedin <> 'True') and (Uloggedin <> 'False') then
        raise Exception.Create
          ('Field Logged In Status needs a value of exactly "True" or "False". Save Operation Cancelled. Field value: "'
          + Uloggedin + '"');

      if newUserFlag = True then
        { if creating a new user, rather than updating an existing one, this adds create date info }
        Ucdate := fldUserCreatedDate.Text;
      if DataModule1.Update_DB_User_Details(Uid, Uusername, Ufirstname,
        Ulastname, Upassword, Ucdate, Update, Uldate, Uactive, Uloggedin, Uadmin)
      then
        { if the update user details DB query was successful }
        btnEditUserCancelClick(Sender)
      else
        // possibly add a transaction rollback here, maybe do same with delete and create functions?
        raise Exception.Create('Error in DataModule1.Update_DB_User_Details');
    end
  except
    on E: Exception do
      ShowMessage('btnEditUserSaveClick: ' + E.Message);
  end;

end;

procedure TfrmUser.btnEditUserCancelClick(Sender: TObject);
{ Manages User "Cancel" process. Used by "Edit", "Create" and "Delete" }
begin
  try
    { Enabled / Disabled }
    fldUserID.Enabled := True;
    fldUserPassword.Enabled := True;
    fldUserCreatedDate.Enabled := True;
    fldUserLastLogin.Enabled := True;
    fldUserActive.Enabled := True;
    fldUserPasswordDate.Enabled := True;
    fldUserLoggedIn.Enabled := True;
    btnUserFind.Enabled := True;
    btnUserCreate.Enabled := True;
    btnEditUser.Enabled := True;
    btnEditUserSave.Enabled := False;
    btnEditUserCancel.Enabled := False;
    btnUserDelete.Enabled := True;
    { ReadOnly }
    fldUserFind.ReadOnly := False;
    fldUserName.ReadOnly := True;
    fldUserFirstName.ReadOnly := True;
    fldUserLastName.ReadOnly := True;
    fldUserPassword.ReadOnly := True;
    fldUserActive.ReadOnly := True;
    fldUserAdmin.ReadOnly := True;
    fldUserLoggedIn.ReadOnly := True;
    { Show / Hide }
    btnEditUserSave.Hide;
    btnEditUserCancel.Hide;
    { do }
    btnUserFindClick(Sender);
  except
    on E: Exception do
      ShowMessage('btnEditUserCancelClick: ' + E.Message);
  end;
end;

procedure TfrmUser.btnUserDeleteClick(Sender: TObject);
{ Manages User "Delete" process }
var
  id: Integer;
begin
  try
    begin
      id := StrToInt(fldUserID.Text);
      if (Length(fldUserID.Text) > 0) and (fldUserActive.Text = 'False') and
        (fldUserLoggedIn.Text = 'False') and (DataModule1.Is_Admin_User(UserID))
        and (MessageDlg
        ('This action cannot be undone. Are you sure you wish to proceed?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes) then
      { if id is in acceptable ranges, loggin and active status are false,
        the crm user has admin status and the user accepts the confirmation dialog,
        execute the delete DB query }
      begin
        DataModule1.Delete_User(id);
        btnEditUserCancelClick(Sender);
      end
      else
      begin
      {various error handling}
        if Length(fldUserID.Text) < 0 then
          raise Exception.Create('No user selected')
        else if (fldUserActive.Text = 'True') or (fldUserLoggedIn.Text = 'True')
        then
          raise Exception.Create('Cannot delete an Active or Logged In user')
        else
          raise Exception.Create('Unknown');
      end;
    end;
  except
    on E: Exception do
      ShowMessage('btnUserDeleteClick: ' + E.Message);
  end;
end;

end.
