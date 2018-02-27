unit Invoice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.UITypes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB, System.Actions, Vcl.ActnList,
  Data.SqlTimSt,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ImgList,
  dInvoice;

type
  TInvoiceForm = class(TForm)
    MasterPanel: TPanel;
    Splitter1: TSplitter;
    DetailPanel: TPanel;
    DetailToolBar: TToolBar;
    MasterToolBar: TToolBar;
    MasterGrid: TDBGrid;
    DetailGrid: TDBGrid;
    ActionList: TActionList;
    actAddInvoice: TAction;
    actEditInvoice: TAction;
    actDeleteInvoice: TAction;
    actAddInvoiceLine: TAction;
    actEditInvoiceLine: TAction;
    actDeleteInvoiceLine: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    actExit: TAction;
    actRefresh: TAction;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ImageList1: TImageList;
    actInvoicePay: TAction;
    ToolButton11: TToolButton;
    procedure FormActivate(Sender: TObject);
    procedure actAddInvoiceExecute(Sender: TObject);
    procedure actEditInvoiceExecute(Sender: TObject);
    procedure actDeleteInvoiceExecute(Sender: TObject);
    procedure actAddInvoiceLineExecute(Sender: TObject);
    procedure actEditInvoiceLineExecute(Sender: TObject);
    procedure actDeleteInvoiceLineExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actInvoicePayExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FInvoices: TdmInvoice;
    procedure AddInvoiceEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure EditInvoiceEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure AddInvoiceLineEditorClose(Sender: TObject;
      var Action: TCloseAction);
    procedure EditInvoiceLineEditorClose(Sender: TObject;
      var Action: TCloseAction);
  public
    procedure DateRangeChange(Sender: TObject);
    property Invoices: TdmInvoice read FInvoices;
  end;

var
  InvoiceForm: TInvoiceForm;

implementation

{$R *.dfm}

uses InvoiceEditor, dMain, InvoiceLineEditor;

procedure TInvoiceForm.actAddInvoiceExecute(Sender: TObject);
var
  xEditorForm: TEditInvoiceForm;
begin
  xEditorForm := TEditInvoiceForm.Create(Self);
  try
    xEditorForm.Caption := 'Add invoice';
    xEditorForm.OnClose := AddInvoiceEditorClose;

    xEditorForm.InvoiceDate := Now;

    xEditorForm.ShowModal;
  finally
    xEditorForm.Free;
  end;
end;

procedure TInvoiceForm.actAddInvoiceLineExecute(Sender: TObject);
var
  xEditorForm: TEditInvoiceLineForm;
begin
  xEditorForm := TEditInvoiceLineForm.Create(Self);
  try
    xEditorForm.EditMode := emInvoiceLineAdd;
    xEditorForm.OnClose := AddInvoiceLineEditorClose;
    xEditorForm.Caption := 'Add invoice line';

    xEditorForm.Quantity := 1;
    xEditorForm.InvoiceId := Invoices.Invoice.INVOICE_ID.Value;
    xEditorForm.ShowModal;
  finally
    xEditorForm.Free;
  end;
end;

procedure TInvoiceForm.actDeleteInvoiceExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to delete an invoice?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    Invoices.DeleteInvoice;
  end;
end;

procedure TInvoiceForm.actDeleteInvoiceLineExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to delete an invoice line?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Invoices.DeleteInvoiceLine;
  end;
end;

procedure TInvoiceForm.actEditInvoiceExecute(Sender: TObject);
var
  xEditorForm: TEditInvoiceForm;
begin
  xEditorForm := TEditInvoiceForm.Create(Self);
  try
    xEditorForm.OnClose := EditInvoiceEditorClose;
    xEditorForm.Caption := 'Edit invoice';

    xEditorForm.InvoiceId := Invoices.Invoice.INVOICE_ID.Value;
    xEditorForm.SetCustomer(
      Invoices.Invoice.CUSTOMER_ID.Value,
      Invoices.Invoice.CUSTOMER_NAME.Value);
    xEditorForm.InvoiceDate := Invoices.Invoice.INVOICE_DATE.AsDateTime;

    xEditorForm.ShowModal;
  finally
    xEditorForm.Free;
  end;
end;

procedure TInvoiceForm.actEditInvoiceLineExecute(Sender: TObject);
var
  xEditorForm: TEditInvoiceLineForm;
