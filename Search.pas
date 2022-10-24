unit Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Web.HTTPApp, Web.DBWeb, Datasnap.Provider, Vcl.Grids,
  Vcl.DBGrids, Vcl.Menus, Vcl.DBCGrids,
  Account;

type
  TfrmSearch = class(TFrame)
    btnSearch: TButton;
    FDTable1: TFDTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    fldSearch: TComboBox;
    lblSearchText: TLabel;
    procedure View_All_From_Table(Sender: TObject; var table: String);
    procedure btnSearchClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    function DBGridResult():Integer;
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    selectedID: Integer;
    { Public declarations }
  end;

implementation

{$R *.dfm}

var
  table: String;

procedure TfrmSearch.btnSearchClick(Sender: TObject);
{returns all records from Accounts, Contacts or Users depending on fldSearch.Text}
begin
  try
    begin
      if FDTable1.Active then
      {Closes any previously opened search}
      begin
        FDTable1.Close;
      end;
      table := fldSearch.Text;
      View_All_From_Table(Sender, table);
      FormActivate(Sender);
    end;
  except
    on E: Exception do
      ShowMessage('btnSearchClick: ' + E.Message);
  end;
end;

procedure TfrmSearch.View_All_From_Table(Sender: TObject; var table: String);
{ returns all using given table from db }
begin
  try
  begin
    FDTable1.TableName := table;
    FDTable1.IndexFieldNames := 'ID';
    FDTable1.Open;
  end;
  except
    on E: Exception do
      ShowMessage('View_All_From_Table: ' + E.Message);
  end;
end;

function TfrmSearch.DBGridResult():Integer;
{returns id for selected record in search grid results}
var
  id: Integer;
begin
  try
  begin
    id := DBGrid1.SelectedField.AsInteger;
    result := id;
  end;
  except
    on E: Exception do
      ShowMessage('No record selected')
  end;

end;

procedure TfrmSearch.DBGrid1DblClick(Sender: TObject);
{double click on selected search grid record sets public variable to record's id}
begin
  selectedID := DBGridResult();
end;

procedure TfrmSearch.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
{attempts to resize the search grid to fit all columns}
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  w: Integer;

begin
  w := 15 + DBGrid1.Canvas.TextExtent(Column.Field.DisplayText).cx;
  if w > Column.Width then
    Column.Width := w;
end;

procedure TfrmSearch.FormActivate(Sender: TObject);
Var
  i: Integer;

begin
  // Initialize width
  for i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns[i].Width := 15 + DBGrid1.Canvas.TextWidth(DBGrid1.Columns[i].title.caption);
end;

end.
