unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ComCtrls,
  Vcl.Tabs;

type
  TClassFrom = class of TForm;

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    miCatalogs: TMenuItem;
    miCustomers: TMenuItem;
    miGoods: TMenuItem;
    miRegisters: TMenuItem;
    miInvoice: TMenuItem;
    mdiChildrenTabs: TTabSet;
    StatusBar: TStatusBar;
    miSettings: TMenuItem;
    miDateRange: TMenuItem;
    procedure miCustomersClick(Sender: TObject);
    procedure miGoodsClick(Sender: TObject);
    procedure miInvoiceClick(Sender: TObject);
    procedure mdiChildrenTabsChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure miDateRangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateMDIChildForm(AFormType: TClassFrom);
    procedure MDIFormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses dMain, Customers, Goods, Invoice, RangeDateEditor;


procedure TMainForm.CreateMDIChildForm(AFormType: TClassFrom);
var
  xMDIForm: TForm;
  i: Integer;
begin
  // if our form is opened for the second time, then we
  // activate a previous instance
  for i := 0 to mdiChildrenTabs.Tabs.Count-1 do
  begin
    if (mdiChildrenTabs.Tabs.Objects[i].ClassName = AFormType.ClassName) then
    begin
      mdiChildrenTabs.TabIndex := i;
      Exit;
    end;
  end;

  // Create MDI form and put it on the tab
  xMDIForm := AFormType.Create(Self);
  with xMDIForm do
  begin
    BorderStyle := bsNone;
    BorderIcons := [];
    FormStyle := fsMDIChild;
    WindowState := wsMaximized;
    OnClose := MDIFormClose;
    mdiChildrenTabs.TabIndex := mdiChildrenTabs.Tabs.AddObject(Caption, xMDIForm);
  end;
  mdiChildrenTabs.Refresh;
end;

procedure TMainForm.miCustomersClick(Sender: TObject);
begin
  CreateMDIChildForm(TCustomerForm);
end;

procedure TMainForm.miDateRangeClick(Sender: TObject);
var
  xEditor: TDateRangeForm;
begin
  xEditor := TDateRangeForm.Create(Self);
  try
    xEditor.edtDateBegin.DateTime := dmMain.BeginDate;
    xEditor.edtDateEnd.DateTime := dmMain.EndDate;
    if xEditor.ShowModal = mrOK then
    begin
      dmMain.BeginDate := xEditor.edtDateBegin.DateTime;
      dmMain.EndDate := xEditor.edtDateEnd.DateTime;
      // We notify all subscribers of the change in the date range
      dmMain.DateChangeNotify;
    end;
  finally
    xEditor.Free;
  end;
end;

procedure TMainForm.miGoodsClick(Sender: TObject);
begin
  CreateMDIChildForm(TGoodsForm);
end;

procedure TMainForm.miInvoiceClick(Sender: TObject);
begin
  CreateMDIChildForm(TInvoiceForm);
end;

procedure TMainForm.mdiChildrenTabsChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  xMDIForm: TForm;
begin
  xMDIForm := TForm(mdiChildrenTabs.Tabs.Objects[NewTab]);
  xMDIForm.Show;
  xMDIForm.WindowState := wsMaximized;
end;

procedure TMainForm.MDIFormClose(Sender: TObject; var Action: TCloseAction);
var
  xTabIndex: Integer;
begin
  xTabIndex := mdiChildrenTabs.Tabs.IndexOfObject(Sender);
  if xTabIndex > 0 then
    mdiChildrenTabs.TabIndex := xTabIndex - 1
  else if xTabIndex < mdiChildrenTabs.Tabs.Count-1 then
    mdiChildrenTabs.TabIndex := xTabIndex + 1;

  mdiChildrenTabs.Tabs.Delete(xTabIndex);
  Action := caFree;
end;

end.
