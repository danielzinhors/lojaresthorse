unit Views.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask;

type
  TfrmClientes = class(TfrmBaseCadastro)
    pnlCadastro: TPanel;
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    edtNome: TDBEdit;
    lblNome: TLabel;
    ckbStatus: TDBCheckBox;
    lblPesquisaCodigo: TLabel;
    edtPesquisaCodigo: TEdit;
    edtPesquisaNome: TEdit;
    lblPesquisaNome: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure dsCadastroStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    procedure doBeforeList(); override;
  end;

implementation

uses
  Services.Clientes;

{$R *.dfm}

procedure TfrmClientes.doBeforeList();
begin
  FService.request
          .clearParams
          .addParam('id', edtPesquisaCodigo.text)
          .addParam('nome', edtPesquisaNome.text);
end;

procedure TfrmClientes.dsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if dsCadastro.dataSet.state in dsEditModes then
    edtNome.setFocus;
end;

procedure TfrmClientes.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceClientes.create(self);
end;

procedure TfrmClientes.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisaCodigo.setFocus();
end;

end.
