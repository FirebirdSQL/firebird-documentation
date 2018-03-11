object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Example'
  ClientHeight = 641
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mdiChildrenTabs: TTabSet
    Left = 0
    Top = 0
    Width = 984
    Height = 21
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    SoftTop = True
    Style = tsSoftTabs
    TabPosition = tpTop
    OnChange = mdiChildrenTabsChange
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 622
    Width = 984
    Height = 19
    Panels = <
      item
        Width = 300
      end>
  end
  object MainMenu: TMainMenu
    Left = 536
    Top = 288
    object miCatalogs: TMenuItem
      Caption = 'Catalogs'
      object miCustomers: TMenuItem
        Caption = 'Customers'
        OnClick = miCustomersClick
      end
      object miGoods: TMenuItem
        Caption = 'Goods'
        OnClick = miGoodsClick
      end
    end
    object miRegisters: TMenuItem
      Caption = 'Registers'
      object miInvoice: TMenuItem
        Caption = 'Invoices'
        OnClick = miInvoiceClick
      end
    end
    object miSettings: TMenuItem
      Caption = 'Settings'
      object miDateRange: TMenuItem
        Caption = 'Operating range of dates'
        OnClick = miDateRangeClick
      end
    end
  end
end
