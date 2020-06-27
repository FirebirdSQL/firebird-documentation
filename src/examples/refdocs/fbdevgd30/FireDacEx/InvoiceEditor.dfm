object EditInvoiceForm: TEditInvoiceForm
  Left = 0
  Top = 0
  Caption = 'EditInvoiceForm'
  ClientHeight = 196
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    368
    196)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 13
    Width = 23
    Height = 13
    Caption = 'Date'
  end
  object Label2: TLabel
    Left = 201
    Top = 13
    Width = 22
    Height = 13
    Caption = 'Time'
  end
  object Label3: TLabel
    Left = 17
    Top = 61
    Width = 46
    Height = 13
    Caption = 'Customer'
  end
  object edtInvoiceDate: TDateTimePicker
    Left = 17
    Top = 32
    Width = 161
    Height = 21
    Date = 42290.871181435180000000
    Time = 42290.871181435180000000
    TabOrder = 0
    OnChange = edtInvoiceDateChange
  end
  object edtCustomer: TButtonedEdit
    Left = 17
    Top = 80
    Width = 338
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Images = InvoiceForm.ImageList1
    ReadOnly = True
    RightButton.ImageIndex = 0
    RightButton.Visible = True
    TabOrder = 1
    OnRightButtonClick = edtCustomerRightButtonClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 155
    Width = 368
    Height = 41
    Align = alBottom
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
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
  object edtInvoiceTime: TDateTimePicker
    Left = 201
    Top = 32
    Width = 154
    Height = 21
    Date = 42290.955632002310000000
    Time = 42290.955632002310000000
    Kind = dtkTime
    TabOrder = 3
    OnChange = edtInvoiceTimeChange
  end
end
