unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OoMisc, AdPort, AdSelCom, StdCtrls, ExtCtrls, ComCtrls, uKalibr, IniFiles;

type
  TForm1 = class(TForm)
    Bat1: TCheckBox;
    Bat2: TCheckBox;
    K1: TCheckBox;
    K2: TCheckBox;
    K3: TCheckBox;
    K4: TCheckBox;
    K5: TCheckBox;
    RadioGroup1: TRadioGroup;
    ApdComPort1: TApdComPort;
    Button1: TButton;
    Shape1: TShape;
    Label1: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Button3: TButton;
    Label2: TLabel;
    Svet: TCheckBox;
    Timer1: TTimer;
    lCom: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure K1Click(Sender: TObject);
    procedure K2Click(Sender: TObject);
    procedure K3Click(Sender: TObject);
    procedure K4Click(Sender: TObject);
    procedure K5Click(Sender: TObject);
    procedure Bat1Click(Sender: TObject);
    procedure Bat2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApdComPort1TriggerAvail(CP: TObject; Count: Word);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SvetClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure lComDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  A,B: Byte;
  Adc_Val: Word;
  Cmd: Byte;
  vA,vB: Byte;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
     K1.Checked:=False;
     K2.Checked:=False;
     K3.Checked:=False;
     K4.Checked:=False;
     K5.Checked:=False;
     Bat1.Checked:=False;
     Bat2.Checked:=False;
     Svet.Checked:=False;
     RadioGroup1.ItemIndex:=0;
     A:=1; B:=0;
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.K1Click(Sender: TObject);
begin
     B:=B xor 1;  //Контроль заряда 2 Акб.
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.K2Click(Sender: TObject);
begin
     B:=B xor 2;  //Аварийная сигнализация давления масла в двигателе
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.K3Click(Sender: TObject);
begin
     B:=B xor 4;  //Аварийная сигнализация температуры охл. жидк.
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.K4Click(Sender: TObject);
begin
     B:=B xor 8;  //Аварийная сигнализация давления воздуха
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.K5Click(Sender: TObject);
begin
     B:=B xor 16;  //Сигнализация резервного уровня топлива
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.Bat1Click(Sender: TObject);
begin
     B:=B xor 32;   //1 Акк. Бат.
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.Bat2Click(Sender: TObject);
begin
     B:=B xor 64;   //Подсветка
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.SvetClick(Sender: TObject);
begin
     B:=B xor 128;   //Освещение
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
     A:=(1 shl RadioGroup1.ItemIndex);
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;
end;

procedure TForm1.FormCreate(Sender: TObject);
 var I:Integer;
     F: TIniFile;
begin
  F:=TIniFile.Create('.\KD8071.ini');
  I:= StrToInt(F.ReadString('ComPort','Com','1'));

  if IsPortAvailable(I)
    then begin
      ApdComPort1.ComNumber:=I;
      ApdComPort1.Open:=True
     end
    else begin
      ApdComPort1.ComNumber:=0;
      ApdComPort1.Open:=True;
      F.WriteInteger('ComPort','Com',ApdComPort1.ComNumber)
     end;
  lCom.Caption:='Com'+IntToStr(ApdComPort1.ComNumber);

  F.Free;

  A:=1; B:=0;
  ComboBox1.ItemIndex:=3;
  ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);

  Timer1.Enabled:=True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     Timer1.Enabled:=False;
     A:=1; B:=0;
     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
end;

var arB: array[0..8] of Byte;
    N,Nptr: Byte;
    Func: Byte;
    RxState:Byte;

procedure TForm1.ApdComPort1TriggerAvail(CP: TObject; Count: Word);
var
  I : Word;
  Ch: Char;
  R: Real;
begin
  for I := 1 to Count do begin
    Ch := ApdComPort1.GetChar;
    case RxState of
      0: if (Ch='@') then  RxState:=1;
      1: begin Func:=Ord(Ch); RxState:=2; end;
      2: begin N:=Ord(Ch); Nptr:=0; RxState:=3; end;
      3: begin
           arB[Nptr]:=Ord(Ch);
           Nptr:=Nptr+1;
           if (Nptr=N) then begin
              //********************************
             case Func of
                   0: begin
                        if ((arB[0] and 2)=0) then
                          begin
                            Shape1.Brush.Color:=clRed;
                          end
                        else
                          begin
                            Shape1.Brush.Color:=clGreen;
                          end;
                        Adc_Val:=256*arB[2]+arB[1];
                        R:=Adc_val/100;
                        Edit1.Text:=FloatToStrF(R,ffFixed,7,2);
                      end;
                   1: begin
                        if (arB[0] and 2)<>0 then Shape1.Brush.Color:=clRed
                                             else Shape1.Brush.Color:=clGreen;
                      end;
                else  begin
                      end;
             end;
              //********************************
            RxState:=0;
           end;
         end;
    end;

  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ApdComPort1.Output:='@'+ Chr(0)+Chr(0);
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
var S:String;
    V : Word;
    I:Integer;
begin
  S:= ComboBox1.Items[ComboBox1.ItemIndex];
  for I:=1 to Length(S) do
    if ((S[I]='.')or(S[I]=',')) then S[I]:=DecimalSeparator;
  V:=Round(StrToFloat(S)*100);
  vB:=Byte(V and $00FF);
  vA:=Byte(V shr 8);
//  ApdComPort1.Output:='@'+ Chr(2)+Chr(2)+Chr(A)+Chr(B);
  Cmd:=2;
end;

procedure TForm1.Button3Click(Sender: TObject);
var V : Word;
begin
  if Kalibr.ShowModal=mrOk then begin
      V:=KalibrVoltage;
      vB:=Byte(V and $00FF);
      vA:=Byte(V shr 8);
//      ApdComPort1.Output:='@'+ Chr(3)+Chr(2)+Chr(A)+Chr(B);
      Cmd:=3;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    case Cmd of
        0:    ApdComPort1.Output:='@'+ Chr(0)+Chr(0);
        1:    ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
        2:    ApdComPort1.Output:='@'+ Chr(2)+Chr(2)+Chr(vA)+Chr(vB);
        3:    ApdComPort1.Output:='@'+ Chr(3)+Chr(2)+Chr(vA)+Chr(vB);
    end;
    Cmd:=0;
end;

procedure TForm1.lComDblClick(Sender: TObject);
 var  F: TIniFile;
      ComSelDlg : TComSelectForm;
begin
  Timer1.Enabled:=False;
  ApdComPort1.Open:=False;
  ComSelDlg := TComSelectForm.Create(Application);
  if (ComSelDlg.ShowModal = mrOk)
     then begin
            ApdComPort1.ComNumber := ComSelDlg.SelectedComNum;
            F:=TIniFile.Create('.\KD8071.ini');
            F.WriteInteger('ComPort','Com',ApdComPort1.ComNumber);
            F.Free;
          end;
  ComSelDlg.Free;

  ApdComPort1.Open:=True;
  lCom.Caption:='Com'+IntToStr(ApdComPort1.ComNumber);

     K1.Checked:=False;
     K2.Checked:=False;
     K3.Checked:=False;
     K4.Checked:=False;
     K5.Checked:=False;
     Bat1.Checked:=False;
     Bat2.Checked:=False;
     Svet.Checked:=False;
     RadioGroup1.ItemIndex:=0;
     A:=1; B:=0;
//     ApdComPort1.Output:='@'+ Chr(1)+Chr(2)+Chr(A)+Chr(B);
     Cmd:=1;

  Timer1.Enabled:=True;
end;

end.

