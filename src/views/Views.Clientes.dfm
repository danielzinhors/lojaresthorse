inherited frmClientes: TfrmClientes
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 57
      Caption = 'Clientes'
      ExplicitWidth = 57
    end
  end
  inherited CardPanel: TCardPanel
    ActiveCard = CardCadastro
    inherited CardVisualizar: TCard
      inherited Shape1: TShape
        Top = 100
        ExplicitTop = 100
      end
      inherited DBGrid: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Title.Caption = 'C'#243'digo'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Width = 450
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status'
            Title.Caption = 'Status'
            Width = 100
            Visible = True
          end>
      end
      inherited pnlFiltros: TPanel
        Top = 30
        ExplicitTop = 30
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
      object pnlCadastro: TPanel [0]
        Left = 0
        Top = 0
        Width = 798
        Height = 533
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          798
          533)
        object lblCodigo: TLabel
          Left = 15
          Top = 16
          Width = 36
          Height = 14
          Caption = 'C'#243'digo:'
          FocusControl = edtCodigo
          OnClick = FormCreate
        end
        object lblNome: TLabel
          Left = 103
          Top = 16
          Width = 30
          Height = 14
          Caption = 'Nome:'
          FocusControl = edtNome
          OnClick = FormCreate
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
      end
      inherited pnlFooterCadastro: TPanel
        TabOrder = 1
      end
    end
  end
  inherited dsPesquisa: TDataSource
    Left = 265
    Top = 212
  end
end
