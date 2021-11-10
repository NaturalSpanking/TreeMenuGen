object AboutBox: TAboutBox
  Left = 200
  Top = 108
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 322
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 464
    Height = 273
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 8
      Top = 8
      Width = 65
      Height = 57
      Picture.Data = {
        07544269746D617076020000424D760200000000000076000000280000002000
        0000200000000100040000000000000200000000000000000000100000000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00000000000000000000000000000000000EE8787878EEEEEEE03F30878EEE
        EEE00EE8787878EEEEEEE03F30878EEEEEE00EE8787878EEEEEEE03F30878EEE
        EEE00EE8787878EEEEEEE03F30878EEEEEE00887787877788888803F3088787E
        EEE00788787878878887803F3088887EEEE00788887888878887803F3088887E
        EEE00877888887788888703F308887EEEEE00888777778888888037883088888
        8EE007777777777777703787883087777EE00888888888888803787FF8830888
        888008888888888880378777778830888880077777777788037873F3F3F87808
        88E00888888888803787FFFFFFFF8830EEE00887777778800001111111111100
        EEE00888888888888899B999B99999EEEEE00888888888888899B9B99BB9B9EE
        EEE0088888888888899BB9BB99BB99EEEEE0078888888888899B999B999999EE
        EEE0087788888778899B9B9BB9BB99EEEEE00888778778888E9B9B9BB9999EEE
        EEE0088888788888EE9B99B9BB9BEEEEEEE00EE8888888EEEEE999B9999EEEEE
        EEE00EEEE888EEEEEEEE99BB999EEEEEEEE00EEEEE8EEEEEEEEEE999B9EEEEEE
        EEE00EEEEE8EEEEEEEEEEEE999EEEEEEEEE00EEEEE8EEEEEEEEEEEEE99EEEEEE
        EEE00EEEEE8EEEEEEEEEEEEE9EEEEEEEEEE00EEEEE8EEEEEEEEEEEEEEEEEEEEE
        EEE00EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE00000000000000000000000000000
        0000}
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 88
      Top = 16
      Width = 102
      Height = 13
      Caption = 'Tree Menu Generator'
      IsControl = True
    end
    object Version: TLabel
      Left = 88
      Top = 40
      Width = 53
      Height = 13
      Caption = 'Version 0.2'
      IsControl = True
    end
    object Comments: TLabel
      Left = 8
      Top = 80
      Width = 172
      Height = 13
      Caption = 'https://github.com/NaturalSpanking'
      WordWrap = True
      IsControl = True
    end
    object CopyrightMemo: TMemo
      Left = 2
      Top = 104
      Width = 460
      Height = 167
      Align = alBottom
      Lines.Strings = (
        'The MIT License (MIT)'
        'Copyright '#169' 2021 '#1063#1077#1088#1082#1072#1089#1086#1074' '#1052#1072#1082#1089#1080#1084', <cahutap7@inbox.ru>'
        ''
        
          'Permission is hereby granted, free of charge, to any person obta' +
          'ining a copy of this '
        
          'software and associated documentation files (the '#8220'Software'#8221'), to' +
          ' deal in the '
        
          'Software without restriction, including without limitation the r' +
          'ights to use, copy, '
        
          'modify, merge, publish, distribute, sublicense, and/or sell copi' +
          'es of the Software, '
        
          'and to permit persons to whom the Software is furnished to do so' +
          ', subject to the '
        'following conditions:'
        ''
        
          'The above copyright notice and this permission notice shall be i' +
          'ncluded in all copies '
        'or substantial portions of the Software.'
        ''
        'THE SOFTWARE IS PROVIDED '#8220'AS IS'#8221', WITHOUT WARRANTY OF ANY KIND, '
        'EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE '
        'WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR '
        'PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS '
        'OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR '
        'OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR '
        'OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE '
        'SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.')
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitTop = 168
    end
  end
  object OKButton: TButton
    Left = 200
    Top = 289
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
