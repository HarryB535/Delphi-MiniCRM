object frmContact: TfrmContact
  Left = 0
  Top = 0
  Width = 929
  Height = 371
  TabOrder = 0
  object lblContactID: TLabel
    Left = 36
    Top = 67
    Width = 52
    Height = 13
    Caption = 'Contact ID'
  end
  object lblContactFullName: TLabel
    Left = 36
    Top = 94
    Width = 46
    Height = 13
    Caption = 'Full Name'
  end
  object lblContactNamePrefix: TLabel
    Left = 36
    Top = 121
    Width = 28
    Height = 13
    Caption = 'Prefix'
  end
  object lblContactFirstName: TLabel
    Left = 37
    Top = 148
    Width = 51
    Height = 13
    Caption = 'First Name'
  end
  object lblContactCreatedBy: TLabel
    Left = 37
    Top = 202
    Width = 54
    Height = 13
    Caption = 'Created by'
  end
  object lblContactLastName: TLabel
    Left = 37
    Top = 175
    Width = 50
    Height = 13
    Caption = 'Last Name'
  end
  object lblContactModifiedDate: TLabel
    Left = 316
    Top = 229
    Width = 66
    Height = 13
    Caption = 'Modified Date'
  end
  object lblContactPhone: TLabel
    Left = 316
    Top = 94
    Width = 50
    Height = 13
    Caption = 'Phone No.'
  end
  object lblContactEmail: TLabel
    Left = 317
    Top = 121
    Width = 24
    Height = 13
    Caption = 'Email'
  end
  object lblContactModifiedBy: TLabel
    Left = 317
    Top = 202
    Width = 55
    Height = 13
    Caption = 'Modified by'
  end
  object lblContactAccount: TLabel
    Left = 317
    Top = 148
    Width = 39
    Height = 13
    Caption = 'Account'
  end
  object lblContactCreatedDate: TLabel
    Left = 37
    Top = 229
    Width = 65
    Height = 13
    Caption = 'Created Date'
  end
  object lblContactText: TLabel
    Left = 744
    Top = 0
    Width = 177
    Height = 33
    Alignment = taRightJustify
    Caption = 'Contact Details'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object fldContactID: TEdit
    Left = 120
    Top = 64
    Width = 49
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object fldContactFullName: TEdit
    Left = 120
    Top = 91
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object fldContactCreatedBy: TEdit
    Left = 120
    Top = 199
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object fldContactLastName: TEdit
    Left = 120
    Top = 172
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object fldContactNamePrefix: TEdit
    Left = 120
    Top = 118
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object fldContactFirstName: TEdit
    Left = 120
    Top = 145
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 5
  end
  object fldContactFind: TEdit
    Left = 36
    Top = 24
    Width = 101
    Height = 21
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    TextHint = 'Enter Contact ID...'
  end
  object btnContactFind: TButton
    Left = 143
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Find'
    TabOrder = 7
    OnClick = btnContactFindClick
  end
  object btnEditContact: TButton
    Left = 224
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Edit'
    Enabled = False
    TabOrder = 8
    OnClick = btnEditContactClick
  end
  object btnEditContactSave: TButton
    Left = 305
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Save'
    Enabled = False
    TabOrder = 9
    Visible = False
    OnClick = btnEditContactSaveClick
  end
  object btnEditContactCancel: TButton
    Left = 386
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Enabled = False
    TabOrder = 10
    Visible = False
    OnClick = btnEditContactCancelClick
  end
  object fldContactModifiedDate: TEdit
    Left = 400
    Top = 226
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 11
  end
  object fldContactPhone: TEdit
    Left = 400
    Top = 91
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 12
  end
  object fldContactModifiedBy: TEdit
    Left = 400
    Top = 199
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 13
  end
  object fldContactAccount: TEdit
    Left = 400
    Top = 145
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 14
  end
  object fldContactEmail: TEdit
    Left = 400
    Top = 118
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 15
  end
  object fldContactCreatedDate: TEdit
    Left = 120
    Top = 226
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 16
  end
  object FDTable3: TFDTable
    ConnectionName = 'MainConnection'
    Left = 768
    Top = 8
  end
  object DataSource3: TDataSource
    DataSet = FDTable3
    Left = 696
    Top = 8
  end
end
