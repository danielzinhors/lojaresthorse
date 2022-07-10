inherited frmUsuarios: TfrmUsuarios
  Caption = 'Usu'#225'rios'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  inherited CardPanel: TCardPanel
    ActiveCard = CardCadastro
    inherited CardVisualizar: TCard
      inherited DBGrid: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Title.Caption = 'C'#243'digo'
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'login'
            Title.Caption = 'Login'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status'
            Title.Caption = 'Status'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Title.Caption = 'Telefone'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sexo'
            Title.Caption = 'Sexo'
            Width = 100
            Visible = True
          end>
      end
      inherited pnlFiltros: TPanel
        object lblPesquisaCodigo: TLabel
          Left = 14
          Top = 6
          Width = 36
          Height = 14
          Caption = 'C'#243'digo:'
        end
        object lblPesquisaNome: TLabel
          Left = 115
          Top = 6
          Width = 30
          Height = 14
          Caption = 'Nome:'
        end
        object edtPesquisaCodigo: TEdit
          Left = 14
          Top = 19
          Width = 91
          Height = 22
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object edtPesquisaNome: TEdit
          Left = 115
          Top = 19
          Width = 662
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
      end
    end
    inherited CardCadastro: TCard
      object lblCodigo: TLabel [0]
        Left = 15
        Top = 16
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
        FocusControl = edtCodigo
      end
      object lblNome: TLabel [1]
        Left = 103
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Nome:'
        FocusControl = edtNome
      end
      object lblTelefone: TLabel [2]
        Left = 15
        Top = 56
        Width = 44
        Height = 14
        Caption = 'Telefone:'
        FocusControl = edtTelefone
      end
      object lblLogin: TLabel [3]
        Left = 15
        Top = 96
        Width = 29
        Height = 14
        Caption = 'Login:'
        FocusControl = edtLogin
      end
      object lblSenha: TLabel [4]
        Left = 14
        Top = 136
        Width = 34
        Height = 14
        Caption = 'Senha:'
        FocusControl = edtSenha
      end
      object lblSexo: TLabel [5]
        Left = 200
        Top = 57
        Width = 28
        Height = 14
        Caption = 'Sexo:'
        FocusControl = edtTelefone
      end
      inherited pnlFooterCadastro: TPanel
        TabOrder = 7
      end
      object edtCodigo: TDBEdit
        Left = 15
        Top = 29
        Width = 74
        Height = 22
        DataField = 'id'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 0
      end
      object edtNome: TDBEdit
        Left = 103
        Top = 29
        Width = 418
        Height = 22
        Anchors = [akTop, akRight]
        DataField = 'nome'
        DataSource = dsCadastro
        TabOrder = 1
      end
      object ckbStatus: TDBCheckBox
        Left = 536
        Top = 32
        Width = 97
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Ativo?'
        DataField = 'status'
        DataSource = dsCadastro
        TabOrder = 2
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object edtTelefone: TDBEdit
        Left = 15
        Top = 69
        Width = 154
        Height = 22
        DataField = 'telefone'
        DataSource = dsCadastro
        TabOrder = 3
      end
      object edtLogin: TDBEdit
        Left = 15
        Top = 109
        Width = 330
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        DataField = 'login'
        DataSource = dsCadastro
        TabOrder = 5
      end
      object edtSenha: TDBEdit
        Left = 14
        Top = 149
        Width = 330
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        DataField = 'senha'
        DataSource = dsCadastro
        PasswordChar = '*'
        TabOrder = 6
      end
      object cmbSexo: TComboBox
        Left = 200
        Top = 69
        Width = 145
        Height = 22
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 4
        Text = 'Feminino'
        Items.Strings = (
          'Masculino'
          'Feminino')
      end
      object btnAlterarFoto: TButton
        Left = 368
        Top = 275
        Width = 95
        Height = 25
        Caption = 'Alterar ...'
        TabOrder = 8
        OnClick = btnAlterarFotoClick
      end
      object btnLimparFoto: TButton
        Left = 473
        Top = 275
        Width = 95
        Height = 25
        Caption = 'Limpar ...'
        TabOrder = 9
        OnClick = btnLimparFotoClick
      end
      object Panel1: TPanel
        Left = 368
        Top = 69
        Width = 200
        Height = 200
        BevelOuter = bvLowered
        BorderStyle = bsSingle
        TabOrder = 10
        object imgPerfil: TImage
          Left = 1
          Top = 1
          Width = 194
          Height = 194
          Align = alClient
          Center = True
          Proportional = True
          ExplicitLeft = 10
          ExplicitTop = 0
          ExplicitWidth = 200
          ExplicitHeight = 200
        end
      end
    end
  end
  inherited dsPesquisa: TDataSource
    DataSet = ServiceUsuarios.mtPesquisa
  end
  object OpenDialog: TOpenDialog
    Left = 585
    Top = 156
  end
end
