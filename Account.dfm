object frmAccount: TfrmAccount
  Left = 0
  Top = 0
  Width = 929
  Height = 371
  TabOrder = 0
  object lblAccountID: TLabel
    Left = 36
    Top = 67
    Width = 53
    Height = 13
    Caption = 'Account ID'
  end
  object lblAccountName: TLabel
    Left = 36
    Top = 94
    Width = 69
    Height = 13
    Caption = 'Account Name'
  end
  object lblAccountPhone: TLabel
    Left = 36
    Top = 121
    Width = 50
    Height = 13
    Caption = 'Phone No.'
  end
  object lblAccountPContact: TLabel
    Left = 37
    Top = 148
    Width = 77
    Height = 13
    Caption = 'Primary Contact'
  end
  object lblAccountAddress: TLabel
    Left = 331
    Top = 67
    Width = 39
    Height = 13
    Caption = 'Address'
  end
  object lblAccountCreatedBy: TLabel
    Left = 37
    Top = 202
    Width = 54
    Height = 13
    Caption = 'Created by'
  end
  object lblAccountCreatedDate: TLabel
    Left = 37
    Top = 175
    Width = 64
    Height = 13
    Caption = 'Created date'
  end
  object lblAccountModifiedBy: TLabel
    Left = 331
    Top = 202
    Width = 55
    Height = 13
    Caption = 'Modified by'
  end
  object lblAccountModifiedDate: TLabel
    Left = 331
    Top = 175
    Width = 65
    Height = 13
    Caption = 'Modified date'
  end
  object lblAccountText: TLabel
    Left = 740
    Top = 0
    Width = 181
    Height = 33
    Alignment = taRightJustify
    Caption = 'Account Details'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object fldAccountID: TEdit
    Left = 120
    Top = 64
    Width = 49
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object fldAccountName: TEdit
    Left = 120
    Top = 91
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object fldAccountCreatedBy: TEdit
    Left = 120
    Top = 199
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object fldAccountCreatedDate: TEdit
    Left = 120
    Top = 172
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object fldAccountModifiedBy: TEdit
    Left = 416
    Top = 199
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object fldAccountModifiedDate: TEdit
    Left = 416
    Top = 172
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 5
  end
  object fldAccountPhone: TEdit
    Left = 120
    Top = 118
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object fldAccountPContact: TEdit
    Left = 120
    Top = 145
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object fldAccountAddress: TMemo
    Left = 416
    Top = 64
    Width = 185
    Height = 89
    ReadOnly = True
    TabOrder = 8
  end
  object fldAccountFind: TEdit
    Left = 36
    Top = 24
    Width = 101
    Height = 21
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    TextHint = 'Enter Account ID...'
  end
  object btnAccountFind: TButton
    Left = 143
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Find'
    TabOrder = 10
    OnClick = btnAccountFindClick
  end
  object btnEditAccount: TButton
    Left = 305
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Edit'
    Enabled = False
    TabOrder = 11
    OnClick = btnEditAccountClick
  end
  object btnEditAccountSave: TButton
    Left = 386
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Save'
    Enabled = False
    TabOrder = 12
    Visible = False
    OnClick = btnEditAccountSaveClick
  end
  object btnEditAccountCancel: TButton
    Left = 467
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Enabled = False
    TabOrder = 13
    Visible = False
    OnClick = btnEditAccountCancelClick
  end
  object btnAccountCreate: TButton
    Left = 224
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 14
    OnClick = btnAccountCreateClick
  end
  object btnAccountDelete: TButton
    Left = 548
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Delete'
    Enabled = False
    TabOrder = 15
    OnClick = btnAccountDeleteClick
  end
  object FDTable2: TFDTable
    ConnectionName = 'MainConnection'
    Left = 768
    Top = 8
  end
  object DataSource2: TDataSource
    DataSet = FDTable2
    Left = 696
    Top = 8
  end
end
