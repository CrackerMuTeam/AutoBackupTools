unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB,ShellApi, ExtCtrls, Menus, StdCtrls,dec, Mask,registry,inifiles,
  DB;

type
  Ttempo = record
    hora : string;
    ocorreu : boolean
  end;
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    CMTAutoBackup1: TMenuItem;
    Configurar1: TMenuItem;
    FazerBackupAgora1: TMenuItem;
    SalvarLog1: TMenuItem;
    Fechar1: TMenuItem;
    Sobre1: TMenuItem;
    Creditos1: TMenuItem;
    Panel1: TPanel;
    Timer1: TTimer;
    ADOCommand1: TADOCommand;
    Label1: TLabel;
    Memo1: TMemo;
    Recarregar1: TMenuItem;
    empodeBackup1: TMenuItem;
    ConfiguraesdoPrograma1: TMenuItem;
    ApagarLog1: TMenuItem;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    MostrarPrograma1: TMenuItem;
    a1: TMenuItem;
    Fechar2: TMenuItem;
    Fechar3: TMenuItem;
    EsconderPrograma1: TMenuItem;
    ADOQuery1: TADOQuery;
    ComboBox1: TComboBox;
    SaveDialog1: TSaveDialog;
    procedure iniciar;
    procedure fazerbackup;
    procedure Timer1Timer(Sender: TObject);
    procedure recarregar;
    procedure ApagarLog1Click(Sender: TObject);
    procedure empodeBackup1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure proximahora;
    procedure MostrarPrograma1Click(Sender: TObject);
    procedure Fechar3Click(Sender: TObject);
    procedure FazerBackupAgora1Click(Sender: TObject);
    procedure ConfiguraesdoPrograma1Click(Sender: TObject);
    procedure configprocedure;
    procedure Configurar1Click(Sender: TObject);
    procedure SalvarLog1Click(Sender: TObject);
    procedure Creditos1Click(Sender: TObject);
  private
    protected procedure WndProc(var Msg: TMessage); override;
  public
    TrayIconData: TNotifyIconData;
  end;

var
  Form1: TForm1;
  tempo: array[0..255] of Ttempo;
  programhide:boolean=false;
  icone: boolean=false;
  programname:string;
const WM_ICONTRAY = WM_USER + 1;
implementation

uses ConfigForm, Unit3;

{$R *.dfm}

procedure tform1.configprocedure;
begin
  form1.Enabled:=false;
  cfgform.iniciar;
  configtype:='meio';
  cfgform.Button4.Visible:=false;
  cfgform.show;
end;

procedure TForm1.WndProc(var Msg: TMessage);
var
p: TPoint;
begin
  case Msg.Msg of
    WM_USER + 1: case Msg.lParam of
                   WM_RBUTTONDOWN: begin
                     SetForegroundWindow(Handle);
                     GetCursorPos(p);
                     PopupMenu1.Popup(p.x,p.y);
                     PostMessage(Handle, WM_NULL, 0, 0);
                   end;
                   WM_LBUTTONDBLCLK: begin
                     mostrarprograma1.Click;
                   end;
                 end;
  end;
  inherited;
end;


procedure tform1.proximahora;
var i:integer;
s:string;
s2:integer;
a: integer	;
g:array[0..255] of integer;
menorvalor: integer	;
indextempo:integer;
begin
  s:=timetostr(time);
  s2:=strtoint(s[1]+s[2]+s[4]+s[5]+s[7]+s[8]);
  for i:=0 to 255 do
    if tempo[i].hora<>'' then begin
      a:=strtoint(tempo[i].hora[1]+tempo[i].hora[2]+tempo[i].hora[4]+tempo[i].hora[5]+tempo[i].hora[7]+tempo[i].hora[8]);
      g[i]:=a-s2;
    end;
  indextempo:=257;
  menorvalor:=999999;
  for i:=0 to 255 do
    if tempo[i].hora<>'' then begin
      if (g[i]<menorvalor) and (g[i]>0) then begin
        menorvalor:=g[i];
        indextempo:=i;
      end;
    end;
  if indextempo<>257 then begin
    label1.Caption:=nextbackup+' '+tempo[indextempo].hora;
    label2.Caption:=countdown+' '+timetostr(strtotime(tempo[indextempo].hora)-time);
  end else begin
    for i:=0 to 255 do
      if tempo[i].hora<>'' then begin
        if (g[i]<menorvalor)  then begin
          menorvalor:=g[i];
          indextempo:=i;
        end;
      end;
    label1.Caption:=nextbackup+' '+tempo[indextempo].hora;
    label2.Caption:=countdown+' '+timetostr(1+strtotime(tempo[indextempo].hora)-time);
   // label1.Caption:=timetostr(time);
  end;


