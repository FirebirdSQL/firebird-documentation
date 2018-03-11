object CustomerForm: TCustomerForm
  Left = 0
  Top = 0
  Caption = 'Customers'
  ClientHeight = 359
  ClientWidth = 648
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid: TDBGrid
    Left = 0
    Top = 35
    Width = 648
    Height = 324
    Align = alClient
    DataSource = dmCustomers.DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGridDblClick
    OnKeyDown = DBGridKeyDown
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 648
    Height = 35
    ButtonHeight = 31
    ButtonWidth = 31
    Caption = 'ToolBar'
    Images = dmMain.ImageList
    TabOrder = 1
    object btnAddRecord: TToolButton
      Left = 0
      Top = 0
      Action = actAddRecord
    end
    object btnEditRecord: TToolButton
      Left = 31
      Top = 0
      Action = actEditRecord
    end
    object btnDeleteRecord: TToolButton
      Left = 62
      Top = 0
      Action = actDeleteRecord
    end
    object ToolButton1: TToolButton
      Left = 93
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 101
      Top = 0
      Action = actRefresh
    end
    object ToolButton4: TToolButton
      Left = 132
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 140
      Top = 0
      Action = actExit
    end
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 376
    Top = 184
    object actAddRecord: TAction
      Caption = 'Add'
      Hint = 'Add'
      ImageIndex = 0
      OnExecute = actAddRecordExecute
    end
    object actEditRecord: TAction
      Caption = 'Edit'
      Hint = 'Edit'
      ImageIndex = 1
      OnExecute = actEditRecordExecute
    end
    object actDeleteRecord: TAction
      Caption = 'Delete'
      Hint = 'Delete'
      ImageIndex = 2
      OnExecute = actDeleteRecordExecute
    end
    object actRefresh: TAction
      Caption = 'Refresh'
      Hint = 'Refresh'
      ImageIndex = 3
      OnExecute = actRefreshExecute
    end
    object actExit: TAction
      Caption = 'Close'
      Hint = 'Close'
      ImageIndex = 4
      OnExecute = actExitExecute
    end
  end
end
