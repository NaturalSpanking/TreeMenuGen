object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tree Menu Generator'
  ClientHeight = 371
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 19
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 606
    Height = 371
    Align = alClient
    DragMode = dmAutomatic
    HideSelection = False
    Indent = 19
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnChange = TreeView1Change
    OnDeletion = TreeView1Deletion
    OnDragDrop = TreeView1DragDrop
    OnDragOver = TreeView1DragOver
    OnEdited = TreeView1Edited
    ExplicitHeight = 351
  end
  object Panel1: TPanel
    Left = 606
    Top = 0
    Width = 228
    Height = 371
    Align = alRight
    TabOrder = 1
    ExplicitHeight = 351
    object Button1: TButton
      Left = 6
      Top = 217
      Width = 85
      Height = 28
      Caption = 'Apply'
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object ValueListEditor1: TValueListEditor
      Left = 1
      Top = 1
      Width = 226
      Height = 210
      Align = alTop
      DefaultRowHeight = 22
      Strings.Strings = (
        'Is parameter=True'
        'Name=Menu'
        'Init value=0'
        'Min value=0'
        'Max value=100'
        'Init delta=10'
        'Min delta=0'
        'Max delta=100')
      TabOrder = 1
      OnKeyPress = ValueListEditor1KeyPress
      ColWidths = (
        104
        116)
      RowHeights = (
        22
        22
        22
        22
        22
        22
        22
        22
        22)
    end
    object Button2: TButton
      Left = 6
      Top = 267
      Width = 85
      Height = 28
      Caption = 'Add root'
      TabOrder = 2
      TabStop = False
      OnClick = Addroot1Click
    end
    object Button3: TButton
      Left = 6
      Top = 301
      Width = 85
      Height = 28
      Caption = 'Add child'
      TabOrder = 3
      TabStop = False
      OnClick = Addchild1Click
    end
    object Button4: TButton
      Left = 6
      Top = 335
      Width = 85
      Height = 28
      Caption = 'Remove'
      TabOrder = 4
      TabStop = False
      OnClick = Remove1Click
    end
    object Button5: TButton
      Left = 134
      Top = 217
      Width = 85
      Height = 28
      Caption = 'Generate'
      TabOrder = 5
      TabStop = False
      OnClick = Generate1Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 552
    Top = 256
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object Saveas1: TMenuItem
        Caption = 'Save as...'
        OnClick = Saveas1Click
      end
      object Generate1: TMenuItem
        Caption = 'Generate'
        ShortCut = 16455
        OnClick = Generate1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object ree1: TMenuItem
      Caption = 'Tree'
      object Addroot1: TMenuItem
        Caption = 'Add root'
        OnClick = Addroot1Click
      end
      object Addchild1: TMenuItem
        Caption = 'Add child'
        OnClick = Addchild1Click
      end
      object Remove1: TMenuItem
        Caption = 'Remove'
        OnClick = Remove1Click
      end
      object Expandall1: TMenuItem
        Caption = 'Expand all'
        OnClick = Expandall1Click
      end
      object Collapseall1: TMenuItem
        Caption = 'Collapse all'
        OnClick = Collapseall1Click
      end
    end
    object About1: TMenuItem
      Caption = 'About'
      OnClick = About1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Tree Menu Data|*.tmdat|Any File|*.*'
    Left = 552
    Top = 168
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.tmdat'
    Filter = 'Tree Menu Data|*.tmdat'
    Left = 552
    Top = 208
  end
  object PopupMenu1: TPopupMenu
    Left = 552
    Top = 304
    object Addroot2: TMenuItem
      Caption = 'Add root'
      OnClick = Addroot1Click
    end
    object Addchild2: TMenuItem
      Caption = 'Add child'
      OnClick = Addchild1Click
    end
    object Remove2: TMenuItem
      Caption = 'Remove'
      OnClick = Remove1Click
    end
  end
end