end;


procedure tform1.recarregar;
var i:integer;
    total:real;
    filename : string;
  f : textfile;
  ch : char;
  esc: boolean;
  g:string;

begin
  if fileexists('TimeConfig.txt') then   begin
    filename:=ExtractFilePath(Application.ExeName)+'TimeConfig.txt';
    assignfile(F,filename);
    reset(F);
    i:=0;
    while not eof(F) do  begin
      read(F,ch);
      Case ch of
        '"'  :  begin
                  if esc=false then esc:=true
                    else begin
                      esc:=false;
                      inc(i);
                      tempo[i].hora:=g;
                      g:='';
                    end;
                  end;
           else begin
                  if esc=true then g:=g+ch;
                end;
      end;
    end;
    closefile(F);
  end
    else begin
      tempo[0].hora:='00:00:00';
      tempo[1].hora:='01:00:00';
      tempo[2].hora:='02:00:00';
      tempo[3].hora:='03:00:00';
      tempo[4].hora:='04:00:00';
      tempo[5].hora:='05:00:00';
      tempo[6].hora:='06:00:00';
      tempo[7].hora:='07:00:00';
      tempo[8].hora:='08:00:00';
      tempo[9].hora:='09:00:00';
      tempo[10].hora:='10:00:00';
      tempo[11].hora:='11:00:00';
      tempo[12].hora:='12:00:00';
      tempo[13].hora:='13:00:00';
      tempo[14].hora:='14:00:00';
      tempo[15].hora:='15:00:00';
      tempo[16].hora:='16:00:00';
      tempo[17].hora:='17:00:00';
      tempo[18].hora:='18:00:00';
      tempo[19].hora:='19:00:00';
      tempo[20].hora:='20:00:00';
      tempo[21].hora:='21:00:00';
      tempo[22].hora:='22:00:00';
      tempo[23].hora:='23:00:00';
    end;
  for i:=0 to 255 do
    if tempo[i].hora<>'' then begin
      total:= StrToTime(tempo[i].hora)-time;
      if total<=0  then tempo[i].ocorreu:=true
        else  tempo[i].ocorreu:=false;
    end
     else tempo[i].ocorreu:=false;
  for i:=0 to 255 do
    if tempo[i].hora<>'' then begin
      memo1.lines.add('['+datetimetostr(now)+'] '+BackupTimeLoaded+' '+tempo[i].hora)
    end;
end;

