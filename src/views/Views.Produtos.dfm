inherited frmProdutos: TfrmProdutos
  Caption = 'frmProdutos'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 63
      Caption = 'Produtos'
      ExplicitWidth = 63
    end
  end
  inherited CardPanel: TCardPanel
    ActiveCard = CardCadastro
    inherited CardVisualizar: TCard
      inherited DBGrid: TDBGrid
        Columns = <
          item
            Alignment = taRightJustify
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
            Width = 350
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'valor'
            Title.Caption = 'Valor'
            Width = 100
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'status'
            Title.Caption = 'Status'
            Width = 100
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'estoque'
            Title.Caption = 'Estoque'
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
        Anchors = [akTop]
        Caption = 'Nome:'
        FocusControl = edtNome
      end
      object lblValor: TLabel [2]
        Left = 14
        Top = 56
        Width = 28
        Height = 14
        Caption = 'Valor:'
        FocusControl = edtValor
      end
      object lblEstque: TLabel [3]
        Left = 134
        Top = 56
        Width = 42
        Height = 14
        Caption = 'Estoque:'
        FocusControl = edtEstoque
      end
      object edtCodigo: TDBEdit
        Left = 15
        Top = 29
        Width = 74
        Height = 22
        DataField = 'id'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 1
      end
      object edtNome: TDBEdit
        Left = 103
        Top = 29
        Width = 418
        Height = 22
        Anchors = [akTop, akRight]
        DataField = 'nome'
        DataSource = dsCadastro
        TabOrder = 2
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
        TabOrder = 3
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object edtValor: TDBEdit
        Left = 14
        Top = 69
        Width = 107
        Height = 22
        DataField = 'valor'
        DataSource = dsCadastro
        TabOrder = 4
      end
      object edtEstoque: TDBEdit
        Left = 134
        Top = 69
        Width = 107
        Height = 22
        DataField = 'estoque'
        DataSource = dsCadastro
        TabOrder = 5
      end
    end
  end
end
