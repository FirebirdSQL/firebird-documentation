unit dInvoice;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet,
  dMain;

type
  TInvoiceRecord = record
    INVOICE_ID: TIntegerField;
    CUSTOMER_ID: TIntegerField;
    CUSTOMER_NAME: TWideStringField;
    INVOICE_DATE: TSQLTimeStampField;
    TOTAL_SALE: TBCDField;
    PAID: TWideStringField;
  end;

  TInvoiceLineRecord = record
    INVOICE_LINE_ID: TIntegerField;
    INVOICE_ID: TIntegerField;
    PRODUCT_ID: TIntegerField;
    PRODUCTNAME: TWideStringField;
    QUANTITY: TLargeIntField;
    SALE_PRICE: TBCDField;
    TOTAL: TBCDField;
  end;

  TdmInvoice = class(TDataModule)
    MasterSource: TDataSource;
    trWrite: TFDTransaction;
    qryInvoice: TFDQuery;
    qryAddInvoice: TFDCommand;
    qryEditInvoice: TFDCommand;
    qryDeleteInvoice: TFDCommand;
    qryPayForInvoice: TFDCommand;
    DetailSource: TDataSource;
    qryInvoiceLine: TFDQuery;
    qryAddInvoiceLine: TFDCommand;
    qryEditInvoiceLine: TFDCommand;
    qryDeleteInvoiceLine: TFDCommand;
    trRead: TFDTransaction;
    qryInvoiceLineINVOICE_LINE_ID: TIntegerField;
    qryInvoiceLineINVOICE_ID: TIntegerField;
    qryInvoiceLinePRODUCT_ID: TIntegerField;
    qryInvoiceLinePRODUCTNAME: TWideStringField;
    qryInvoiceLineQUANTITY: TLargeintField;
    qryInvoiceLineSALE_PRICE: TBCDField;
    qryInvoiceLineTOTAL: TBCDField;
    qryInvoiceINVOICE_ID: TIntegerField;
    qryInvoiceCUSTOMER_ID: TIntegerField;
    qryInvoiceCUSTOMER_NAME: TWideStringField;
    qryInvoiceINVOICE_DATE: TSQLTimeStampField;
    qryInvoiceTOTAL_SALE: TBCDField;
    qryInvoicePAID: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);  private
    FInvoice: TInvoiceRecord;
    FInvoiceLine: TInvoiceLineRecord;
  public
    procedure Open;
    procedure Close;
    procedure Reopen;
    procedure RefreshInvoice;
    procedure AddInvoice(ACustomerId: Integer; AInvoiceDate: TDateTime);
    procedure EditInvoice(ACustomerId: Integer; AInvoiceDate: TDateTime);
    procedure DeleteInvoice;
    procedure PayInvoice;
    procedure AddInvoiceLine(AProductId: Integer; AQuantity: Integer);
    procedure EditInvoiceLine(AQuantity: Integer);
    procedure DeleteInvoiceLine;

    property Invoice: TInvoiceRecord read FInvoice;
    property InvoiceLine: TInvoiceLineRecord read FInvoiceLine;
  end;

var
  dmInvoice: TdmInvoice;

implementation

uses Data.SqlTimSt;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmInvoice }

procedure TdmInvoice.AddInvoice(ACustomerId: Integer; AInvoiceDate: TDateTime);
begin
  // We do everything in a short transaction
  trWrite.StartTransaction;
  try
    qryAddInvoice.ParamByName('CUSTOMER_ID').AsInteger := ACustomerId;
    qryAddInvoice.ParamByName('INVOICE_DATE').AsSqlTimeStamp :=
      DateTimeToSQLTimeStamp(AInvoiceDate);

    qryAddInvoice.Execute();

    trWrite.Commit;
    qryInvoice.Refresh;
  except
    on E: Exception do
    begin
      if trWrite.Active then
        trWrite.Rollback;

      raise;
    end;
  end;
end;

procedure TdmInvoice.AddInvoiceLine(AProductId: Integer; AQuantity: Integer);
begin
  // We do everything in a short transaction
  trWrite.StartTransaction;
  try
    qryAddInvoiceLine.ParamByName('INVOICE_ID').AsInteger :=
      Invoice.INVOICE_ID.Value;

    if AProductId = 0 then
      raise Exception.Create('Not selected product');

    qryAddInvoiceLine.ParamByName('PRODUCT_ID').AsInteger := AProductId;
    qryAddInvoiceLine.ParamByName('QUANTITY').AsInteger := AQuantity;

    qryAddInvoiceLine.Execute();

    trWrite.Commit;
    qryInvoice.Refresh;
    qryInvoiceLine.Refresh;

  except
    on E: Exception do
    begin
      if trWrite.Active then
        trWrite.Rollback;
      raise;
    end;
  end;
end;

procedure TdmInvoice.Close;
begin
  qryInvoiceLine.Close;
  qryInvoice.Close;
  if trRead.Active then
    trRead.Commit;
end;

