unit uKalibr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TKalibr = class(TForm)
    Edit1: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Kalibr: TKalibr;
  KalibrVoltage: Word;

implementation

{$R *.DFM}

procedure TKalibr.btnOKClick(Sender: TObject);
var S:ShortString;
    I:Integer;
begin
  S:=Edit1.Text;
  for I:=1 to Length(S) do
    if ((S[I]='.')or(S[I]=',')) then S[I]:=DecimalSeparator;
  KalibrVoltage:=Round(StrToFloat(S)*100);
  ModalResult:=mrOk;
end;

end.
