object dmCustomers: TdmCustomers
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 419
  Width = 650
  object qryCustomer: TFDQuery
    Connection = dmMain.FDConnection
    Transaction = trRead
    UpdateTransaction = trWrite
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_CUSTOMER_ID'
    UpdateOptions.AutoIncFields = 'CUSTOMER_ID'
    UpdateObject = FDUpdateCustomer
    SQL.Strings = (
      'SELECT'
      '    customer_id,'
      '    name,'
      '    address,'
      '    zipcode,'
      '    phone'
      'FROM'
      '    customer'
      'ORDER BY name')
    Left = 376
    Top = 64
    object qryCustomerCUSTOMER_ID: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'CUSTOMER_ID'
      Origin = 'CUSTOMER_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object qryCustomerNAME: TWideStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 60
    end
    object qryCustomerADDRESS: TWideStringField
      DisplayLabel = 'Address'
      DisplayWidth = 50
      FieldName = 'ADDRESS'
      Origin = 'ADDRESS'
      Size = 250
    end
    object qryCustomerZIPCODE: TWideStringField
      DisplayLabel = 'Zip code'
      FieldName = 'ZIPCODE'
      Origin = 'ZIPCODE'
      FixedChar = True
      Size = 10
    end
    object qryCustomerPHONE: TWideStringField
      DisplayLabel = 'Phone'
      FieldName = 'PHONE'
      Origin = 'PHONE'
      Size = 13
    end
  end
  object FDUpdateCustomer: TFDUpdateSQL
    Connection = dmMain.FDConnection
    InsertSQL.Strings = (
      'INSERT INTO customer (customer_id,'
      '                      name,'
      '                      address,'
      '                      zipcode,'
      '                      phone)'
      'VALUES (:new_customer_id,'
      '        :new_name,'
      '        :new_address,'
      '        :new_zipcode,'
      '        :new_phone)')
    ModifySQL.Strings = (
      'UPDATE customer'
      'SET name = :new_name,'
      '    address = :new_address,'
      '    zipcode = :new_zipcode,'
      '    phone = :new_phone'
      'WHERE (customer_id = :old_customer_id)')
    DeleteSQL.Strings = (
      'DELETE FROM customer'
      'WHERE (customer_id = :old_customer_id)'
      '')
    FetchRowSQL.Strings = (
      'SELECT'
      '    customer_id,'
      '    name,'
      '    address,'
      '    zipcode,'
      '    phone'
      'FROM'
      '    customer'
      'WHERE customer_id = :old_customer_id')
    Left = 376
    Top = 120
  end
  object trWrite: TFDTransaction
    Options.Isolation = xiSnapshot
    Options.AutoStart = False
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = dmMain.FDConnection
    Left = 480
    Top = 64
  end
  object DataSource: TDataSource
    DataSet = qryCustomer
    Left = 240
    Top = 56
  end
  object trRead: TFDTransaction
    Options.ReadOnly = True
    Options.AutoStart = False
    Options.AutoStop = False
    Connection = dmMain.FDConnection
    Left = 480
    Top = 128
  end
end
