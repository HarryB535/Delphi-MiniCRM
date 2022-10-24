object frmUser: TfrmUser
  Left = 0
  Top = 0
  Width = 929
  Height = 371
  TabOrder = 0
  object lblUserID: TLabel
    Left = 36
    Top = 67
    Width = 36
    Height = 13
    Caption = 'User ID'
  end
  object lblUserName: TLabel
    Left = 36
    Top = 94
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object lblUserFirstName: TLabel
    Left = 36
    Top = 121
    Width = 51
    Height = 13
    Caption = 'First Name'
  end
  object lblUserLastName: TLabel
    Left = 37
    Top = 148
    Width = 50
    Height = 13
    Caption = 'Last Name'
  end
  object lblUserCreatedDate: TLabel
    Left = 37
    Top = 202
    Width = 65
    Height = 13
    Caption = 'Created Date'
  end
  object lblUserPassword: TLabel
    Left = 37
    Top = 175
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object lblUserActive: TLabel
    Left = 331
    Top = 121
    Width = 64
    Height = 13
    Caption = 'Active Status'
  end
  object lblUserLastLogin: TLabel
    Left = 331
    Top = 94
    Width = 74
    Height = 13
    Caption = 'Last Login Date'
  end
  object lblUserText: TLabel
    Left = 780
    Top = 0
    Width = 141
    Height = 33
    Alignment = taRightJustify
    Caption = 'User Details'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblUserAdmin: TLabel
    Left = 331
    Top = 175
    Width = 63
    Height = 13
    Caption = 'Admin Status'
  end
  object lblUserPasswordDate: TLabel
    Left = 331
    Top = 202
    Width = 118
    Height = 13
    Caption = 'Password Changed Date'
  end
  object lblUserLoggedIn: TLabel
    Left = 331
    Top = 148
    Width = 82
    Height = 13
    Caption = 'Logged In Status'
  end
  object fldUserID: TEdit
    Left = 120
    Top = 64
    Width = 49
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object fldUserName: TEdit
    Left = 120
    Top = 91
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object fldUserCreatedDate: TEdit
    Left = 120
    Top = 199
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object fldUserPassword: TEdit
    Left = 120
    Top = 172
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object fldUserActive: TEdit
    Left = 457
    Top = 118
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object fldUserLastLogin: TEdit
    Left = 457
    Top = 91
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 5
  end
  object fldUserFirstName: TEdit
    Left = 120
    Top = 118
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object fldUserLastName: TEdit
    Left = 120
    Top = 145
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object fldUserFind: TEdit
    Left = 36
    Top = 24
    Width = 101
    Height = 21
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    TextHint = 'Enter Account ID...'
  end
  object btnUserFind: TButton
    Left = 143
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Find'
    TabOrder = 9
    OnClick = btnUserFindClick
  end
  object btnEditUser: TButton
    Left = 305
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Edit'
    Enabled = False
    TabOrder = 10
    OnClick = btnEditUserClick
  end
  object btnEditUserSave: TButton
    Left = 386
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Save'
    Enabled = False
    TabOrder = 11
    Visible = False
    OnClick = btnEditUserSaveClick
  end
  object btnEditUserCancel: TButton
    Left = 467
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Enabled = False
    TabOrder = 12
    Visible = False
    OnClick = btnEditUserCancelClick
  end
  object btnUserCreate: TButton
    Left = 224
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 13
    OnClick = btnUserCreateClick
  end
  object btnUserDelete: TButton
    Left = 548
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Delete'
    Enabled = False
    TabOrder = 14
    OnClick = btnUserDeleteClick
  end
  object fldUserAdmin: TEdit
    Left = 457
    Top = 172
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 15
  end
  object fldUserPasswordDate: TEdit
    Left = 457
    Top = 199
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 16
  end
  object fldUserLoggedIn: TEdit
    Left = 457
    Top = 145
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 17
  end
  object FDTable4: TFDTable
    ConnectionName = 'MainConnection'
    Left = 768
    Top = 8
  end
  object DataSource4: TDataSource
    DataSet = FDTable4
    Left = 696
    Top = 8
  end
end
