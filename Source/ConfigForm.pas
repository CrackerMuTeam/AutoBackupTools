unit ConfigForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,dec,inifiles, ExtCtrls, DB, ADODB, registry, Spin,
  RzShellDialogs;

type
  TCfgForm = class(TForm)
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    Button4: TButton;
    Button5: TButton;
    ADOQuery1: TADOQuery;
    Image1: TImage;
    Button6: TButton;
    Label19: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Edit3: TEdit;
    Edit7: TEdit;
    Label20: TLabel;
    Button1: TButton;
    Label5: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit8: TEdit;
    Label8: TLabel;
    Edit9: TEdit;
    Label9: TLabel;
    Edit10: TEdit;
    Label10: TLabel;
    Edit11: TEdit;
    Label11: TLabel;
    Edit12: TEdit;
    Label12: TLabel;
    Edit13: TEdit;
    Label13: TLabel;
    GroupBox4: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Edit14: TEdit;
    Button3: TButton;
    Edit15: TEdit;
    Edit16: TEdit;
    ComboBox1: TComboBox;
    Button7: TButton;
    Edit17: TEdit;
    Button8: TButton;
    Label3: TLabel;
    rzFolderDialog1: TRzSelectFolderDialog;
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);

    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure iniciar;
    procedure Button7Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CfgForm: TCfgForm;
 bmps:tbitmap;
implementation

uses FlashForm,unit1;

{$R *.dfm}

function To2Char(s:string):string ;
begin
  if length(s)=1 then s:='0'+s;
  result:=s;
end;

procedure TCfgForm.Button1Click(Sender: TObject);
var dsnini:tinifile;
begin
  dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTAutoBakCfg.ini');
  dsnini.writeString('CMTBackupDB','Database1Name',edit4.text);
  dsnini.writeString('CMTBackupDB','Database2Name',edit9.text) ;
  dsnini.writeString('CMTBackupDB','Database3Name',edit5.text);
  dsnini.writeString('CMTBackupDB','Database4Name',edit10.text);
  dsnini.writeString('CMTBackupDB','Database5Name',edit6.text);
  dsnini.writeString('CMTBackupDB','Database6Name',edit11.text);
  dsnini.writeString('CMTBackupDB','Database7Name',edit8.text);
  dsnini.writeString('CMTBackupDB','Database8Name',edit13.text);
  dsnini.writeString('CMTBackupDB','Database9Name',edit12.text);
  dsnini.Free;
end;

procedure TCfgForm.Button3Click(Sender: TObject);
 var i:integer;
  reg:tregistry;
  bDriversValue: boolean;
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey(  '\Software\ODBC\ODBC.INI\ODBC Data Sources', false );
    bDriversValue := Reg.ValueExists( edit14.Text );
    Reg.CloseKey;
    Reg.Free;
    if ( bDriversValue=false)  then begin
      application.MessageBox(pchar(Error28),pchar(ErrorCaption),mb_ok+mb_iconerror);
      exit;
    end;
  except
    application.MessageBox(pchar(Error28),pchar(ErrorCaption),mb_ok+mb_iconerror);
    Exit;
  end;
  adoquery1.ConnectionString:='Provider=MSDASQL.1;Password='+edit16.text+';Persist Security Info=True;User ID='+edit15.text+';Data Source='+edit14.text+'';{;Initial Catalog='+catalog;  }
  combobox1.Items.clear;
  adoquery1.Close;
  adoquery1.SQL.add('SELECT CATALOG_NAME as ''Database'''+
                    'FROM INFORMATION_SCHEMA.SCHEMATA');
  adoquery1.Open;
  for i := 0 to adoquery1.recordcount-1 do begin
    combobox1.Items.addobject(adoquery1.Fields[0].AsString,bmps);
    adoquery1.Next;
  end;
  adoquery1.close;
  combobox1.Enabled:=true;
  for I := 0 to combobox1.Items.Count-1 do
      if Uppercase(combobox1.Items[i])=Uppercase(mastercatalog) then combobox1.Itemindex:=i;
  cfgform.Update;
end;

procedure TCfgForm.Button4Click(Sender: TObject);
begin
  if application.MessageBox(Pchar(question12),Pchar(programname),mb_yesno+mb_iconquestion)=id_no then exit;
  application.Terminate;
end;

procedure TCfgForm.Button5Click(Sender: TObject);
begin
  if configtype='begin' then begin
    cfgform.Hide;
    muflash.iniciar;
  end
    else begin
      cfgform.Close;
    end;
end;

procedure TCfgForm.ComboBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  Offset: Integer;
begin
  with (Control as TComboBox).Canvas do begin
    FillRect(Rect); Bitmap:= TBitmap(ComboBox1.Items.Objects[index]);
    if Bitmap<>nil then begin
      BrushCopy(Bounds(Rect.Left + 1, Rect.Top + 1, Bitmap.Width,
        Bitmap.Height), Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height), clRed);
      Offset:= Bitmap.width + 5;
    end else Offset:=22;
    TextOut(Rect.Left + Offset, Rect.Top+2, ComboBox1.Items[index]);
  end;
