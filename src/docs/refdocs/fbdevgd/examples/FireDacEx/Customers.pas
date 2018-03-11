unit Customers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.ImgList, System.Actions, Vcl.ActnList,
  dCustomers;

type
  TCustomerForm = class(TForm)
    DBGrid: TDBGrid;
    ToolBar1: TToolBar;
    ActionList: TActionList;
    actAddRecord: TAction;
    actEditRecord: TAction;
    actDeleteRecord: TAction;
    btnAddRecord: TToolButton;
    btnEditRecord: TToolButton;
    btnDeleteRecord: TToolButton;
    ToolButton1: TToolButton;
    actExit: TAction;
    ToolButton2: TToolButton;
    actRefresh: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure FormActivate(Sender: TObject);
    procedure actAddRecordExecute(Sender: TObject);
    procedure actEditRecordExecute(Sender: TObject);
    procedure actDeleteRecordExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FCustomers: TdmCustomers;
    procedure CustomerEditorClose(Sender: TObject; var Action: TCloseAction);
  public
    property Customers: TdmCustomers read FCustomers;
  end;

var
  CustomerForm: TCustomerForm;

implementation

{$R *.dfm}

uses CustomerEditor;

{ TCustomerForm }

procedure TCustomerForm.actAddRecordExecute(Sender: TObject);
var
  xEditorForm: TEditCustomerForm;
begin
  xEditorForm := TEditCustomerForm.Create(Self);
  try
    xEditorForm.OnClose := CustomerEditorClose;
    xEditorForm.DataSource := Customers.DataSource;
    xEditorForm.Caption := 'Add customer';
    Customers.Add;
    xEditorForm.ShowModal;
  finally
    xEditorForm.Free;
  end;
end;

procedure TCustomerForm.actDeleteRecordExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to delete the customer?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    try
      Customers.Delete;
      Customers.Save;
    except
      on E: Exception do
        Application.ShowException(E);
    end;
  end;
end;

procedure TCustomerForm.actEditRecordExecute(Sender: TObject);
var
  xEditorForm: TEditCustomerForm;
begin
  xEditorForm := TEditCustomerForm.Create(Self);
  try
    xEditorForm.OnClose := CustomerEditorClose;
    xEditorForm.DataSource := Customers.DataSource;
    xEditorForm.Caption := 'Edit customer';
    Customers.Edit;
    xEditorForm.ShowModal;
  finally
    xEditorForm.Free;
  end;
end;

procedure TCustomerForm.actExitExecute(Sender: TObject);
begin
  Customers.Close;
  Close;
end;

procedure TCustomerForm.actRefreshExecute(Sender: TObject);
begin
  CustomerS.Refresh;
end;

procedure TCustomerForm.CustomerEditorClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if TEditCustomerForm(Sender).ModalResult <> mrOK then
  begin
    Customers.Cancel;
    Action := caFree;
    Exit;
  end;

  try
    Customers.Post;
    Customers.Save;

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

procedure TCustomerForm.DBGridDblClick(Sender: TObject);
begin
  if fsModal in FormState then
  begin
    ModalResult := mrOK;
    CloseModal;
  end
  else
  begin
    actEditRecordExecute(Self);
  end;
end;

procedure TCustomerForm.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
  begin
    DBGridDblClick(Sender);
  end;
end;

procedure TCustomerForm.FormActivate(Sender: TObject);
begin
  Customers.Open;
end;

procedure TCustomerForm.FormCreate(Sender: TObject);
begin
  FCustomers := TDMCustomers.Create(Self);
  DBGrid.DataSource := Customers.DataSource;
end;

end.
