unit CustomerEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB;

type

  TEditCustomerForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBMemo1: TDBMemo;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
  public
    property DataSource: TDataSource read FDataSource write SetDataSource;
  end;

var
  EditCustomerForm: TEditCustomerForm;

implementation

{$R *.dfm}


{ TEditCustomerForm }

procedure TEditCustomerForm.FormCreate(Sender: TObject);
begin
  DBEdit3.DataField := 'NAME';
  DBMemo1.DataField := 'ADDRESS';
  DBEdit2.DataField := 'ZIPCODE';
  DBEdit1.DataField := 'PHONE';
end;

procedure TEditCustomerForm.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;

  DBEdit3.DataSource := FDataSource;
  DBMemo1.DataSource := FDataSource;
  DBEdit2.DataSource := FDataSource;
  DBEdit1.DataSource := FDataSource;
end;

end.
