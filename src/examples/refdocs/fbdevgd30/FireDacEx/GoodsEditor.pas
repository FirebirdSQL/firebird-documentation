unit GoodsEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Data.DB,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.ExtCtrls;

type

  TEditGoodsForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
  public
    property DataSource: TDataSource read FDataSource write SetDataSource;
  end;

var
  EditGoodsForm: TEditGoodsForm;

implementation

{$R *.dfm}

{ TEditGoodsForm }

procedure TEditGoodsForm.FormCreate(Sender: TObject);
begin
  DBEdit1.DataField := 'NAME';
  DBEdit2.DataField := 'PRICE';
  DBMemo1.DataField := 'DESCRIPTION';
end;

procedure TEditGoodsForm.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;

  DBEdit1.DataSource := FDataSource;
  DBEdit2.DataSource := FDataSource;
  DBMemo1.DataSource := FDataSource;
end;

end.
