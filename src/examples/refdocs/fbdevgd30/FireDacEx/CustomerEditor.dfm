object EditCustomerForm: TEditCustomerForm
  Left = 0
  Top = 0
  Caption = 'EditCustomerForm'
  ClientHeight = 301
  ClientWidth = 373
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
    Top = 61
    Width = 39
    Height = 13
    Caption = 'Address'
  end
  object Label2: TLabel
    Left = 194
    Top = 183
    Width = 30
    Height = 13
    Caption = 'Phone'
  end
  object Label3: TLabel
    Left = 16
    Top = 183
    Width = 40
    Height = 13
    Caption = 'Zip code'
  end
  object Label4: TLabel
    Left = 16
    Top = 15
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Panel1: TPanel
    Left = 0
    Top = 260
    Width = 373
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
    Left = 194
    Top = 200
    Width = 161
    Height = 21
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 16
    Top = 200
    Width = 161
    Height = 21
    TabOrder = 2
  end
  object DBMemo1: TDBMemo
    Left = 16
    Top = 80
    Width = 339
    Height = 89
    TabOrder = 3
  end
  object DBEdit3: TDBEdit
    Left = 16
    Top = 34
    Width = 339
    Height = 21
    TabOrder = 4
  end
end
