object GoodsForm: TGoodsForm
  Left = 0
  Top = 0
  Caption = 'Goods'
  ClientHeight = 388
  ClientWidth = 560
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
  object Splitter1: TSplitter
    Left = 0
    Top = 35
    Width = 560
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 273
    ExplicitWidth = 115
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 560
    Height = 35
    ButtonHeight = 31
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Images = dmMain.ImageList
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actAddRecord
    end
    object ToolButton2: TToolButton
      Left = 31
      Top = 0
      Action = actEditRecord
    end
    object ToolButton3: TToolButton
      Left = 62
      Top = 0
      Action = actDeleteRecord
    end
    object ToolButton4: TToolButton
      Left = 93
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 101
      Top = 0
      Action = actRefresh
    end
    object ToolButton6: TToolButton
      Left = 132
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 140
      Top = 0
      Action = actExit
    end
  end
  object mmDescription: TDBMemo
    Left = 0
    Top = 282
    Width = 560
    Height = 106
    Align = alClient
    DataField = 'DESCRIPTION'
    DataSource = dmGoods.DataSource
    ReadOnly = True
    TabOrder = 1
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 38
    Width = 560
    Height = 244
    Align = alTop
    DataSource = dmGoods.DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGridDblClick
    OnKeyDown = DBGridKeyDown
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 440
    Top = 104
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