begin
  xEditorForm := TEditInvoiceLineForm.Create(Self);
  try
    xEditorForm.EditMode := emInvoiceLineEdit;
    xEditorForm.OnClose := EditInvoiceLineEditorClose;
    xEditorForm.Caption := 'Edit invoice line';

    xEditorForm.InvoiceLineId := Invoices.InvoiceLine.INVOICE_LINE_ID.Value;
    xEditorForm.SetProduct(
      Invoices.InvoiceLine.PRODUCT_ID.Value,
      Invoices.InvoiceLine.PRODUCTNAME.Value,
      Invoices.InvoiceLine.SALE_PRICE.AsCurrency);
    xEditorForm.Quantity := Invoices.InvoiceLine.QUANTITY.Value;

    xEditorForm.ShowModal;
  finally
    xEditorForm.Free;
  end;
end;

procedure TInvoiceForm.actExitExecute(Sender: TObject);
begin
  Invoices.Close;
  Close;
end;

procedure TInvoiceForm.actInvoicePayExecute(Sender: TObject);
begin
  if MessageDlg('Do you really want to pay by invoice?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    Invoices.PayInvoice;
  end;
end;

procedure TInvoiceForm.actRefreshExecute(Sender: TObject);
begin
  Invoices.RefreshInvoice;
end;

procedure TInvoiceForm.DateRangeChange(Sender: TObject);
begin
  Invoices.Reopen;
end;

procedure TInvoiceForm.EditInvoiceEditorClose(Sender: TObject;
  var Action: TCloseAction);
var
  xEditorForm: TEditInvoiceForm;
begin
  xEditorForm := TEditInvoiceForm(Sender);

  if xEditorForm.ModalResult <> mrOK then
  begin
    Action := caFree;
    Exit;
  end;

  try
    Invoices.EditInvoice(xEditorForm.CustomerId, xEditorForm.InvoiceDate);

    Action := caFree;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      // It does not close the window give the user correct the error
      Action := caNone;
    end;
  end;
end;

procedure TInvoiceForm.EditInvoiceLineEditorClose(Sender: TObject;
  var Action: TCloseAction);
var
  xCustomerId: Integer;
  xEditorForm: TEditInvoiceLineForm;
begin
  xEditorForm := TEditInvoiceLineForm(Sender);

  if xEditorForm.ModalResult <> mrOK then
  begin
    Action := caFree;
    Exit;
  end;

  try
    Invoices.EditInvoiceLine(xEditorForm.Quantity);

    Action := caFree;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      // It does not close the window give the user correct the error
      Action := caNone;
    end;
  end;
end;

procedure TInvoiceForm.FormActivate(Sender: TObject);
begin
  Invoices.Open;
end;

procedure TInvoiceForm.FormCreate(Sender: TObject);
begin
  FInvoices := TDMInvoice.Create(Self);
  MasterGrid.DataSource := FInvoices.MasterSource;
  DetailGrid.DataSource := FInvoices.DetailSource;
  dmMain.AddDateChangeHandler(DateRangeChange);
end;

procedure TInvoiceForm.FormDestroy(Sender: TObject);
begin
  dmMain.RemoveDateChangeHandler(DateRangeChange);
end;

procedure TInvoiceForm.AddInvoiceEditorClose(Sender: TObject;
  var Action: TCloseAction);
var
  xEditorForm: TEditInvoiceForm;
begin
  xEditorForm := TEditInvoiceForm(Sender);

  if xEditorForm.ModalResult <> mrOK then
  begin
    Action := caFree;
    Exit;
  end;

  try
    Invoices.AddInvoice(xEditorForm.CustomerId, xEditorForm.InvoiceDate);

    Action := caFree;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      // It does not close the window give the user correct the error
      Action := caNone;
    end;
  end;
end;

procedure TInvoiceForm.AddInvoiceLineEditorClose(Sender: TObject;
  var Action: TCloseAction);
var
  xEditorForm: TEditInvoiceLineForm;
  xCustomerId: Integer;
begin
  xEditorForm := TEditInvoiceLineForm(Sender);

  if xEditorForm.ModalResult <> mrOK then
  begin
    Action := caFree;
    Exit;
  end;

  try
    Invoices.AddInvoiceLine(xEditorForm.ProductId, xEditorForm.Quantity);

    Action := caFree;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      // It does not close the window give the user correct the error
      Action := caNone;
    end;
  end;
end;

end.
