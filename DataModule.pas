unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.DApt,
  Vcl.Dialogs;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    OpenDialog: TOpenDialog;
    procedure DataModuleCreate(Sender: TObject);
    function isDBConnected():Boolean;
    function User_Login_Check(var uiUserName: String;
      var uiPassword: String): Boolean;
    function Credentials_Check(var uiUserName: String;
      var uiPassword: String): Boolean;
    function Is_Active_User(var userID: Integer): Boolean;
    function Is_Logged_In(var userID: Integer): Boolean;
    function Is_Admin_User(var userID: Integer): Boolean;
    function Update_DB_Loggin_Time(var userID: Integer): Boolean;
    function Update_DB_Logged_in_Status_True(var userID: Integer): Boolean;
    function Update_DB_Logged_in_Status_False(var userID: Integer): Boolean;
    function Find_Account_ID(id: Integer): TArray<String>;
    function Find_Contact_ID(id: Integer): TArray<String>;
    function Find_User_ID(id: Integer): TArray<String>;
    function Find_User_Username(thisUsername: String): TArray<String>;
    function Update_DB_Account_Details(Aid: String; Aname: String;
      Aphone: String; Aaddress: String; Apcontact: String;
      Acdate: String): Boolean;
    function Update_DB_Contact_Details(Cid: String; Cfullname: String;
      Cnameprefix: String; Cfirstname: String; Clastname: String;
      Cphone: String; Cemail: String): Boolean;
    function Update_DB_User_Details(Uid: String; Uusername: String;
      Ufirstname: String; Ulastname: String; Upassword: String; Ucdate: String;
      Update: String; Uldate: String; Uactive: String; Uloggedin: String;
      Uadmin: String): Boolean;
    function Next_Account_ID(): Integer;
    function Next_User_ID(): Integer;
    function Delete_Account(id: Integer): Boolean;
    function Delete_User(id: Integer): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;
  userID: Integer;
  userFullName: String;
  userName: String;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
{ Creates DB connection on Unit creation
  path is relative to app location }
begin
  ShowMessage('Please select SQLite Database file.');
  openDialog := TOpenDialog.Create(self);

  {Set up the starting directory to be the current one}
  openDialog.InitialDir := GetCurrentDir;

  {Only allow existing files to be selected}
  openDialog.Options := [ofFileMustExist];

  {Allow only .s3db files to be selected}
  openDialog.Filter :=
    'SQLite 3 Database|*.s3db';

  {Select pascal files as the starting filter type}
  openDialog.FilterIndex := 2;

  {Display the open file dialog}
  if openDialog.Execute then
  begin
    FDConnection1.Params.Add('Database=' + openDialog.FileName);
    FDConnection1.Params.Values['Database'] := (openDialog.FileName);
//    FDConnection1.FetchOptions.Unidirectional := True;
    FDConnection1.Connected := True;
    FDConnection1.Open;
  end
  else
  begin
    FDConnection1.Free;
    raise Exception.Create('No database selected');
  end;

  {Free up the dialog}
  openDialog.Free;
  {Initial value for currently logged in user id, loggin process has not been completed yet.}
  userID := -1;
end;


function TDataModule1.isDBConnected():Boolean;
begin
  try
    if FDConnection1.Ping then
    begin
      result := True;
    end
  except
    on E:Exception do
    begin
      ShowMessage('Database connection failure: ' + E.Message);
      Result := False;
    end;
  end;
end;


function TDataModule1.User_Login_Check(var uiUserName: String;
  var uiPassword: String): Boolean;
{ Manages users login attempts by calling various functions }
begin
  if (Credentials_Check(uiUserName, uiPassword)) {Are credentials correct}
    and (Is_Active_User(userID)) {Is the user account status active}
    and (Update_DB_Loggin_Time(userID)) {update db loggin timestamp}
    and (Update_DB_Logged_in_Status_True(userID)) {update db logged in status to True}
  then
    Result := True
  else
    Result := False
end;