end;



procedure TCfgForm.ComboBox1MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height:=18;
end;

procedure TCfgForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if configtype='begin' then begin
    if application.MessageBox(Pchar(Question12),Pchar(Question3Caption),mb_yesno+mb_iconquestion)=id_no then exit;
    application.Terminate;
  end
    else begin
      dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTAutoBakCfg.ini');
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
      form1.Enabled:=true;
      form1.iniciar;
    end;
end;

procedure TCfgForm.iniciar;
var i,j:byte;
begin
  groupbox1.visible:=false;
  groupbox2.visible:=false;
  groupbox4.visible:=false;
  groupbox3.visible:=true;
  bmps:=tbitmap.create;
  bmps.Width:=16;
  bmps.Height:=16;
  for i := 0 to 15 do
    for j:= 0 to 15 do
      bmps.Canvas.Pixels[i,j]:=image1.Canvas.Pixels[i,j];
  {lang}
  label1.caption:=Folder1name;
  label3.caption:=Folder2name;
  label19.caption:=FormatofTheFile;
  label20.caption:=FormatofTheDate;
  label2.caption:=FormatoftheHour;
  button6.caption:=findtext;
  button8.caption:=findtext;
  button2.caption:=config;

  label17.caption:=ConfigMSG;

  label10.Caption:=Dababase4nameConfig;
  label11.Caption:=Dababase6nameConfig;
  label12.caption:=Dababase9nameConfig;
  label13.caption:=Dababase8nameConfig;
  label5.caption:=Dababase1nameConfig;
  label6.caption:=Dababase3nameConfig;
  label7.caption:=Dababase5nameConfig;
  label8.caption:= Dababase7nameConfig;
  label9.caption:=Dababase2nameConfig;
  button1.caption:=config;

  label14.caption:=DNSMuonline;
  label16.caption:=User;
  label18.caption:=Password;
  button3.caption:=ReadDatabases;
  label15.caption:=Database;
  button7.caption:=config;

  button4.caption:=Cancel;
  button5.caption:=ok;


  {lang end}
end;


procedure TCfgForm.ListBox1Click(Sender: TObject);
begin
  if listbox1.Items[listbox1.ItemIndex]='AutoBackup' then begin
    groupbox3.visible:=false;
    groupbox2.visible:=false;
    groupbox4.visible:=false;
    groupbox1.visible:=true;
    dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTAutoBakCfg.ini');
    edit1.text:=dsnini.ReadString('CMTBackupDB','Folder','');
    edit17.text:=dsnini.ReadString('CMTBackupDB','Folder2','');
    edit2.text:=dsnini.ReadString('CMTBackupDB','FileFormat','');
    edit3.text:=dsnini.ReadString('CMTBackupDB','HourFormat','');
    edit7.text:=dsnini.ReadString('CMTBackupDB','DateFormat','');
    dsnini.Free;
  end;
  if listbox1.Items[listbox1.ItemIndex]='DatabaseNames' then begin
    groupbox3.visible:=false;
    groupbox1.visible:=false;
    groupbox4.visible:=false;
    groupbox2.visible:=true;
    dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTAutoBakCfg.ini');
    edit4.text:=dsnini.ReadString('CMTBackupDB','Database1Name','');
    edit9.text:=dsnini.ReadString('CMTBackupDB','Database2Name','');
    edit5.text:=dsnini.ReadString('CMTBackupDB','Database3Name','');
    edit10.text:=dsnini.ReadString('CMTBackupDB','Database4Name','');
    edit6.text:=dsnini.Readstring('CMTBackupDB','Database5Name','') ;
    edit11.text:=dsnini.ReadString('CMTBackupDB','Database6Name','');
    edit8.text:=dsnini.ReadString('CMTBackupDB','Database7Name','');
    edit13.text:=dsnini.ReadString('CMTBackupDB','Database8Name','');
    edit12.text:=dsnini.ReadString('CMTBackupDB','Database9Name','');
    dsnini.Free;
  end;
  if listbox1.Items[listbox1.ItemIndex]='DNS' then begin
    groupbox3.visible:=false;
    groupbox1.visible:=false;
    groupbox2.visible:=false;
    groupbox4.visible:=true;
    dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTAutoBakCfg.ini');
    edit14.text:=dsnini.ReadString('CMTconnectDNS','DSN','');
    edit15.text:=dsnini.ReadString('CMTconnectDNS','User','');
    edit16.text:=dsnini.ReadString('CMTconnectDNS','Password','');
    mastercatalog:=dsnini.ReadString('CMTconnectDNS','DB','');
    dsnini.Free;
    combobox1.Items.clear;
    combobox1.Items.addobject(mastercatalog,bmps);
    combobox1.itemindex:=0;
    combobox1.Enabled:=false;
  end;
