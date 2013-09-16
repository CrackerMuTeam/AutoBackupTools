object CfgForm: TCfgForm
  Left = 168
  Top = 172
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Configuration Form'
  ClientHeight = 260
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 83
    Top = 110
    Width = 16
    Height = 16
    Picture.Data = {
      07544269746D617036030000424D360300000000000036000000280000001000
      0000100000000100180000000000000300000000000000000000000000000000
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00808000FFFF
      000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686860080
      80008080FFFFFF008080FFFFFF00808000FFFF008080000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF86868600808000FFFFFFFFFFFFFFFF00808000FFFF
      008080008080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686860080
      80008080FFFFFF008080FFFFFF00808000FFFF008080000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF86868600808000FFFFFFFFFFFFFFFF00808000FFFF
      008080008080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686860080
      80008080FFFFFF008080FFFFFF00808000FFFF008080000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF86868600808000FFFFFFFFFFFFFFFF00808000FFFF
      008080008080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686860080
      80008080FFFFFF008080FFFFFF00808000FFFF008080000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF86868600808000FFFFFFFFFFFFFFFF00808000FFFF
      008080008080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686860080
      80008080FFFFFF008080FFFFFF008080FFFFFF008080000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF868686008080FFFFFF00FFFFFFFFFF00FFFFFFFFFF
      00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF868686FFFF
      FF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF868686FFFFFF00FFFFFFFFFF00FFFFFFFFFF
      00FFFF868686FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF868686868686868686868686868686868686FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF}
    Visible = False
  end
  object GroupBox4: TGroupBox
    Left = 127
    Top = 4
    Width = 299
    Height = 221
    Caption = 'Config DNS'
    TabOrder = 6
    object Label14: TLabel
      Left = 8
      Top = 16
      Width = 24
      Height = 13
      Caption = 'DNS:'
    end
    object Label15: TLabel
      Left = 8
      Top = 128
      Width = 50
      Height = 13
      Caption = 'Database:'
    end
    object Label16: TLabel
      Left = 8
      Top = 56
      Width = 101
      Height = 13
      Caption = 'Usu'#225'rio(Padr'#227'o=sa):'
    end
    object Label18: TLabel
      Left = 160
      Top = 56
      Width = 34
      Height = 13
      Caption = 'Senha:'
    end
    object Edit14: TEdit
      Left = 8
      Top = 32
      Width = 281
      Height = 21
      TabOrder = 0
    end
    object Button3: TButton
      Left = 43
      Top = 99
      Width = 209
      Height = 25
      Caption = 'Ler Databases do DNS'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Edit15: TEdit
      Left = 8
      Top = 72
      Width = 129
      Height = 21
      TabOrder = 2
    end
    object Edit16: TEdit
      Left = 160
      Top = 72
      Width = 129
      Height = 21
      TabOrder = 3
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 147
      Width = 281
      Height = 24
      Style = csOwnerDrawVariable
      Enabled = False
      ItemHeight = 18
      TabOrder = 4
      OnDrawItem = ComboBox1DrawItem
      OnMeasureItem = ComboBox1MeasureItem
    end
    object Button7: TButton
      Left = 154
      Top = 183
      Width = 137
      Height = 29
      Caption = 'Configurar'
      TabOrder = 5
      OnClick = Button7Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 127
    Top = 2
    Width = 299
    Height = 223
    Caption = 'DatabaseNames'
    TabOrder = 2
    object Label5: TLabel
      Left = 8
      Top = 16
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase1:'
    end
    object Label6: TLabel
      Left = 8
      Top = 56
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase3:'
    end
    object Label7: TLabel
      Left = 8
      Top = 96
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase5:'
    end
    object Label8: TLabel
      Left = 8
      Top = 136
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase7:'
    end
    object Label9: TLabel
      Left = 136
      Top = 16
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase2:'
    end
    object Label10: TLabel
      Left = 136
      Top = 56
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase4:'
    end
    object Label11: TLabel
      Left = 136
      Top = 96
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase6:'
    end
    object Label12: TLabel
      Left = 8
      Top = 176
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase9:'
    end
    object Label13: TLabel
      Left = 136
      Top = 136
      Width = 101
      Height = 13
      Caption = 'Nome da DataBase8:'
    end
    object Button1: TButton
      Left = 152
      Top = 183
      Width = 137
      Height = 29
      Caption = 'Configurar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit4: TEdit
      Left = 8
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'Edit4'
    end
    object Edit5: TEdit
      Left = 8
      Top = 72
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'Edit4'
    end
    object Edit6: TEdit
      Left = 8
      Top = 112
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'Edit4'
    end
    object Edit8: TEdit
      Left = 8
      Top = 152
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'Edit4'
    end
    object Edit9: TEdit
      Left = 136
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 5
      Text = 'Edit4'
    end
    object Edit10: TEdit
      Left = 136
      Top = 72
      Width = 121
      Height = 21
      TabOrder = 6
      Text = 'Edit4'
    end
    object Edit11: TEdit
      Left = 136
      Top = 112
      Width = 121
      Height = 21
      TabOrder = 7
      Text = 'Edit4'
    end
    object Edit12: TEdit
      Left = 8
      Top = 192
      Width = 121
      Height = 21
      TabOrder = 8
      Text = 'Edit4'
    end
    object Edit13: TEdit
      Left = 136
      Top = 152
      Width = 121
      Height = 21
      TabOrder = 9
      Text = 'Edit4'
    end
  end
  object GroupBox3: TGroupBox
    Left = 127
    Top = 4
    Width = 299
    Height = 221
    TabOrder = 3
    object Label17: TLabel
      Left = 20
      Top = 81
      Width = 261
      Height = 70
      AutoSize = False
      Caption = 'Escolha o que voc'#234' vai configurar ao lado!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object GroupBox1: TGroupBox
    Left = 127
    Top = 4
    Width = 299
    Height = 221
    Caption = 'AutoBackup'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Pasta:'
    end
    object Label2: TLabel
      Left = 8
      Top = 172
      Width = 85
      Height = 13
      Caption = 'Formato da Hora:'
    end
    object Label19: TLabel
      Left = 8
      Top = 96
      Width = 98
      Height = 13
      Caption = 'Formato do arquivo:'
    end
    object Label20: TLabel
      Left = 8
      Top = 136
      Width = 85
      Height = 13
      Caption = 'Formato da Data:'
    end
    object Label3: TLabel
      Left = 8
      Top = 56
      Width = 86
      Height = 13
      Caption = 'Pasta2(Opcional):'
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 217
      Height = 21
      TabOrder = 0
    end
    object Button6: TButton
      Left = 232
      Top = 29
      Width = 59
      Height = 25
      Caption = 'Procurar'
      TabOrder = 1
      OnClick = Button6Click
    end
    object Edit2: TEdit
      Left = 8
      Top = 110
      Width = 137
      Height = 21
      TabOrder = 2
      Text = 'B-D-H'
    end
    object Button2: TButton
      Left = 152
      Top = 183
      Width = 137
      Height = 29
      Caption = 'Configurar'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Edit3: TEdit
      Left = 8
      Top = 186
      Width = 137
      Height = 21
      TabOrder = 4
      Text = 'HM'
    end
    object Edit7: TEdit
      Left = 8
      Top = 150
      Width = 137
      Height = 21
      TabOrder = 5
      Text = 'DMY'
    end
    object Edit17: TEdit
      Left = 8
      Top = 72
      Width = 217
      Height = 21
      TabOrder = 6
    end
    object Button8: TButton
      Left = 232
      Top = 69
      Width = 59
      Height = 25
      Caption = 'Procurar'
      TabOrder = 7
      OnClick = Button8Click
    end
  end
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 113
    Height = 217
    ItemHeight = 13
    Items.Strings = (
      'AutoBackup'
      'DatabaseNames'
      'DNS')
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object Button4: TButton
    Left = 269
    Top = 229
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    Visible = False
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 350
    Top = 229
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 5
    OnClick = Button5Click
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 32
    Top = 112
  end
  object rzFolderDialog1: TRzSelectFolderDialog
    Title = 'Selecione a pasta'
    Options = [sfdoCreateDeleteButtons, sfdoContextMenus, sfdoCreateFolderIcon, sfdoDeleteFolderIcon, sfdoVirtualFolders, sfdoShowHidden]
    Left = 359
    Top = 140
  end
end