function TDataModule1.Credentials_Check(var uiUserName: String;
  var uiPassword: String): Boolean;
{ Confirm given credentials are in DB }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    query.CloseStreams;
    query.Connection := FDConnection1;
    query.SQL.Text :=
      'SELECT ID, USERNAME, FIRST_NAME, LAST_NAME, PASSWORD FROM USERS WHERE USERNAME =''' + uiUserName
      + ''' AND PASSWORD =''' + uiPassword + '''';
    query.Open();
    if Length(query.FieldByName('USERNAME').AsString) > 0 then
    begin
      userID := query.FieldByName('ID').AsInteger;
      userFullName := query.FieldByName('FIRST_NAME').AsString + ' ' + query.FieldByName('LAST_NAME').AsString;
      query.Close;
      query.DisposeOf;
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Login Failure: ' + E.Message);
      Result := False;
    end;
  end;

end;

function TDataModule1.Is_Active_User(var userID: Integer): Boolean;
{ Confirm user status is Active }
var
  query: TFDQuery;
  isActive: String;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT ID, ACTIVE FROM USERS WHERE ID = ' +
        IntToStr(userID);
      query.Open();
      isActive := query.FieldByName('ACTIVE').AsString;
      if isActive = 'True' then
      begin
        query.Close;
        query.DisposeOf;
        Result := True;
      end
      else
      begin
        query.Close;
        query.DisposeOf;
        Result := False;
      end;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ShowMessage('Login Failure: ' + E.Message);
    end;
  end;
end;

function TDataModule1.Is_Logged_In(var userID: Integer): Boolean;
{ Confirm user is Logged in }
var
  query: TFDQuery;
  Is_Logged_In: String;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT ID, LOGGED_IN FROM USERS WHERE ID = ' +
        IntToStr(userID);
      query.Open();
      Is_Logged_In := query.FieldByName('LOGGED_IN').AsString;
      if Is_Logged_In = 'True' then
      begin
        query.Close;
        query.DisposeOf;
        Result := True;
      end
      else
      begin
        query.Close;
        query.DisposeOf;
        Result := False;
      end;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ShowMessage('TDataModule1.Is_Logged_In Failure: ' + E.Message);
    end;
  end;

end;

function TDataModule1.Is_Admin_User(var userID: Integer): Boolean;
{ Confirm user is Administrator }
var
  query: TFDQuery;
  is_admin: String;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT ID, IS_ADMIN FROM USERS WHERE ID = ' +
        IntToStr(userID);
      query.Open();
      is_admin := query.FieldByName('IS_ADMIN').AsString;
      if is_admin = 'True' then
      begin
        query.Close;
        query.DisposeOf;
        Result := True;
      end
      else
      begin
        query.Close;
        query.DisposeOf;
        Result := False;
      end;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ShowMessage('TDataModule1.Is_Admin_User Failure: ' + E.Message);
    end;
  end;

end;

function TDataModule1.Update_DB_Loggin_Time(var userID: Integer): Boolean;
{ Set DB LAST_LOGIN time to now in USERS Table }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.ExecSQL('UPDATE USERS SET LAST_LOGIN = datetime(' + '''now''' +
        ') WHERE ID = ' + IntToStr(userID));
      query.DisposeOf;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ShowMessage('Login Failure: ' + E.Message);
    end;
  end;

end;

function TDataModule1.Update_DB_Logged_in_Status_True
  (var userID: Integer): Boolean;
{ Set DB LOGGED_IN to TRUE in USERS Table }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.ExecSQL('UPDATE USERS SET LOGGED_IN = ''' + 'True' +
        ''' WHERE ID = ' + IntToStr(userID));
      query.DisposeOf;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ShowMessage('Login Failure: ' + E.Message);
    end;
  end;

end;

function TDataModule1.Update_DB_Logged_in_Status_False
  (var userID: Integer): Boolean;
{ Set DB LOGGED_IN to FALSE in USERS Table }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      if userID <> -1 then
      begin
        query.CloseStreams;
        query.Connection := FDConnection1;
        query.ExecSQL('UPDATE USERS SET LOGGED_IN = ''' + 'False' +
          ''' WHERE ID = ' + IntToStr(userID));
        query.DisposeOf;
        Result := True;
      end
      else
        Result := True;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ShowMessage('Logout Failure: ' + E.Message);
    end;
  end;

end;

function TDataModule1.Find_Account_ID(id: Integer): TArray<String>;
{ Find given account in db ACCOUNTS table matching by id }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT * FROM ACCOUNTS WHERE ID = ' + IntToStr(id);
      query.Open();
      SetLength(Result, 9);
      Result[0] := query.FieldByName('ID').AsString;
      Result[1] := query.FieldByName('NAME').AsString;
      Result[2] := query.FieldByName('CREATED_DATE').AsString;
      Result[3] := query.FieldByName('CREATED_USER').AsString;
      Result[4] := query.FieldByName('MODIFIED_DATE').AsString;
      Result[5] := query.FieldByName('MODIFIED_USER').AsString;
      Result[6] := query.FieldByName('PHONE_NUMBER').AsString;
      Result[7] := query.FieldByName('ADDRESS').AsString;
      Result[8] := query.FieldByName('PRIMARY_CONTACT').AsString;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

function TDataModule1.Find_Contact_ID(id: Integer): TArray<String>;
{ Find given contact in db CONTACTS table matching by id }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT * FROM CONTACTS WHERE ID = ' + IntToStr(id);
      query.Open();
      SetLength(Result, 12);
      Result[0] := query.FieldByName('ID').AsString;
      Result[1] := query.FieldByName('FULL_NAME').AsString;
      Result[2] := query.FieldByName('NAME_PREFIX').AsString;
      Result[3] := query.FieldByName('FIRST_NAME').AsString;
      Result[4] := query.FieldByName('LAST_NAME').AsString;
      Result[5] := query.FieldByName('CREATED_USER').AsString;
      Result[6] := query.FieldByName('CREATED_DATE').AsString;
      Result[7] := query.FieldByName('MODIFIED_USER').AsString;
      Result[8] := query.FieldByName('MODIFIED_DATE').AsString;
      Result[9] := query.FieldByName('PHONE_NUMBER').AsString;
      Result[10] := query.FieldByName('EMAIL').AsString;
      Result[11] := query.FieldByName('ACCOUNT').AsString;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

function TDataModule1.Find_User_ID(id: Integer): TArray<String>;
{ Find given user in db USERS table matching by id }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT * FROM USERS WHERE ID = ' + IntToStr(id);
      query.Open();
      SetLength(Result, 11);
      Result[0] := query.FieldByName('ID').AsString;
      Result[1] := query.FieldByName('USERNAME').AsString;
      Result[2] := query.FieldByName('FIRST_NAME').AsString;
      Result[3] := query.FieldByName('LAST_NAME').AsString;
      Result[4] := query.FieldByName('PASSWORD').AsString;
      Result[5] := query.FieldByName('CREATED_DATE').AsString;
      Result[6] := query.FieldByName('PASSWORD_CHANGED').AsString;
      Result[7] := query.FieldByName('LAST_LOGIN').AsString;
      Result[8] := query.FieldByName('ACTIVE').AsString;
      Result[9] := query.FieldByName('LOGGED_IN').AsString;
      Result[10] := query.FieldByName('IS_ADMIN').AsString;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;


function TDataModule1.Find_User_Username(thisUsername: String): TArray<String>;
{ Find given user in db USERS table matching by username }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT * FROM USERS WHERE USERNAME = ''' + thisUsername + '''';
      query.Open();
      userName := query.FieldByName('USERNAME').AsString;
      SetLength(Result, 11);
      Result[0] := query.FieldByName('ID').AsString;
      Result[1] := query.FieldByName('USERNAME').AsString;
      Result[2] := query.FieldByName('FIRST_NAME').AsString;
      Result[3] := query.FieldByName('LAST_NAME').AsString;
      Result[4] := query.FieldByName('PASSWORD').AsString;
      Result[5] := query.FieldByName('CREATED_DATE').AsString;
      Result[6] := query.FieldByName('PASSWORD_CHANGED').AsString;
      Result[7] := query.FieldByName('LAST_LOGIN').AsString;
      Result[8] := query.FieldByName('ACTIVE').AsString;
      Result[9] := query.FieldByName('LOGGED_IN').AsString;
      Result[10] := query.FieldByName('IS_ADMIN').AsString;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;


function TDataModule1.Update_DB_Account_Details(Aid: String; Aname: String;
  Aphone: String; Aaddress: String; Apcontact: String; Acdate: String): Boolean;
{ Update given account in db ACCOUNTS table matching by id }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    { Update Account. Associated with Edit button }
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      if Length(Acdate) < 1 then
      begin
        query.ExecSQL('UPDATE ACCOUNTS SET ' + 'NAME = :name, ' +
          'PHONE_NUMBER = :phone_number, ' + 'ADDRESS = :address, ' +
          'PRIMARY_CONTACT = :primary_contact, ' + 'MODIFIED_DATE = datetime(' +
          '''now''' + '), ' + 'MODIFIED_USER = :modified_user ' + 'WHERE ID = '
          + Aid, [Trim(Aname), Trim(Aphone), Trim(Aaddress), Trim(Apcontact),
          Trim(userFullName)
          ]);
        query.DisposeOf;
        Result := True;
      end
      else
      { Create Account. Associated with Create button }
      begin
        query.ExecSQL('INSERT INTO ACCOUNTS (ID, USERNAME, FIRST_NAME, LAST_NAME, PASSWORD, CREATED_DATE, PASSWORD_CHANGED, LAST_LOGIN, ACTIVE, LOGGED_IN, IS_ADMIN) VALUES' +
          '(:ID,:NAME,:CREATED_DATE,:CREATED_BY,:MODIFIED_DATE,:MODIFIED_USER,:PHONE_NUMBER,:ADDRESS,:PRIMARY_CONTACT)',
          [Trim(Aid), Trim(Aname), Acdate, Trim(userFullName),
          '', '', Trim(Aphone), Trim(Aaddress), Trim(Apcontact)]);
        query.DisposeOf;
        Result := True;
      end;
    end;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := False;
    end;
  end;

end;

function TDataModule1.Update_DB_Contact_Details(Cid: String; Cfullname: String;
  Cnameprefix: String; Cfirstname: String; Clastname: String; Cphone: String;
  Cemail: String): Boolean;
{ Update given contact in db CONTACTS table matching by id }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.ExecSQL('UPDATE CONTACTS SET ' + 'FULL_NAME = :FULL_NAME, ' +
        'NAME_PREFIX = :NAME_PREFIX, ' + 'FIRST_NAME = :FIRST_NAME, ' +
        'LAST_NAME = :LAST_NAME, ' + 'PHONE_NUMBER = :PHONE_NUMBER, ' +
        'EMAIL = :EMAIL, ' + 'ACCOUNT = ACCOUNT, ' + 'MODIFIED_DATE = datetime('
        + '''now''' + '), ' + 'MODIFIED_USER = :MODIFIED_USER ' + 'WHERE ID = '
        + Cid, [Trim(Cfullname), Trim(Cnameprefix), Trim(Cfirstname),
        Trim(Clastname), Trim(Cphone), Trim(Cemail), Trim(userFullName)]);
      query.DisposeOf;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := False;
    end;
  end;

end;

function TDataModule1.Update_DB_User_Details(Uid: String; Uusername: String;
  Ufirstname: String; Ulastname: String; Upassword: String; Ucdate: String;
  Update: String; Uldate: String; Uactive: String; Uloggedin: String;
  Uadmin: String): Boolean;
{ Update given user in db USERS table matching by id }
var
  query: TFDQuery;
  Is_Logged_In: String;
  CurrentUid: Integer;
begin

  query := TFDQuery.Create(nil);
  CurrentUid := StrToInt(Uid);

  try
    { Update User. Associated with Edit button }
    begin
      try
        if self.Is_Logged_In(CurrentUid) then
          Is_Logged_In := 'True'
        else
          Is_Logged_In := 'False';
      except
        on E: Exception do
          ShowMessage('Is_Logged_In Failure: ' + E.Message);
      end;
      query.CloseStreams;
      query.Connection := FDConnection1;
      if Length(Uldate) > 1 then
      begin
        query.ExecSQL('UPDATE USERS SET ' + 'USERNAME = :USERNAME, ' +
          'FIRST_NAME = :FIRST_NAME, ' + 'LAST_NAME = :LAST_NAME, ' +
          'PASSWORD = :PASSWORD, ' + 'CREATED_DATE = :CREATED_DATE, ' +
          'PASSWORD_CHANGED = :PASSWORD_CHANGED, ' +
          'LAST_LOGIN = :LAST_LOGIN, ' + 'ACTIVE = :ACTIVE, ' +
          'LOGGED_IN = :LOGGED_IN, ' + 'IS_ADMIN = :IS_ADMIN ' +
          'WHERE ID = :ID', [Trim(Uusername), Trim(Ufirstname), Trim(Ulastname),
          Trim(Upassword), Trim(Ucdate), Trim(Update), Trim(Uldate),
          Trim(Uactive), Trim(Is_Logged_In), Trim(Uadmin), StrToInt(Uid)]);
        query.DisposeOf;
        Result := True;
      end
      else
      { Create User. Associated with Create button }
      begin
      query.ExecSQL('INSERT INTO USERS (ID, USERNAME, FIRST_NAME, LAST_NAME, PASSWORD, CREATED_DATE, PASSWORD_CHANGED, LAST_LOGIN, ACTIVE, LOGGED_IN, IS_ADMIN) VALUES ' +
        '(:ID,:USERNAME,:FIRST_NAME,:LAST_NAME,:PASSWORD,:CREATED_DATE,' +
        ':PASSWORD_CHANGED,:LAST_LOGIN,:ACTIVE,:LOGGED_IN,:IS_ADMIN)',
        [Trim(Uid), Trim(Uusername), Trim(Ufirstname), Trim(Ulastname),
        Trim(Upassword), Trim(Ucdate), Trim(Update), Trim(Uldate),
        Trim(Uactive), 'False', Trim(Uadmin)]);
      query.DisposeOf;
      Result := True;
      end;
    end;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := False;
    end;
  end;

end;

function TDataModule1.Next_Account_ID(): Integer;
{ Query ACCOUNTS table for next available ID }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT ID FROM ACCOUNTS ORDER BY ID DESC';
      query.Open();
      Result := (query.FieldByName('ID').AsInteger + 1);
      query.DisposeOf;
    end
  except
    on E: Exception do
    begin
      ShowMessage('DB Query Failure: ' + E.Message);
    end;
  end;

end;

function TDataModule1.Next_User_ID(): Integer;
{ Query USERS table for next available ID }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.SQL.Text := 'SELECT ID FROM USERS ORDER BY ID DESC';
      query.Open();
      Result := (query.FieldByName('ID').AsInteger + 1);
      query.DisposeOf;
    end
  except
    on E: Exception do
    begin
      ShowMessage('DB Query Failure: ' + E.Message);
    end;
  end;

end;

function TDataModule1.Delete_Account(id: Integer): Boolean;
{ Delete given Account in db ACCOUNTS table matching by id }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.ExecSQL('DELETE FROM ACCOUNTS WHERE ID = ' + IntToStr(id));
      query.DisposeOf;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := False;
    end;
  end;
end;

function TDataModule1.Delete_User(id: Integer): Boolean;
{ Delete given Account in db USERS table matching by id }
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    {Define the SQL Query}
    begin
      query.CloseStreams;
      query.Connection := FDConnection1;
      query.ExecSQL('DELETE FROM USERS WHERE ID = ' + IntToStr(id));
      query.DisposeOf;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := False;
    end;
  end;
end;

end.
