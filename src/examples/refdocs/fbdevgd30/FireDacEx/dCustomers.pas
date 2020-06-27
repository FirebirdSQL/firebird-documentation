unit dCustomers;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet,
  dMain;

type
  TCustomerRecord = record
    CUSTOMER_ID: TIntegerField;
    NAME: TWideStringField;
    ADDRESS: TWideStringField;
    ZIPCODE: TWideStringField;
    PHONE: TWideStringField;
  end;

  TdmCustomers = class(TDataModule)
    qryCustomer: TFDQuery;
    qryCustomerCUSTOMER_ID: TIntegerField;
    qryCustomerNAME: TWideStringField;
    qryCustomerADDRESS: TWideStringField;
    qryCustomerZIPCODE: TWideStringField;
    qryCustomerPHONE: TWideStringField;
    FDUpdateCustomer: TFDUpdateSQL;
    trWrite: TFDTransaction;
    DataSource: TDataSource;
    trRead: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    FCustomer: TCustomerRecord;
  public
    procedure Open;
    procedure Close;
    procedure Refresh;
    procedure Add;
    procedure Edit;
    procedure Delete;
    procedure Post;
    procedure Cancel;
    procedure Save;

    property Customer: TCustomerRecord read FCustomer;
  end;

var
  dmCustomers: TdmCustomers;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmCustomers }

procedure TdmCustomers.Add;
begin
  qryCustomer.CachedUpdates := True;
  qryCustomer.Insert;
end;

procedure TdmCustomers.Cancel;
begin
  qryCustomer.Cancel;
  qryCustomer.CancelUpdates;
  qryCustomer.CachedUpdates := False;
end;

procedure TdmCustomers.Close;
begin
  qryCustomer.Close;
  if trRead.Active then
    trRead.Commit;
end;

procedure TdmCustomers.DataModuleCreate(Sender: TObject);
begin
  FCustomer.CUSTOMER_ID := qryCustomerCUSTOMER_ID;
  FCustomer.NAME := qryCustomerNAME;
  FCustomer.ADDRESS := qryCustomerADDRESS;
  FCustomer.ZIPCODE := qryCustomerZIPCODE;
  FCustomer.PHONE := qryCustomerPHONE;
end;

procedure TdmCustomers.Delete;
begin
  qryCustomer.CachedUpdates := True;
  qryCustomer.Delete;
end;

procedure TdmCustomers.Edit;
begin
  qryCustomer.CachedUpdates := True;
  qryCustomer.Edit;
end;

procedure TdmCustomers.Open;
begin
  trRead.StartTransaction;
  qryCustomer.Open;
end;

procedure TdmCustomers.Post;
begin
  qryCustomer.Post;
end;

procedure TdmCustomers.Refresh;
begin
  qryCustomer.Refresh;
end;

procedure TdmCustomers.Save;
begin
  // We do everything in a short transaction
  // In CachedUpdates mode error does not stop running.
  // ApplyUpdates method returns the number of errors.
  // The error can be obtained from the property RowError
  try

    trWrite.StartTransaction;
    if (qryCustomer.ApplyUpdates = 0) then
    begin
      qryCustomer.CommitUpdates;
      trWrite.Commit;
    end
    else
      raise Exception.Create(qryCustomer.RowError.Message);
    qryCustomer.CachedUpdates := False;
  except
    on E: Exception do
    begin
      if trWrite.Active then
        trWrite.Rollback;
      raise;
    end;
  end;
end;

end.
