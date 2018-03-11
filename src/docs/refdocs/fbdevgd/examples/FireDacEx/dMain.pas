unit dMain;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Comp.Client, Data.DB, System.IniFiles, Data.SqlTimSt,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.ImgList,
  Vcl.Controls, System.Generics.Collections, FireDAC.VCLUI.Login;

type
  TdmMain = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    ImageList: TImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDateChangeHandlers: System.Generics.Collections.TList<TNotifyEvent>;
    FBeginDate: TDateTime;
    FEndDate: TDateTime;
    function GetBeginDateSt: TSQLTimeStamp;
    function GetEndDateSt: TSQLTimeStamp;
    procedure SetBeginDate(const Value: TDateTime);
    procedure SetEndDate(const Value: TDateTime);
  public
    procedure AddDateChangeHandler(AEventHandler: TNotifyEvent);
    procedure RemoveDateChangeHandler(AEventHandler: TNotifyEvent);
    procedure DateChangeNotify;

    property BeginDate: TDateTime read FBeginDate write SetBeginDate;
    property EndDate: TDateTime read FEndDate write SetEndDate;
    property BeginDateSt: TSQLTimeStamp read GetBeginDateSt;
    property EndDateSt: TSQLTimeStamp read GetEndDateSt;
  end;

var
  dmMain: TdmMain;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses LoginPrompt;

const
  MAX_LOGIN_COUNT = 3;

{$R *.dfm}

procedure TdmMain.AddDateChangeHandler(AEventHandler: TNotifyEvent);
begin
  FDateChangeHandlers.Add(AEventHandler);
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
var
  xIniFile: TIniFile;
  xAppPath: string;
  xDate: TDateTime;
  xLoginPromptDlg: TLoginPromptForm;
  xLoginCount: Integer;
begin
  FDateChangeHandlers := System.Generics.Collections.TList<TNotifyEvent>.Create;

  // In real systems is usually calculated from the current date
  // xDate := Now;
  xDate := EncodeDate(2015, 10, 1);

  // By default, display data for the last 90 days
  FBeginDate := Int(xDate) - 75;
  FEndDate := Int(xDate) + 15 + EncodeTime(23, 59, 59, 999);

  // specify the path to the client library
  xAppPath := ExtractFileDir(Application.ExeName) + PathDelim;
  FDPhysFBDriverLink.VendorLib := xAppPath + 'fbclient' + PathDelim +
    'fbclient.dll';

  // Read the connection settings
  // note: In fact, the general settings must be in the AppData folder
  // and filled in during installation
  xIniFile := TIniFile.Create(xAppPath + 'config.ini');
  try
    xIniFile.ReadSectionValues('connection', FDConnection.Params);
  finally
    xIniFile.Free;
  end;

  // We make up to 3 attempts to log in and then closes the application
  xLoginCount := 0;
  xLoginPromptDlg := TLoginPromptForm.Create(Self);
  while (xLoginCount < MAX_LOGIN_COUNT) and (not FDConnection.Connected) do
  begin
    try
      if xLoginPromptDlg.ShowModal = mrOK then
        FDConnection.Open(xLoginPromptDlg.UserName, xLoginPromptDlg.Password)
      else
        xLoginCount := MAX_LOGIN_COUNT;
    except
      on E: Exception do
      begin
        Inc(xLoginCount);
        Application.ShowException(E);
      end
    end;
  end;
  xLoginPromptDlg.Free;

  if not FDConnection.Connected then
    Halt;

end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  FDateChangeHandlers.Free;
  FDateChangeHandlers := nil;

  FDConnection.Close();
end;

procedure TdmMain.DateChangeNotify;
var
  i: Integer;
begin
  for i := 0 to FDateChangeHandlers.Count - 1 do
  begin
    FDateChangeHandlers[i](Self);
  end;
end;

function TdmMain.GetBeginDateSt: TSQLTimeStamp;
begin
  Result := DateTimeToSQLTimeStamp(FBeginDate);
end;

function TdmMain.GetEndDateSt: TSQLTimeStamp;
begin
  Result := DateTimeToSQLTimeStamp(FEndDate);
end;

procedure TdmMain.RemoveDateChangeHandler(AEventHandler: TNotifyEvent);
begin
  FDateChangeHandlers.Remove(AEventHandler);
end;

procedure TdmMain.SetBeginDate(const Value: TDateTime);
begin
  FBeginDate := Int(Value);
end;

procedure TdmMain.SetEndDate(const Value: TDateTime);
begin
  FEndDate := Int(Value) + EncodeTime(23, 59, 59, 999);
end;

end.
