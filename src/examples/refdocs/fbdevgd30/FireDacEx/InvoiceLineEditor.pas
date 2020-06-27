unit InvoiceLineEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TInvoiceLineEditMode = (emInvoiceLineAdd, emInvoiceLineEdit);

  TEditInvoiceLineForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtProduct: TButtonedEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtPrice: TEdit;
    Label3: TLabel;
    edtQuantity: TEdit;
    procedure edtProductRightButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtQuantityChange(Sender: TObject);
  private
    FEditMode: TInvoiceLineEditMode;

    FInvoiceLineId: Integer;
    FInvoiceId: Integer;
    FProductId: Integer;
    FQuantity: Integer;
    procedure SetQuantity(const Value: Integer);
  public
    property EditMode: TInvoiceLineEditMode read FEditMode write FEditMode;

    property InvoiceLineId: Integer read FInvoiceLineId write FInvoiceLineId;
    property InvoiceId: Integer read FInvoiceId write FInvoiceId;
    property ProductId: Integer read FProductId;
    property Quantity: Integer read FQuantity write SetQuantity;
    procedure SetProduct(AProductId: Integer; AProductName: string;
      APrice: Currency);
  end;

var
  EditInvoiceLineForm: TEditInvoiceLineForm;

implementation

{$R *.dfm}

uses Goods;

procedure TEditInvoiceLineForm.edtProductRightButtonClick(Sender: TObject);
var
  xSelectForm: TGoodsForm;
begin
  if FEditMode = emInvoiceLineEdit then
    Exit;

  xSelectForm := TGoodsForm.Create(Self);
  try
    xSelectForm.Visible := False;
    if xSelectForm.ShowModal = mrOK then
    begin
      FProductId := xSelectForm.Goods.Product.PRODUCT_ID.Value;
      edtProduct.Text := xSelectForm.Goods.Product.NAME.Value;
      edtPrice.Text := xSelectForm.Goods.Product.PRICE.AsString;
    end;
  finally
    xSelectForm.Free;
  end;
end;

procedure TEditInvoiceLineForm.edtQuantityChange(Sender: TObject);
begin
  FQuantity := StrToIntDef(edtQuantity.Text, 0);
end;

procedure TEditInvoiceLineForm.FormCreate(Sender: TObject);
begin
  FProductId := 0;
  FQuantity := 0;
end;

procedure TEditInvoiceLineForm.SetProduct(AProductId: Integer;
  AProductName: string; APrice: Currency);
begin
  FProductId := AProductId;
  edtProduct.Text := AProductName;
  edtPrice.Text := CurrToStr(APrice);
end;

procedure TEditInvoiceLineForm.SetQuantity(const Value: Integer);
begin
  FQuantity := Value;
  edtQuantity.Text := IntToStr(FQuantity);
end;

end.
