unit Contact;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  DataModule;

type
  TfrmContact = class(TFrame)
    lblContactID: TLabel;
    lblContactFullName: TLabel;
    lblContactNamePrefix: TLabel;
    lblContactFirstName: TLabel;
    lblContactLastName: TLabel;
    lblContactCreatedBy: TLabel;
    lblContactCreatedDate: TLabel;
    lblContactModifiedBy: TLabel;
    lblContactModifiedDate: TLabel;
    lblContactPhone: TLabel;
    lblContactEmail: TLabel;
    lblContactAccount: TLabel;
    fldContactID: TEdit;
    fldContactFullName: TEdit;
    fldContactNamePrefix: TEdit;
    fldContactFirstName: TEdit;
    fldContactLastName: TEdit;
    fldContactCreatedBy: TEdit;
    fldContactCreatedDate: TEdit;
    fldContactModifiedBy: TEdit;
    fldContactModifiedDate: TEdit;
    fldContactPhone: TEdit;
    fldContactEmail: TEdit;
    fldContactAccount: TEdit;
    fldContactFind: TEdit;
    btnContactFind: TButton;
    btnEditContact: TButton;
    btnEditContactSave: TButton;
    btnEditContactCancel: TButton;
    FDTable3: TFDTable;
    DataSource3: TDataSource;
    lblContactText: TLabel;
    procedure btnContactFindClick(Sender: TObject);
    procedure btnEditContactCancelClick(Sender: TObject);
    procedure btnEditContactClick(Sender: TObject);
    procedure btnEditContactSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  contactData: TArray<String>;

implementation

{$R *.dfm}

procedure TfrmContact.btnContactFindClick(Sender: TObject);
{ Manages Contact "Find" process }
var
  id: Integer;
begin
  try
    begin
      id := StrToInt(fldContactFind.Text);
      { DB Query }
      contactData := DataModule1.Find_Contact_ID(id);
      { AutoFill fields using DB Query results }
      fldContactID.Text := contactData[0];
      fldContactFullName.Text := contactData[1];
      fldContactNamePrefix.Text := contactData[2];
      fldContactFirstName.Text := contactData[3];
      fldContactLastName.Text := contactData[4];
      fldContactCreatedBy.Text := contactData[5];
      fldContactCreatedDate.Text := contactData[6];
      fldContactModifiedBy.Text := contactData[7];
      fldContactModifiedDate.Text := contactData[8];
      fldContactPhone.Text := contactData[9];
      fldContactEmail.Text := contactData[10];
      fldContactAccount.Text := contactData[11];
      if DataModule1.Is_Admin_User(UserID) then
        { if user has admin status, re-enable edit button }
        btnEditContact.Enabled := True;
    end;
  except
    on E: Exception do
      ShowMessage('btnContactFindClick: ' + E.Message);
  end;
end;

procedure TfrmContact.btnEditContactCancelClick(Sender: TObject);
begin
  { Enabled / Disabled }
  fldContactID.Enabled := True;
  fldContactCreatedBy.Enabled := True;
  fldContactCreatedDate.Enabled := True;
  fldContactModifiedBy.Enabled := True;
  fldContactModifiedDate.Enabled := True;
  btnContactFind.Enabled := True;
  btnEditContact.Enabled := True;
  btnEditContactSave.Enabled := False;
  btnEditContactCancel.Enabled := False;
  { ReadOnly }
  fldContactFind.ReadOnly := False;
  fldContactFullName.ReadOnly := True;
  fldContactNamePrefix.ReadOnly := True;
  fldContactFirstName.ReadOnly := True;
  fldContactLastName.ReadOnly := True;
  fldContactPhone.ReadOnly := True;
  fldContactEmail.ReadOnly := True;
  { Show / Hide }
  btnEditContactSave.Hide;
  btnEditContactCancel.Hide;
  btnContactFindClick(Sender);
end;

procedure TfrmContact.btnEditContactClick(Sender: TObject);
begin
  if Length(fldContactID.Text) > 0 then
  begin
    { Enabled / Disabled }
    fldContactID.Enabled := False;
    fldContactCreatedBy.Enabled := False;
    fldContactCreatedDate.Enabled := False;
    fldContactModifiedBy.Enabled := False;
    fldContactModifiedDate.Enabled := False;
    btnContactFind.Enabled := False;
    btnEditContact.Enabled := False;
    btnEditContactSave.Enabled := True;
    btnEditContactCancel.Enabled := True;
    { ReadOnly }
    fldContactFind.ReadOnly := True;
    fldContactFullName.ReadOnly := False;
    fldContactNamePrefix.ReadOnly := False;
    fldContactFirstName.ReadOnly := False;
    fldContactLastName.ReadOnly := False;
    fldContactPhone.ReadOnly := False;
    fldContactEmail.ReadOnly := False;
    { Show / Hide }
    btnEditContactSave.Show;
    btnEditContactCancel.Show;
  end
  else
    ShowMessage('No contact selected')

end;

procedure TfrmContact.btnEditContactSaveClick(Sender: TObject);
var
  Cid: String;
  Cfullname: String;
  Cnameprefix: String;
  Cfirstname: String;
  Clastname: String;
  Cphone: String;
  Cemail: String;
begin
  Cid := fldContactID.Text;
  Cfullname := fldContactFullName.Text;
  Cnameprefix := fldContactNamePrefix.Text;
  Cfirstname := fldContactFirstName.Text;
  Clastname := fldContactLastName.Text;
  Cphone := fldContactPhone.Text;
  Cemail := fldContactEmail.Text;
  if DataModule1.Update_DB_Contact_Details(Cid, Cfullname, Cnameprefix,
    Cfirstname, Clastname, Cphone, Cemail) then
    btnEditContactCancelClick(Sender)

end;

end.
