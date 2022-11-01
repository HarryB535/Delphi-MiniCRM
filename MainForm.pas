unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.StdCtrls, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ButtonGroup,
  Login, DataModule, Search, Account, Contact, User;

type
  TfrmMain = class(TForm)
    frmLogin: TfrmLogin;
    frmAccount: TfrmAccount;
    frmContact: TfrmContact;
    frmUser: TfrmUser;
    frmSearch: TfrmSearch;
    lblLoggedInAs: TLabel;
    NavBar: TButtonGroup;
    procedure frmLoginbtnLoginClick(Sender: TObject);
    procedure frmLoginbtnLoginGuestClick(Sender: TObject);
    procedure frmLoginbtnLoginKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NavBarItems0Click(Sender: TObject);
    procedure NavBarItems1Click(Sender: TObject);
    procedure NavBarItems2Click(Sender: TObject);
    procedure NavBarItems3Click(Sender: TObject);
    procedure frmSearchDBGrid1DblClick(Sender: TObject);
    procedure GoToAccountDetails(Sender: TObject);
    procedure GoToUserDetails(Sender: TObject);
    procedure GoToContactDetails(Sender: TObject);
  private
    var
      guest: Boolean;
    { Private declarations }
  public
    var
      username: String;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.frmLoginbtnLoginClick(Sender: TObject);
{ Checks if user given credentials are valid }
begin
  guest := False;
  if frmLogin.User_Login(guest) then
  begin
    username := frmLogin.fldUsername.Text;
    frmLogin.Hide;
    frmSearch.Show;
    NavBar.Show;
    lblLoggedInAs.Caption := username;
  end
  else
    ShowMessage
      ('Login Error: Invalid Credentials or the user has been disabled');
end;

procedure TfrmMain.frmLoginbtnLoginGuestClick(Sender: TObject);
{ Checks if Guest credentials are valid
  - they always should be unless changed by a db admin
  - or if there is a problem accessing the db }
begin
  guest := True;
  if frmLogin.User_Login(guest) then
  begin
    username := 'Guest';
    frmLogin.Hide;
    frmSearch.Show;
    NavBar.Show;
    lblLoggedInAs.Caption := username;
  end
  else
    ShowMessage
      ('Login Error: Database problem or this user has been disabled. Contact database admin for details.');
end;

procedure TfrmMain.frmLoginbtnLoginKeyPress(Sender: TObject; var Key: Char);
{ Lets user press the enter key after typing their password rather than having to click the login button }
begin
  if ord(Key) = VK_RETURN then
  begin
    { Key := #0; prevents beeping }
    Key := #0;
    frmLoginbtnLoginClick(Sender)
  end;
end;


procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
{ Calls function to change user logged_in db status }
begin
  if DataModule1.isDBConnected() then
  begin
    DataModule1.Update_DB_Logged_in_Status_False(UserID);
  end
end;

procedure TfrmMain.NavBarItems0Click(Sender: TObject);
{ Shows Account Details Frame }
begin
  frmSearch.Hide;
  frmContact.Hide;
  frmUser.Hide;
  frmAccount.Show;
end;

procedure TfrmMain.NavBarItems1Click(Sender: TObject);
{ Shows Contact Details Frame }
begin
  frmAccount.Hide;
  frmSearch.Hide;
  frmUser.Hide;
  frmContact.Show;
end;

procedure TfrmMain.NavBarItems2Click(Sender: TObject);
{ Shows User Details Frame }
begin
  frmAccount.Hide;
  frmContact.Hide;
  frmSearch.Hide;
  frmUser.Show;
end;

procedure TfrmMain.NavBarItems3Click(Sender: TObject);
{ Shows Search Frame }
begin
  frmAccount.Hide;
  frmContact.Hide;
  frmUser.Hide;
  frmSearch.Show;
end;


procedure TfrmMain.frmSearchDBGrid1DblClick(Sender: TObject);
{Navigates the user to the selected record's details screen}
begin
  {Checks if selected row from search grid is an Account, Contact or User
  by counting the number of columns retrurned in the grid as each has a
  unique number}
  // This is bad, need to find a better way as column count may not stay unique
  case frmSearch.DBGrid1.Columns.Count of
    9: GoToAccountDetails(Sender);
    11: GoToUserDetails(Sender);
    12: GoToContactDetails(Sender);
  end;
end;


procedure TfrmMain.GoToAccountDetails(Sender: TObject);
{Uses case result from frmSearchDBGrid1DblClick
to take the user to the account's details screen}
begin
  {Finds the id of the record in the selected row of the grid
  and assigns it to the selectedID variable}
  frmSearch.DBGrid1DblClick(Sender);
  {Show / Hide correct frames}
  NavBarItems0Click(Sender);
  {Uses selected ID from the search grid and triggers the find procedure}
  frmAccount.fldAccountFind.Text := IntToStr(frmSearch.selectedID);
  frmAccount.btnAccountFindClick(Sender);
end;


procedure TfrmMain.GoToUserDetails(Sender: TObject);
{Uses case result from frmSearchDBGrid1DblClick
to take the user to the user's details screen}
begin
  {Finds the id of the record in the selected row of the grid
  and assigns it to the selectedID variable}
  frmSearch.DBGrid1DblClick(Sender);
  {Show / Hide correct frames}
  NavBarItems2Click(Sender);
  {Uses selected ID from the search grid and triggers the find procedure}
  frmUser.fldUserFind.Text := IntToStr(frmSearch.selectedID);
  frmUser.btnUserFindClick(Sender);
end;


procedure TfrmMain.GoToContactDetails(Sender: TObject);
{Uses case result from frmSearchDBGrid1DblClick
to take the user to the contact's details screen}
begin
  {Finds the id of the record in the selected row of the grid
  and assigns it to the selectedID variable}
  frmSearch.DBGrid1DblClick(Sender);
  {Show / Hide correct frames}
  NavBarItems1Click(Sender);
  {Uses selected ID from the search grid and triggers the find procedure}
  frmContact.fldContactFind.Text := IntToStr(frmSearch.selectedID);
  frmContact.btnContactFindClick(Sender);
end;

end.
