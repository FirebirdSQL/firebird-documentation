object EditInvoiceLineForm: TEditInvoiceLineForm
  Left = 0
  Top = 0
  Caption = 'EditInvoiceLineForm'
  ClientHeight = 194
  ClientWidth = 375
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
    375
    194)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 13
    Width = 30
    Height = 13
    Caption = 'Goods'
  end
  object Label2: TLabel
    Left = 16
    Top = 59
    Width = 22
    Height = 13
    Caption = 'Cost'
  end
  object Label3: TLabel
    Left = 199
    Top = 59
    Width = 42
    Height = 13
    Caption = 'Quantity'
  end
  object Panel1: TPanel
    Left = 0
    Top = 153
    Width = 375
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
  object edtProduct: TButtonedEdit
    Left = 16
    Top = 32
    Width = 339
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Images = InvoiceForm.ImageList1
    ReadOnly = True
    RightButton.ImageIndex = 0
    RightButton.Visible = True
    TabOrder = 1
    OnRightButtonClick = edtProductRightButtonClick
  end
  object edtPrice: TEdit
    Left = 16
    Top = 78
    Width = 153
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object edtQuantity: TEdit
    Left = 199
    Top = 78
    Width = 156
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    OnChange = edtQuantityChange
  end
end