procedure tform1.fazerbackup;
var nome,fileformat1,hourformat1,dateformat1,lineadd:string;
begin
  memo1.Lines.add('');
  if database1name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database1name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database1name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database1name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database1name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database1name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;
    if database2name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database2name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database2name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database2name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database2name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database2name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;
  if database3name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database3name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database3name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database3name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database3name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database3name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;
  if database4name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database4name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database4name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database4name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database4name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database4name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;
  if database5name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database5name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database5name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database5name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database5name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database5name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;
  if database6name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database6name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database6name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database6name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database6name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database6name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;
  if database7name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database7name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database7name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database7name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database7name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database7name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;
  if database8name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database8name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database8name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database8name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database8name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database8name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;
  if database9name<>'' then begin
    hourformat1:=FormatDateTime(hourformat,Now);
    dateformat1:=FormatDateTime(dateformat,Now);
    fileformat1:=stringreplace(fileformat,'D',dateformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'H',hourformat1,[rfReplaceAll]);
    fileformat1:=stringreplace(fileformat1,'B',database9name,[rfReplaceAll]);
    nome:=fileformat1;
    adocommand1.CommandText:='BACKUP DATABASE ['+database9name+'] TO DISK = '''+folder+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database9name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
    adocommand1.Execute;
    lineadd:= stringreplace(BackupSuccess,'%',folder+'\'+nome+'.bak',[rfReplaceAll]);
    memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    if folder2<>'' then begin
      adocommand1.CommandText:='BACKUP DATABASE ['+database9name+'] TO DISK = '''+folder2+'\'+nome+'.bak'' WITH NOFORMAT, NOINIT, NAME = N'''+database9name+''', SKIP, NOREWIND, NOUNLOAD, STATS = 10';
      adocommand1.Execute;
      lineadd:= stringreplace(BackupSuccess,'%',folder2+'\'+nome+'.bak',[rfReplaceAll]);
      memo1.Lines.add('['+datetimetostr(now)+'] '+lineadd);
    end;
  end;

end;

procedure Tform1.iniciar;
var i:byte;
caption,cap2:string;
begin
  caption:='AHsY69OoJu9Gzy9Si.V97KÇç';
  for I := 0 to length(caption) do
    begin
      if caption[i]='A' then cap2:=cap2+'CM';
      if caption[i]='H' then cap2:=cap2+'T ';
      if caption[i]='s' then cap2:=cap2+'A';
      if caption[i]='Y' then cap2:=cap2+'u';
      if caption[i]='6' then cap2:=cap2+'to';
      if caption[i]='9' then cap2:=cap2+' ';
      if caption[i]='O' then cap2:=cap2+'B';
      if caption[i]='o' then cap2:=cap2+'a';
      if caption[i]='J' then cap2:=cap2+'ck';
      if caption[i]='u' then cap2:=cap2+'up';
      if caption[i]='G' then cap2:=cap2+'T';
      if caption[i]='z' then cap2:=cap2+'oo';
      if caption[i]='y' then cap2:=cap2+'ls';
      if caption[i]='7' then cap2:=cap2+'by ';
      if caption[i]='K' then cap2:=cap2+'U';
      if caption[i]='Ç' then cap2:=cap2+'nn';
      if caption[i]='ç' then cap2:=cap2+'eon';
      if caption[i]='i' then cap2:=cap2+'1.';
      if caption[i]='.' then cap2:=cap2+'0';
      if caption[i]='S' then cap2:=cap2+'[';
      if caption[i]='V' then cap2:=cap2+']';
    end;
  form1.caption:=cap2;
  cap2:='';
  caption:='MuONlineT0oLs';
  for I := 0 to length(caption) do
    begin
      if caption[i]='M' then cap2:=cap2+'A';
      if caption[i]='u' then cap2:=cap2+'u';
      if caption[i]='O' then cap2:=cap2+'to';
      if caption[i]='N' then cap2:=cap2+' ';
      if caption[i]='l' then cap2:=cap2+'B';
      if caption[i]='i' then cap2:=cap2+'a';
      if caption[i]='n' then cap2:=cap2+'ck';
      if caption[i]='e' then cap2:=cap2+'u';
      if caption[i]='T' then cap2:=cap2+'p ';
      if caption[i]='0' then cap2:=cap2+'T';
      if caption[i]='o' then cap2:=cap2+'o';
      if caption[i]='L' then cap2:=cap2+'ol';
      if caption[i]='s' then cap2:=cap2+'s';
    end;
  form3.label1.caption:=cap2;
  programname:=cap2;

  caption:='1A2B3C4D55E6F';
  cap2:='';
  for I := 0 to length(caption) do
    begin
      if caption[i]='1' then cap2:=cap2+'P';
      if caption[i]='A' then cap2:=cap2+'r';
      if caption[i]='2' then cap2:=cap2+'og';
      if caption[i]='B' then cap2:=cap2+'ra';
      if caption[i]='3' then cap2:=cap2+'m';
      if caption[i]='C' then cap2:=cap2+' ';
      if caption[i]='4' then cap2:=cap2+'by ';
      if caption[i]='D' then cap2:=cap2+'U';
      if caption[i]='5' then cap2:=cap2+'n';
      if caption[i]='E' then cap2:=cap2+'e';
      if caption[i]='6' then cap2:=cap2+'on';
    end;
  form3.label3.caption:=cap2;
  caption:='A1B2C3D43E5F6ax';
  cap2:='';
  for I := 0 to length(caption) do
    begin
      if caption[i]='A' then cap2:=cap2+'L';
      if caption[i]='1' then cap2:=cap2+'oa';
      if caption[i]='B' then cap2:=cap2+'d';
      if caption[i]='2' then cap2:=cap2+'i';
      if caption[i]='C' then cap2:=cap2+'ng';
      if caption[i]='3' then cap2:=cap2+' ';
      if caption[i]='D' then cap2:=cap2+'b';
      if caption[i]='4' then cap2:=cap2+'y';
      if caption[i]='E' then cap2:=cap2+'S';
      if caption[i]='5' then cap2:=cap2+'tr';
      if caption[i]='F' then cap2:=cap2+'i';
      if caption[i]='6' then cap2:=cap2+'k';
      if caption[i]='a' then cap2:=cap2+'er';
    end;
  form3.label5.caption:=cap2;

  if icone = false then begin
    Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
    with TrayIconData do  begin
      cbSize := Sizeof(TrayIconData);
      Wnd := Handle;
      uID := 0;
      uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
      uCallbackMessage := WM_ICONTRAY;
      hIcon := Application.Icon.Handle;
      StrPCopy(SzTip, Application.Title);
    end;
    Shell_NotifyIcon(NIM_ADD, @TrayIconData);
  end;

  adocommand1.ConnectionString:='Provider=MSDASQL.1;Password='+masterpwd+';Persist Security Info=True;User ID='+masterid+';Data Source='+masterdsn+';Initial Catalog='+mastercatalog;
  timer1.enabled:=true;
  recarregar;
  proximahora;
  {lang}
  CMTAutoBackup1.Caption:=ProgramFile;
  FazerBackupAgora1.Caption:=DoBackupNow;
  esconderprograma1.Caption:=HideProgram;
  SalvarLog1.caption:=savelog;
  ApagarLog1.Caption:=clearlog;
  Configurar1.caption:=Config;
  Fechar1.Caption:=Closetext;

  Recarregar1.caption:=reload;
  empodeBackup1.caption:=BackupTime;
  ConfiguraesdoPrograma1.caption:=ProgramConfig;
  Sobre1.caption:=Abouttext;
  Creditos1.caption:=Creditstext;

  MostrarPrograma1.Caption:=HideProgram;
  a1.Caption:=DoBackupNow;
  Fechar3.Caption:=Closetext;

  form3.Label4.Caption:=translate;
  form3.Label2.Caption:=OtherFiles;
  form3.Caption:=creditstext;
  {lang end}
end;

function To2Char(s:string):string ;
begin
  if length(s)=1 then s:='0'+s;
  result:=s;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i:byte;
s:string;
begin
  s:=timetostr(time);
  proximahora;
  for i:=0 to 255 do
    if (s=tempo[i].hora) and (tempo[i].ocorreu=false) then
      begin
        fazerbackup;
        tempo[i].ocorreu:=true;
      end;
  if s='00:00:00' then begin
      memo1.lines.add('');
    recarregar;
  end;
end;

procedure TForm1.ApagarLog1Click(Sender: TObject);
begin
  if application.MessageBox(Pchar(Question13),pchar(programname),mb_yesno+mb_iconwarning)=idno then exit;
  memo1.Lines.clear;
end;

procedure TForm1.empodeBackup1Click(Sender: TObject);
begin
  memo1.lines.add('');
  recarregar;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
  application.Terminate;
end;

procedure TForm1.MostrarPrograma1Click(Sender: TObject);
begin
  if programhide=false then begin
    programhide:=true;
    form1.Hide;
    mostrarprograma1.Caption:=showprogram;
    esconderprograma1.caption:=showprogram;
  end else
    begin
      form1.show;
      programhide:=false;
      mostrarprograma1.Caption:=hideprogram;
      esconderprograma1.caption:=hideprogram;
    end;
end;

procedure TForm1.Fechar3Click(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
  application.Terminate;
end;

procedure TForm1.FazerBackupAgora1Click(Sender: TObject);
begin
  fazerbackup;
end;

procedure TForm1.ConfiguraesdoPrograma1Click(Sender: TObject);
var
  filename : string;
  f : textfile;
  ch : char;
  esc: boolean;
  s:array[1..38] of string;
  g:string;
  i:integer;
  Reg: tRegistry;
  bDriversValue, bSQLKey: boolean;
  configgo:boolean;
  bsql2:array[1..9] of boolean;
  dsnini:tinifile;
  inicreate: Tstream;
begin
  if fileexists('CMTAutoBakCfg.ini') then begin
    dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTAutoBakCfg.ini');
    if (dsnini.ReadString('CMTBackupDB','Folder','')<>'') and (dsnini.ReadString('CMTBackupDB','FileFormat','')<>'') and (dsnini.Readstring('CMTBackupDB','HourFormat','')<>'') and (dsnini.ReadString('CMTBackupDB','DateFormat','')<>'')  then begin
      Folder:=dsnini.ReadString('CMTBackupDB','Folder','');
      Folder2:=dsnini.ReadString('CMTBackupDB','Folder2','');
      FileFormat:=dsnini.ReadString('CMTBackupDB','FileFormat','');
      HourFormat:=dsnini.ReadString('CMTBackupDB','HourFormat','');
      DateFormat:=dsnini.ReadString('CMTBackupDB','DateFormat','');
      Database1Name:=dsnini.ReadString('CMTBackupDB','Database1Name','');
      Database2Name:=dsnini.ReadString('CMTBackupDB','Database2Name','');
      Database3Name:=dsnini.ReadString('CMTBackupDB','Database3Name','');
      Database4Name:=dsnini.ReadString('CMTBackupDB','Database4Name','');
      Database5Name:=dsnini.Readstring('CMTBackupDB','Database5Name','') ;
      Database6Name:=dsnini.ReadString('CMTBackupDB','Database6Name','');
      Database7Name:=dsnini.ReadString('CMTBackupDB','Database7Name','');
      Database8Name:=dsnini.ReadString('CMTBackupDB','Database8Name','');
      Database9Name:=dsnini.ReadString('CMTBackupDB','Database9Name','');
      masterdsn:=dsnini.ReadString('CMTconnectDNS','DSN','');
      masterid:=dsnini.ReadString('CMTconnectDNS','User','');
      masterpwd:=dsnini.ReadString('CMTconnectDNS','Password','');
      mastercatalog:=dsnini.ReadString('CMTconnectDNS','DB','');
      dsnini.Free;
    end
      else configgo:=true;
  end
    else begin
      configgo:=true;
    end;
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey(  '\Software\ODBC\ODBC.INI\ODBC Data Sources', false );
    bDriversValue := Reg.ValueExists( masterdsn );
    Reg.CloseKey;
    Reg.Free;
    if ( bDriversValue=false) then begin
      configprocedure;
      application.MessageBox(pchar(Error27),pchar(ErrorCaption),mb_ok+mb_iconwarning);
      exit;
    end;
    adoquery1.ConnectionString:='Provider=MSDASQL.1;Password='+masterpwd+';Persist Security Info=True;User ID='+masterid+';Data Source='+masterdsn+'';
    combobox1.Items.clear;
    adoquery1.Close;
    adoquery1.SQL.add('SELECT CATALOG_NAME as ''Database'''+
                      'FROM INFORMATION_SCHEMA.SCHEMATA');
    adoquery1.Open;
    for i := 0 to adoquery1.recordcount-1 do begin
      combobox1.Items.add(adoquery1.Fields[0].AsString);
      adoquery1.Next;
    end;
    adoquery1.close;
    bsqlkey:=false;
    if database1name<>'' then  bsql2[1]:=false else bsql2[1]:=true;
    if database2name<>'' then  bsql2[2]:=false else bsql2[2]:=true;
    if database3name<>'' then  bsql2[3]:=false else bsql2[3]:=true;
    if database4name<>'' then  bsql2[4]:=false else bsql2[4]:=true;
    if database5name<>'' then  bsql2[5]:=false else bsql2[5]:=true;
    if database6name<>'' then  bsql2[6]:=false else bsql2[6]:=true;
    if database7name<>'' then  bsql2[7]:=false else bsql2[7]:=true;
    if database8name<>'' then  bsql2[8]:=false else bsql2[8]:=true;
    if database9name<>'' then  bsql2[9]:=false else bsql2[9]:=true;

    for I := 0 to combobox1.Items.Count-1 do begin
      if Uppercase(combobox1.Items[i])=Uppercase(mastercatalog) then bsqlkey:=true;
      if database1name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database1name) then bsql2[1]:=true;
      if database2name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database2name) then bsql2[2]:=true;
      if database3name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database3name) then bsql2[3]:=true;
      if database4name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database4name) then bsql2[4]:=true;
      if database5name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database5name) then bsql2[5]:=true;
      if database6name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database6name) then bsql2[6]:=true;
      if database7name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database7name) then bsql2[7]:=true;
      if database8name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database8name) then bsql2[8]:=true;
      if database9name<>'' then if Uppercase(combobox1.Items[i])=Uppercase(database9name) then bsql2[9]:=true;
    end;
    if bsql2[1]=false then database1name:='';
    if bsql2[2]=false then database2name:='';
    if bsql2[3]=false then database3name:='';
    if bsql2[4]=false then database4name:='';
    if bsql2[5]=false then database5name:='';
    if bsql2[6]=false then database6name:='';
    if bsql2[7]=false then database7name:='';
    if bsql2[8]=false then database8name:='';
    if bsql2[9]=false then database9name:='';
    if bsqlkey=false then begin
      configprocedure;
      application.MessageBox(pchar(Error27),pchar(ErrorCaption),mb_ok+mb_iconwarning);
      exit;
    end;
  except
    configprocedure;
    application.MessageBox(pchar(Error27),pchar(ErrorCaption),mb_ok+mb_iconwarning);
    Exit;
  end;
  if Configgo=true then begin
    inicreate := TFileStream.Create('CMTAutoBakCfg.ini', fmCreate or fmShareDenyRead);
    inicreate.Free;
    configprocedure;
    application.MessageBox(pchar(error30),pchar(errorcaption),mb_ok+mb_iconerror);
    Exit;
  end;
end;

procedure TForm1.Configurar1Click(Sender: TObject);
begin
  configprocedure;
end;

procedure TForm1.SalvarLog1Click(Sender: TObject);
var Arquivo : TextFile;
i:integer;
begin
  If (SaveDialog1.Execute) and (Savedialog1.FileName<>'') then begin
    if fileexists(Savedialog1.FileName) then DeleteFile(Pchar(SaveDialog1.FileName));
    AssignFile(Arquivo, Savedialog1.FileName);
    Rewrite(Arquivo);
    Try
      for i:=0 to memo1.Lines.Count-1 do
        Write(Arquivo, PChar(memo1.Lines[i] + Chr(13) + Chr(10)) );
    Finally CloseFile(Arquivo);
    application.MessageBox(pchar(confirm7),pchar(programname),mb_ok);
    end;
  end;
end;

procedure TForm1.Creditos1Click(Sender: TObject);
begin
  form3.showmodal;
end;

end.
