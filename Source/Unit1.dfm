object Form1: TForm1
  Left = 311
  Top = 204
  Width = 427
  Height = 381
  Caption = 'CMT Auto Backup Tool'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 270
    Width = 419
    Height = 57
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 137
      Height = 19
      Caption = 'Proximo Backup: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 30
      Width = 175
      Height = 19
      Caption = 'Contagem Regressiva:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 419
    Height = 270
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WantTabs = True
  end
  object ComboBox1: TComboBox
    Left = 256
    Top = 232
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'ComboBox1'
    Visible = False
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object CMTAutoBackup1: TMenuItem
      Caption = 'CMTAutoBackup'
      object EsconderPrograma1: TMenuItem
        Caption = 'Esconder Programa'
        OnClick = MostrarPrograma1Click
      end
      object FazerBackupAgora1: TMenuItem
        Caption = 'Fazer Backup Agora'
        OnClick = FazerBackupAgora1Click
      end
      object SalvarLog1: TMenuItem
        Caption = 'Salvar Log'
        OnClick = SalvarLog1Click
      end
      object ApagarLog1: TMenuItem
        Caption = 'Apagar Log'
        OnClick = ApagarLog1Click
      end
      object Configurar1: TMenuItem
        Caption = 'Configurar'
        OnClick = Configurar1Click
      end
      object Fechar1: TMenuItem
        Caption = 'Fechar'
        OnClick = Fechar3Click
      end
    end
    object Recarregar1: TMenuItem
      Caption = 'Recarregar'
      object empodeBackup1: TMenuItem
        Caption = 'Tempo de Backup'
        OnClick = empodeBackup1Click
      end
      object ConfiguraesdoPrograma1: TMenuItem
        Caption = 'Configura'#231#245'es do Programa'
        OnClick = ConfiguraesdoPrograma1Click
      end
    end
    object Sobre1: TMenuItem
      Caption = 'Sobre'
      object Creditos1: TMenuItem
        Caption = 'Creditos'
        OnClick = Creditos1Click
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 72
    Top = 8
  end
  object ADOCommand1: TADOCommand
    Parameters = <>
    Left = 8
    Top = 40
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 8
    object MostrarPrograma1: TMenuItem
      Caption = 'Esconder Programa'
      OnClick = MostrarPrograma1Click
    end
    object a1: TMenuItem
      Caption = 'Fazer Backup Agora'
      OnClick = FazerBackupAgora1Click
    end
    object Fechar2: TMenuItem
      Caption = '-------------------------'
      Enabled = False
    end
    object Fechar3: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar3Click
    end
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 40
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'Arquivos de text( *.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Escolha o lugar que voc'#234' deseja salvar o log'
    Left = 72
    Top = 40
  end
end
