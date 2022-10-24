object frmConfirm: TfrmConfirm
  Left = 0
  Top = 0
  Width = 332
  Height = 138
  Color = clSilver
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object lblConfirmTextCustom: TLabel
    Left = 38
    Top = 58
    Width = 256
    Height = 23
    Caption = 'This action cannot be undone.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblConfirmText: TLabel
    Left = 4
    Top = 27
    Width = 325
    Height = 25
    Caption = 'Are you sure you wish to proceed?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnConfirmTrue: TButton
    Left = 70
    Top = 102
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = btnConfirmTrueClick
  end
  object btnConfirmFalse: TButton
    Left = 183
    Top = 102
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnConfirmFalseClick
  end
  object pnlWarning: TPanel
    Left = 0
    Top = 0
    Width = 332
    Height = 21
    Caption = 'WARNING'
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -16
    Font.Name = 'System'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
end
