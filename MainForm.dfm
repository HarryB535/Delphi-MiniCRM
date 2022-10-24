object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Mini CRM'
  ClientHeight = 406
  ClientWidth = 930
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblLoggedInAs: TLabel
    Left = 918
    Top = 389
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  inline frmLogin: TfrmLogin
    Left = 355
    Top = 112
    Width = 243
    Height = 247
    TabOrder = 0
    ExplicitLeft = 355
    ExplicitTop = 112
    inherited fldPassword: TEdit
      OnKeyPress = frmLoginbtnLoginKeyPress
    end
    inherited btnLogin: TButton
      OnClick = frmLoginbtnLoginClick
    end
    inherited btnLoginGuest: TButton
      OnClick = frmLoginbtnLoginGuestClick
    end
  end
  object ButtonGroup1: TButtonGroup
    Left = 0
    Top = 0
    Width = 930
    Height = 39
    Align = alTop
    BevelEdges = [beLeft, beTop, beRight]
    BevelOuter = bvRaised
    BevelWidth = 3
    BorderWidth = 5
    ButtonHeight = 25
    ButtonWidth = 70
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Items = <
      item
        Caption = 'Account'
        OnClick = ButtonGroup1Items0Click
      end
      item
        Caption = 'Contact'
        OnClick = ButtonGroup1Items1Click
      end
      item
        Caption = 'User'
        OnClick = ButtonGroup1Items2Click
      end
      item
        Caption = 'Search'
        OnClick = ButtonGroup1Items3Click
      end>
    ParentDoubleBuffered = False
    TabOrder = 2
    Visible = False
  end
  inline frmContact: TfrmContact
    Left = 3
    Top = 40
    Width = 929
    Height = 371
    TabOrder = 4
    Visible = False
    ExplicitLeft = 3
    ExplicitTop = 40
  end
  inline frmUser: TfrmUser
    Left = 3
    Top = 40
    Width = 929
    Height = 371
    TabOrder = 5
    Visible = False
    ExplicitLeft = 3
    ExplicitTop = 40
  end
  inline frmSearch: TfrmSearch
    Left = 3
    Top = 40
    Width = 929
    Height = 345
    TabOrder = 1
    Visible = False
    ExplicitLeft = 3
    ExplicitTop = 40
    inherited DBGrid1: TDBGrid
      Top = 32
      OnDblClick = frmSearchDBGrid1DblClick
    end
    inherited FDTable1: TFDTable
      Constraints = <
        item
          FromDictionary = False
        end>
    end
  end
  inline frmAccount: TfrmAccount
    Left = 3
    Top = 40
    Width = 929
    Height = 374
    TabOrder = 3
    Visible = False
    ExplicitLeft = 3
    ExplicitTop = 40
    ExplicitHeight = 374
  end
end