end;


procedure TCfgForm.Button7Click(Sender: TObject);
var Reg: tRegistry;
  bDriversValue, bSQLKey: boolean;
  i:integer;
  dsnini:tinifile;
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey(  '\Software\ODBC\ODBC.INI\ODBC Data Sources', false );
    bDriversValue := Reg.ValueExists(edit14.text );
    Reg.CloseKey;
    Reg.Free;
    if ( bDriversValue=false) then begin
      application.MessageBox(pchar(Error28),pchar(ErrorCaption),mb_ok+mb_iconerror);
      exit;
    end;
    adoquery1.ConnectionString:='Provider=MSDASQL.1;Password='+edit16.text+';Persist Security Info=True;User ID='+edit15.text+';Data Source='+edit14.text+'';
    adoquery1.Close;
    adoquery1.SQL.add('SELECT CATALOG_NAME as ''Database'''+
                      'FROM INFORMATION_SCHEMA.SCHEMATA');
    adoquery1.Open;
    bsqlkey:=false;
    for i := 0 to adoquery1.recordcount-1 do begin
      if Uppercase(combobox1.Items[combobox1.itemindex])=Uppercase(adoquery1.Fields[0].AsString) then bsqlkey:=true;
      adoquery1.Next;
    end;
    adoquery1.close;
    if bsqlkey=false then begin
      application.MessageBox(pchar(Error25),pchar(ErrorCaption),mb_ok+mb_iconerror);
      exit;
    end;
  except
    application.MessageBox(pchar(Error26),pchar(ErrorCaption),mb_ok+mb_iconerror);
    Exit;
  end;
  if listbox1.Items[listbox1.ItemIndex]='DNS' then
    begin
      dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTAutoBakCfg.ini');
      dsnini.writeString('CMTconnectDNS','DSN',edit14.text);
      dsnini.writeString('CMTconnectDNS','User',edit15.text);
      dsnini.writeString('CMTconnectDNS','Password',edit16.text) ;
      dsnini.writeString('CMTconnectDNS','DB',combobox1.Text);
      dsnini.Free;
    end;  
end;


procedure TCfgForm.Button2Click(Sender: TObject);
begin
  if edit1.Text='' then begin
    application.MessageBox(pchar(Error31+' '+Folder1name+','+FormatofTheFile+','+FormatofTheDate+','+FormatoftheHour+'!'),pchar(ErrorCaption),mb_ok+mb_iconerror);
    exit;
  end;
  if edit2.Text='' then begin
    application.MessageBox(pchar(Error31+' '+Folder1name+','+FormatofTheFile+','+FormatofTheDate+','+FormatoftheHour+'!'),pchar(ErrorCaption),mb_ok+mb_iconerror);
    exit;
  end;
  if edit7.Text='' then begin
    application.MessageBox(pchar(Error31+' '+Folder1name+','+FormatofTheFile+','+FormatofTheDate+','+FormatoftheHour+'!'),pchar(ErrorCaption),mb_ok+mb_iconerror);
    exit;
  end;
  if edit3.Text='' then begin
    application.MessageBox(pchar(Error31+' '+Folder1name+','+FormatofTheFile+','+FormatofTheDate+','+FormatoftheHour+'!'),pchar(ErrorCaption),mb_ok+mb_iconerror);
    exit;
  end;
  dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTAutoBakCfg.ini');
  dsnini.writeString('CMTBackupDB','Folder',edit1.text);
  dsnini.writeString('CMTBackupDB','Folder2',edit17.text);
  dsnini.writeString('CMTBackupDB','FileFormat',edit2.text) ;
  dsnini.writeString('CMTBackupDB','HourFormat',edit7.Text);
  dsnini.writeString('CMTBackupDB','DateFormat',edit3.Text);
  dsnini.Free;
end;

procedure TCfgForm.Button6Click(Sender: TObject);
begin
 if rzfolderdialog1.execute  then
    if rzfolderdialog1.SelectedPathName<>'' then
      edit1.Text:=rzfolderdialog1.SelectedPathName;

end;

procedure TCfgForm.Button8Click(Sender: TObject);
begin
 if rzfolderdialog1.execute then
    if rzfolderdialog1.SelectedPathName<>'' then
      edit17.Text:=rzfolderdialog1.SelectedPathName;
end;

end.
