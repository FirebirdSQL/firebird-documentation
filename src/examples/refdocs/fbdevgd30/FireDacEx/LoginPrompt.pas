unit LoginPrompt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TLoginPromptForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtUser: TLabeledEdit;
    edtPassword: TLabeledEdit;
  private
    function GetPassword: string;
    function GetUserName: string;
    procedure SetUserName(const Value: string);
    { Private declarations }
  public
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword;
  end;

var
  LoginPromptForm: TLoginPromptForm;

implementation

{$R *.dfm}

{ TLoginPromptForm }

function TLoginPromptForm.GetPassword: string;
begin
  Result := edtPassword.Text;
end;

function TLoginPromptForm.GetUserName: string;
begin
  Result := edtUser.Text;
end;

procedure TLoginPromptForm.SetUserName(const Value: string);
begin
  edtUser.Text := Value;
end;

end.
