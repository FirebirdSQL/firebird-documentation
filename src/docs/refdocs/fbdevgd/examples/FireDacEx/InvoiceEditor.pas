unit InvoiceEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons;

type

  TEditInvoiceForm = class(TForm)
    edtInvoiceDate: TDateTimePicker;
    edtCustomer: TButtonedEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtInvoiceTime: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtInvoiceDateChange(Sender: TObject);
    procedure edtInvoiceTimeChange(Sender: TObject);
    procedure edtCustomerRightButtonClick(Sender: TObject);
  private
    FCustomerId: Integer;
    FInvoiceId: Integer;
    FInvoiceDate: TDateTime;

    procedure SetInvoiceDate(const Value: TDateTime);
  public
    property InvoiceId: Integer read FInvoiceId write FInvoiceId;
    property CustomerId: Integer read FCustomerId;
    property InvoiceDate: TDateTime read FInvoiceDate write SetInvoiceDate;

    procedure SetCustomer(ACustomerId: Integer; const ACustomerName: string);
  end;

var
  EditInvoiceForm: TEditInvoiceForm;

implementation

{$R *.dfm}

uses Customers;

procedure TEditInvoiceForm.edtCustomerRightButtonClick(Sender: TObject);
var
  xSelectForm: TCustomerForm;
begin
  xSelectForm := TCustomerForm.Create(Self);
  try
    xSelectForm.Visible := False;
    if xSelectForm.ShowModal = mrOK then
    begin
      FCustomerId := xSelectForm.Customers.Customer.CUSTOMER_ID.Value;
      edtCustomer.Text := xSelectForm.Customers.Customer.NAME.Value;
    end;
  finally
    xSelectForm.Free;
  end;
end;

procedure TEditInvoiceForm.edtInvoiceDateChange(Sender: TObject);
begin
  FInvoiceDate := Int(edtInvoiceDate.Date) + Frac(edtInvoiceTime.Time);
end;

procedure TEditInvoiceForm.edtInvoiceTimeChange(Sender: TObject);
begin
  FInvoiceDate := Int(edtInvoiceDate.Date) + Frac(edtInvoiceTime.Time);
end;

procedure TEditInvoiceForm.FormCreate(Sender: TObject);
begin
  FInvoiceId := 0;
  FCustomerId := 0;
  FInvoiceDate := Now;
  edtInvoiceDate.Format := 'dd.MM.yyyy';
  edtInvoiceTime.Format := 'HH:mm:ss';
end;

procedure TEditInvoiceForm.SetCustomer(ACustomerId: Integer;
  const ACustomerName: string);
begin
  FCustomerId := ACustomerId;
  edtCustomer.Text := ACustomerName;
end;

procedure TEditInvoiceForm.SetInvoiceDate(const Value: TDateTime);
begin
  FInvoiceDate := Value;
  edtInvoiceDate.DateTime := FInvoiceDate;
  edtInvoiceTime.DateTime := FInvoiceDate;
end;

end.
