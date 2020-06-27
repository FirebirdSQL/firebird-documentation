object dmInvoice: TdmInvoice
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 441
  Width = 694
  object MasterSource: TDataSource
    DataSet = qryInvoice
    Left = 376
    Top = 64
  end
  object trWrite: TFDTransaction
    Options.Isolation = xiSnapshot
    Options.AutoStart = False
    Options.AutoStop = False
    Connection = dmMain.FDConnection
    Left = 280
    Top = 120
  end
  object qryInvoice: TFDQuery
    Connection = dmMain.FDConnection
    Transaction = trRead
    UpdateTransaction = trWrite
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'SELECT'
      '  invoice.invoice_id AS invoice_id,'
      '  invoice.customer_id AS customer_id,'
      '  customer.NAME AS customer_name,'
      '  invoice.invoice_date AS invoice_date,'
      '  invoice.total_sale AS total_sale,'
      '  IIF(invoice.paid=1, '#39'Yes'#39', '#39'No'#39') AS paid '
      'FROM'
      '  invoice'
      '  JOIN customer ON customer.customer_id = invoice.customer_id '
      'WHERE invoice.invoice_date BETWEEN :date_begin AND :date_end'
      'ORDER BY invoice.invoice_date DESC')
    Left = 376
    Top = 120
    ParamData = <
      item
        Name = 'DATE_BEGIN'
        DataType = ftTimeStamp
        Precision = 16
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATE_END'
        DataType = ftTimeStamp
        Precision = 16
        ParamType = ptInput
        Value = Null
      end>
    object qryInvoiceINVOICE_ID: TIntegerField
      DisplayLabel = 'Number'
      FieldName = 'INVOICE_ID'
      Origin = 'INVOICE_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryInvoiceCUSTOMER_ID: TIntegerField
      FieldName = 'CUSTOMER_ID'
      Origin = 'CUSTOMER_ID'
      Required = True
      Visible = False
    end
    object qryInvoiceCUSTOMER_NAME: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Customer'
      FieldName = 'CUSTOMER_NAME'
      Origin = 'NAME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryInvoiceINVOICE_DATE: TSQLTimeStampField
      DisplayLabel = 'Date'
      FieldName = 'INVOICE_DATE'
      Origin = 'INVOICE_DATE'
    end
    object qryInvoiceTOTAL_SALE: TBCDField
      DisplayLabel = 'Amount'
      FieldName = 'TOTAL_SALE'
      Origin = 'TOTAL_SALE'
      ReadOnly = True
      DisplayFormat = '0.00'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryInvoicePAID: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Paid'
      FieldName = 'PAID'
      Origin = 'PAID'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
  end
  object qryAddInvoice: TFDCommand
    Connection = dmMain.FDConnection
    Transaction = trWrite
    CommandText.Strings = (
      'EXECUTE PROCEDURE sp_add_invoice('
      '  NEXT VALUE FOR gen_invoice_id, '
      '  :CUSTOMER_ID, '
      '  :INVOICE_DATE'
      ')')
    ParamData = <
      item
        Name = 'CUSTOMER_ID'
        ParamType = ptInput
      end
      item
        Name = 'INVOICE_DATE'
        ParamType = ptInput
      end>
    Left = 488
    Top = 48
  end
  object qryEditInvoice: TFDCommand
    Connection = dmMain.FDConnection
    Transaction = trWrite
    CommandText.Strings = (
      'EXECUTE PROCEDURE sp_edit_invoice('
      '  :INVOICE_ID, '
      '  :CUSTOMER_ID, '
      '  :INVOICE_DATE'
      ')')
    ParamData = <
      item
        Name = 'INVOICE_ID'
        ParamType = ptInput
      end
      item
        Name = 'CUSTOMER_ID'
        ParamType = ptInput
      end
      item
        Name = 'INVOICE_DATE'
        ParamType = ptInput
      end>
    Left = 488
    Top = 96
  end
  object qryDeleteInvoice: TFDCommand
    Connection = dmMain.FDConnection
    Transaction = trWrite
    CommandText.Strings = (
      'EXECUTE PROCEDURE sp_delete_invoice(:INVOICE_ID)')
    ParamData = <
      item
        Name = 'INVOICE_ID'
        ParamType = ptInput
      end>
    Left = 488
    Top = 144
  end
  object qryPayForInvoice: TFDCommand
    Connection = dmMain.FDConnection
    Transaction = trWrite
    CommandText.Strings = (
      'EXECUTE PROCEDURE sp_pay_for_inovice(:invoice_id)')
    ParamData = <
      item
        Name = 'INVOICE_ID'
        ParamType = ptInput
      end>
    Left = 568
    Top = 96
  end
  object DetailSource: TDataSource
    DataSet = qryInvoiceLine
    Left = 376
    Top = 256
  end
  object qryInvoiceLine: TFDQuery
    MasterSource = MasterSource
    MasterFields = 'INVOICE_ID'
    Connection = dmMain.FDConnection
    Transaction = trRead
    UpdateTransaction = trWrite
    SQL.Strings = (
      'SELECT'
      '    invoice_line.invoice_line_id AS invoice_line_id,'
      '    invoice_line.invoice_id AS invoice_id,'
      '    invoice_line.product_id AS product_id,'
      '    product.name AS productname,'
      '    invoice_line.quantity AS quantity,'
      '    invoice_line.sale_price AS sale_price,'
      '    invoice_line.quantity * invoice_line.sale_price AS total'
      'FROM'
      '    invoice_line'
      'JOIN product ON product.product_id = invoice_line.product_id'
      'WHERE invoice_line.invoice_id = :invoice_id')
    Left = 376
    Top = 312
    ParamData = <
      item
        Name = 'INVOICE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryInvoiceLineINVOICE_LINE_ID: TIntegerField
      FieldName = 'INVOICE_LINE_ID'
      Origin = 'INVOICE_LINE_ID'
      Required = True
      Visible = False
    end
    object qryInvoiceLineINVOICE_ID: TIntegerField
      FieldName = 'INVOICE_ID'
      Origin = 'INVOICE_ID'
      Required = True
      Visible = False
    end
    object qryInvoiceLinePRODUCT_ID: TIntegerField
      FieldName = 'PRODUCT_ID'
      Origin = 'PRODUCT_ID'
      Required = True
      Visible = False
    end
    object qryInvoiceLinePRODUCTNAME: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Product'
      FieldName = 'PRODUCTNAME'
      Origin = 'NAME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qryInvoiceLineQUANTITY: TLargeintField
      DisplayLabel = 'Quantity'
      FieldName = 'QUANTITY'
      Origin = 'QUANTITY'
      Required = True
    end
    object qryInvoiceLineSALE_PRICE: TBCDField
      DisplayLabel = 'Price'
      FieldName = 'SALE_PRICE'
      Origin = 'SALE_PRICE'
      Required = True
      DisplayFormat = '0.00'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryInvoiceLineTOTAL: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Total'
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.00'
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object qryAddInvoiceLine: TFDCommand
    Connection = dmMain.FDConnection
    Transaction = trWrite
    CommandText.Strings = (
      'EXECUTE PROCEDURE sp_add_invoice_line('
      '  :invoice_id, '
      '  :product_id, '
      '  :quantity'
      ')')
    ParamData = <
      item
        Name = 'INVOICE_ID'
        ParamType = ptInput
      end
      item
        Name = 'PRODUCT_ID'
        ParamType = ptInput
      end
      item
        Name = 'QUANTITY'
        ParamType = ptInput
      end>
    Left = 488
    Top = 244
  end
  object qryEditInvoiceLine: TFDCommand
    Connection = dmMain.FDConnection
    Transaction = trWrite
    CommandText.Strings = (
      'EXECUTE PROCEDURE sp_edit_invoice_line('
      '  :invoice_line_id,'
      '  :quantity'
      ')')
    ParamData = <
      item
        Name = 'INVOICE_LINE_ID'
        ParamType = ptInput
      end
      item
        Name = 'QUANTITY'
        ParamType = ptInput
      end>
    Left = 488
    Top = 300
  end
  object qryDeleteInvoiceLine: TFDCommand
    Connection = dmMain.FDConnection
    Transaction = trWrite
    CommandText.Strings = (
      'EXECUTE PROCEDURE sp_delete_invoice_line(:invoice_line_id)')
    ParamData = <
      item
        Name = 'INVOICE_LINE_ID'
        ParamType = ptInput
      end>
    Left = 488
    Top = 356
  end
  object trRead: TFDTransaction
    Options.ReadOnly = True
    Options.AutoStart = False
    Options.AutoStop = False
    Connection = dmMain.FDConnection
    Left = 280
    Top = 208
  end
end
