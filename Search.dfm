object frmSearch: TfrmSearch
  Left = 0
  Top = 0
  Width = 929
  Height = 345
  TabOrder = 0
  object lblSearchText: TLabel
    Left = 840
    Top = 0
    Width = 80
    Height = 33
    Alignment = taRightJustify
    Caption = 'Search'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnSearch: TButton
    Left = 154
    Top = 3
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 0
    OnClick = btnSearchClick
  end
  object DBGrid1: TDBGrid
    Left = 3
    Top = 30
    Width = 923
    Height = 311
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object fldSearch: TComboBox
    Left = 3
    Top = 5
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'Accounts'
    Items.Strings = (
      'Accounts'
      'Contacts'
      'Users')
  end
  object FDTable1: TFDTable
    ConnectionName = 'MainConnection'
    Left = 304
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 240
  end
end
