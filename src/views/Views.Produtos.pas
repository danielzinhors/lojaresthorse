unit Views.Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels,
  Vcl.DBCtrls, Vcl.Mask;

type
  TfrmProdutos = class(TfrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    edtPesquisaCodigo: TEdit;
    lblPesquisaNome: TLabel;
    edtPesquisaNome: TEdit;
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    lblNome: TLabel;
    edtNome: TDBEdit;
    ckbStatus: TDBCheckBox;
    lblValor: TLabel;
    edtValor: TDBEdit;
    lblEstque: TLabel;
    edtEstoque: TDBEdit;
    procedure dsCadastroStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure doBeforeList(); override;
  end;

implementation

{$R *.dfm}

uses
  Services.Produtos;

procedure TfrmProdutos.doBeforeList();
begin
  FService.request
          .clearParams
          .addParam('id', edtPesquisaCodigo.text)
          .addParam('nome', edtPesquisaNome.text);
end;

procedure TfrmProdutos.dsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if dsCadastro.dataSet.state in dsEditModes then
    edtNome.setFocus;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceProdutos.create(self);
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisaCodigo.setFocus();
end;

end.
