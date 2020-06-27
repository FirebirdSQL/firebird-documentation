program FireDacEx;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  Customers in 'Customers.pas' {CustomerForm},
  Goods in 'Goods.pas' {GoodsForm},
  Invoice in 'Invoice.pas' {InvoiceForm},
  dMain in 'dMain.pas' {dmMain: TDataModule},
  CustomerEditor in 'CustomerEditor.pas' {EditCustomerForm},
  GoodsEditor in 'GoodsEditor.pas' {EditGoodsForm},
  InvoiceEditor in 'InvoiceEditor.pas' {EditInvoiceForm},
  InvoiceLineEditor in 'InvoiceLineEditor.pas' {EditInvoiceLineForm},
  RangeDateEditor in 'RangeDateEditor.pas' {DateRangeForm},
  LoginPrompt in 'LoginPrompt.pas' {LoginPromptForm},
  Vcl.Themes,
  Vcl.Styles,
  dGoods in 'dGoods.pas' {dmGoods: TDataModule},
  dCustomers in 'dCustomers.pas' {dmCustomers: TDataModule},
  dInvoice in 'dInvoice.pas' {dmInvoice: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Firebird Example';
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
