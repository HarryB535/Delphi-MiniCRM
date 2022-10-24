unit Confirm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmConfirm = class(TFrame)
    lblConfirmTextCustom: TLabel;
    btnConfirmTrue: TButton;
    btnConfirmFalse: TButton;
    lblConfirmText: TLabel;
    pnlWarning: TPanel;
    function Prompt(Sender: TObject):Boolean;
    procedure btnConfirmTrueClick(Sender: TObject);
    procedure btnConfirmFalseClick(Sender: TObject);
  public
    var
      choiceMade:Integer;
end;

implementation

{$R *.dfm}


function TfrmConfirm.Prompt(Sender: TObject):Boolean;
begin
  choiceMade := 0;
  self.Hide;
  if choiceMade = 1 then
    result := True;
  if choiceMade = 0 then
    result := False;
end;



procedure TfrmConfirm.btnConfirmFalseClick(Sender: TObject);
begin
  choiceMade := 0;
end;


procedure TfrmConfirm.btnConfirmTrueClick(Sender: TObject);
begin
  choiceMade := 1;
end;


end.
