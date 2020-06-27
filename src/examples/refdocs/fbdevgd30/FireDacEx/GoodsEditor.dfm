object EditGoodsForm: TEditGoodsForm
  Left = 0
  Top = 0
  Caption = 'EditGoodsForm'
  ClientHeight = 334
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 13
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 16
    Top = 61
    Width = 22
    Height = 13
    Caption = 'Cost'
  end
  object Label3: TLabel
    Left = 16
    Top = 109
    Width = 50
    Height = 13
    Caption = 'Comments'
  end
  object Panel1: TPanel
    Left = 0
    Top = 293
    Width = 376
    Height = 41
    Align = alBottom
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 184
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 280
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 32
    Width = 339
    Height = 21
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 16
    Top = 80
    Width = 339
    Height = 21
    TabOrder = 2
  end
  object DBMemo1: TDBMemo
    Left = 16
    Top = 128
    Width = 339
    Height = 129
    TabOrder = 3
  end
end
