object DateRangeForm: TDateRangeForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Operating range of dates'
  ClientHeight = 203
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    335
    203)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 13
    Width = 49
    Height = 13
    Caption = 'Start date'
  end
  object Label2: TLabel
    Left = 24
    Top = 67
    Width = 52
    Height = 13
    Caption = 'Finish date'
  end
  object edtDateBegin: TDateTimePicker
    Left = 24
    Top = 32
    Width = 285
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Date = 42295.529419548610000000
    Time = 42295.529419548610000000
    TabOrder = 0
  end
  object edtDateEnd: TDateTimePicker
    Left = 24
    Top = 86
    Width = 285
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Date = 42295.529530011580000000
    Time = 42295.529530011580000000
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 162
    Width = 335
    Height = 41
    Align = alBottom
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 112
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 224
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
