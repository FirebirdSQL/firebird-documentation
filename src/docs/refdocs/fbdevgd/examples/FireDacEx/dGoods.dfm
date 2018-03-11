object dmGoods: TdmGoods
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 521
  Width = 691
  object qryGoods: TFDQuery
    Connection = dmMain.FDConnection
    Transaction = trRead
    UpdateTransaction = trWrite
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvCheckRequired]
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateObject = FDUpdateGoods
    SQL.Strings = (
      'SELECT'
      '    product_id,'
      '    name,'
      '    price,'
      '    description'
      'FROM'
      '    product'
      'ORDER BY name')
    Left = 352
    Top = 56
    object qryGoodsPRODUCT_ID: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'PRODUCT_ID'
      Origin = 'PRODUCT_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qryGoodsNAME: TWideStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 40
    end
    object qryGoodsPRICE: TBCDField
      DisplayLabel = 'Price'
      FieldName = 'PRICE'
      Origin = 'PRICE'
      Required = True
      DisplayFormat = '0.00'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryGoodsDESCRIPTION: TFDWideMemoField
      DisplayLabel = 'Description'
      FieldName = 'DESCRIPTION'
      Origin = 'DESCRIPTION'
      Visible = False
      BlobType = ftWideMemo
    end
  end
  object FDUpdateGoods: TFDUpdateSQL
    Connection = dmMain.FDConnection
    InsertSQL.Strings = (
      'INSERT INTO PRODUCT'
      '(NAME, PRICE, DESCRIPTION)'
      'VALUES (:NEW_NAME, :NEW_PRICE, :NEW_DESCRIPTION)'
      'RETURNING PRODUCT_ID')
    ModifySQL.Strings = (
      'UPDATE PRODUCT'
      
        'SET PRODUCT_ID = :NEW_PRODUCT_ID, NAME = :NEW_NAME, PRICE = :NEW' +
        '_PRICE, '
      '  DESCRIPTION = :NEW_DESCRIPTION'
      'WHERE PRODUCT_ID = :OLD_PRODUCT_ID')
    DeleteSQL.Strings = (
      'DELETE FROM PRODUCT'
      'WHERE PRODUCT_ID = :OLD_PRODUCT_ID')
    FetchRowSQL.Strings = (
      'SELECT PRODUCT_ID, NAME, PRICE, DESCRIPTION'
      'FROM PRODUCT'
      'WHERE PRODUCT_ID = :PRODUCT_ID')
    Left = 352
    Top = 104
  end
  object trWrite: TFDTransaction
    Options.Isolation = xiSnapshot
    Options.AutoStart = False
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = dmMain.FDConnection
    Left = 352
    Top = 152
  end
  object DataSource: TDataSource
    DataSet = qryGoods
    Left = 440
    Top = 56
  end
  object trRead: TFDTransaction
    Options.ReadOnly = True
    Options.AutoStop = False
    Connection = dmMain.FDConnection
    Left = 416
    Top = 152
  end
end