procedure TdmInvoice.DataModuleCreate(Sender: TObject);
begin
  FInvoice.INVOICE_ID := qryInvoiceINVOICE_ID;
  FInvoice.CUSTOMER_ID := qryInvoiceCUSTOMER_ID;
  FInvoice.CUSTOMER_NAME := qryInvoiceCUSTOMER_NAME;
  FInvoice.INVOICE_DATE := qryInvoiceINVOICE_DATE;
  FInvoice.TOTAL_SALE := qryInvoiceTOTAL_SALE;
  FInvoice.PAID :=  qryInvoicePAID;

  FInvoiceLine.INVOICE_LINE_ID := qryInvoiceLineINVOICE_LINE_ID;
  FInvoiceLine.INVOICE_ID := qryInvoiceLineINVOICE_ID;
  FInvoiceLine.PRODUCT_ID := qryInvoiceLinePRODUCT_ID;
  FInvoiceLine.PRODUCTNAME := qryInvoiceLinePRODUCTNAME;
  FInvoiceLine.QUANTITY := qryInvoiceLineQUANTITY;
  FInvoiceLine.SALE_PRICE := qryInvoiceLineSALE_PRICE;
  FInvoiceLine.TOTAL := qryInvoiceLineTOTAL;
end;

procedure TdmInvoice.DeleteInvoice;
begin
  // We do everything in a short transaction
  trWrite.StartTransaction;
  try
    qryDeleteInvoice.ParamByName('INVOICE_ID').AsInteger :=
      Invoice.INVOICE_ID.Value;
    qryDeleteInvoice.Execute;
    trWrite.Commit;
    qryInvoice.Refresh;
  except
    on E: Exception do
    begin
      if trWrite.Active then
        trWrite.Rollback;
      raise;
    end;
  end;
end;

procedure TdmInvoice.DeleteInvoiceLine;
begin
  // We do everything in a short transaction
  trWrite.StartTransaction;
  try
    qryDeleteInvoiceLine.ParamByName('INVOICE_LINE_ID').AsInteger :=
      InvoiceLine.INVOICE_LINE_ID.Value;
    qryDeleteInvoiceLine.Execute;
    trWrite.Commit;
    qryInvoice.Refresh;
    qryInvoiceLine.Refresh;
  except
    on E: Exception do
    begin
      if trWrite.Active then
        trWrite.Rollback;
      raise;
    end;
  end;
end;

procedure TdmInvoice.EditInvoice(ACustomerId: Integer; AInvoiceDate: TDateTime);
begin
  // We do everything in a short transaction
  trWrite.StartTransaction;
  try

    qryEditInvoice.ParamByName('INVOICE_ID').AsInteger :=
      Invoice.INVOICE_ID.Value;
    qryEditInvoice.ParamByName('CUSTOMER_ID').AsInteger := ACustomerId;
    qryEditInvoice.ParamByName('INVOICE_DATE').AsSqlTimeStamp :=
      DateTimeToSQLTimeStamp(AInvoiceDate);

    qryEditInvoice.Execute();

    trWrite.Commit;
    qryInvoice.Refresh;

  except
    on E: Exception do
    begin
      if trWrite.Active then
        trWrite.Rollback;
    end;
  end;
end;

procedure TdmInvoice.EditInvoiceLine(AQuantity: Integer);
begin
  // We do everything in a short transaction
  trWrite.StartTransaction;
  try
    qryEditInvoiceLine.ParamByName('INVOICE_LINE_ID').AsInteger :=
      InvoiceLine.INVOICE_LINE_ID.Value;
    qryEditInvoiceLine.ParamByName('QUANTITY').AsInteger := AQuantity;

    qryEditInvoiceLine.Execute();

    trWrite.Commit;
    qryInvoice.Refresh;
    qryInvoiceLine.Refresh;

  except
    on E: Exception do
    begin
      if trWrite.Active then
        trWrite.Rollback;
      raise;
    end;
  end;
end;

procedure TdmInvoice.Open;
begin
  trRead.StartTransaction;
  qryInvoice.ParamByName('date_begin').AsSqlTimeStamp := dmMain.BeginDateSt;
  qryInvoice.ParamByName('date_end').AsSqlTimeStamp := dmMain.EndDateSt;
  qryInvoice.Open;
  qryInvoiceLine.Open;
end;

procedure TdmInvoice.PayInvoice;
begin
  // We do everything in a short transaction
  trWrite.StartTransaction;
  try
    qryPayForInvoice.ParamByName('INVOICE_ID').AsInteger :=
      Invoice.INVOICE_ID.Value;
    qryPayForInvoice.Execute;
    trWrite.Commit;
    qryInvoice.Refresh;
  except
    on E: Exception do
    begin
      if trWrite.Active then
        trWrite.Rollback;
      raise;
    end;
  end;
end;

procedure TdmInvoice.RefreshInvoice;
begin
  qryInvoice.Refresh;
end;

procedure TdmInvoice.Reopen;
begin
  Close;
  Open;
end;

end.
