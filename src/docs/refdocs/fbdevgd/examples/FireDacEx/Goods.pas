unit Goods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  dGoods;

type
  TGoodsForm = class(TForm)
    ToolBar1: TToolBar;
    Splitter1: TSplitter;
    mmDescription: TDBMemo;
    ActionList: TActionList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    actAddRecord: TAction;
    actEditRecord: TAction;
    actDeleteRecord: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    actExit: TAction;
    actRefresh: TAction;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    DBGrid: TDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure actAddRecordExecute(Sender: TObject);
    procedure actEditRecordExecute(Sender: TObject);
    procedure actDeleteRecordExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FGoods: TdmGoods;
    procedure GoodsEditorClose(Sender: TObject; var Action: TCloseAction);
  public
    property Goods: TdmGoods read FGoods;
  end;

var
  GoodsForm: TGoodsForm;

implementation

{$R *.dfm}

uses GoodsEditor;

procedure TGoodsForm.actAddRecordExecute(Sender: TObject);
var
  xEditorForm: TEditGoodsForm;
begin
  xEditorForm := TEditGoodsForm.Create(Self);
  try
    xEditorForm.OnClose := GoodsEditorClose;
    xEditorForm.DataSource := Goods.DataSource;
    xEditorForm.Caption := 'Add item';
    Goods.Add;
    xEditorForm.ShowModal;
  finally
    xEditorForm.Free;
  end;
end;

procedure TGoodsForm.actDeleteRecordExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to delete the item?',
                mtConfirmation,
                [mbYes, mbNo],
                0) = mrYes then
  begin
    try
      Goods.Delete;
      Goods.Save;
    except
      on E: Exception do
        Application.ShowException(E);
    end;
  end;
end;

procedure TGoodsForm.actEditRecordExecute(Sender: TObject);
var
  xEditorForm: TEditGoodsForm;
begin
  xEditorForm := TEditGoodsForm.Create(Self);
  try
    xEditorForm.OnClose := GoodsEditorClose;
    xEditorForm.DataSource := Goods.DataSource;
    xEditorForm.Caption := 'Edit item';
    Goods.Edit;
    xEditorForm.ShowModal;
  finally
    xEditorForm.Free;
  end;
end;

procedure TGoodsForm.actExitExecute(Sender: TObject);
begin
  Goods.Close;
  Close;
end;

procedure TGoodsForm.actRefreshExecute(Sender: TObject);
begin
  Goods.Refresh;
end;

procedure TGoodsForm.DBGridDblClick(Sender: TObject);
begin
  if fsModal in FormState then
  begin
    ModalResult := mrOK;
    CloseModal;
  end
  else begin
    actEditRecordExecute(Self);
  end;
end;

procedure TGoodsForm.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
  begin
    DBGridDblClick(Sender);
  end;
end;

procedure TGoodsForm.FormActivate(Sender: TObject);
begin
  Goods.Open;
end;

procedure TGoodsForm.FormCreate(Sender: TObject);
begin
  FGoods := TDMGoods.Create(Self);
  DBGrid.DataSource := FGoods.DataSource;
  mmDescription.DataSource := FGoods.DataSource;
end;

procedure TGoodsForm.GoodsEditorClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if TEditGoodsForm(Sender).ModalResult <> mrOK then
  begin
    Goods.Cancel;
    Action := caFree;
    Exit;
  end;

  try
    Goods.Post;
    Goods.Save;

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
