object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Width = 243
  Height = 165
  TabOrder = 0
  object lblLoginText: TLabel
    Left = 80
    Top = 25
    Width = 110
    Height = 33
    Caption = 'Mini CRM'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblUsername: TLabel
    Left = 6
    Top = 70
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object lblPassword: TLabel
    Left = 6
    Top = 97
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object fldUsername: TEdit
    Left = 60
    Top = 67
    Width = 156
    Height = 21
    TabOrder = 0
    TextHint = 'Enter Username'
  end
  object fldPassword: TEdit
    Left = 60
    Top = 94
    Width = 156
    Height = 21
    TabOrder = 1
    TextHint = 'Enter Password'
  end
  object btnLogin: TButton
    Left = 60
    Top = 124
    Width = 75
    Height = 35
    Caption = 'Login'
    TabOrder = 2
  end
  object btnLoginGuest: TButton
    Left = 140
    Top = 124
    Width = 75
    Height = 35
    Caption = 'Guest Account'
    TabOrder = 3
    WordWrap = True
  end
end
