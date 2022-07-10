unit Views.Base.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base, Data.DB, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.WinXPanels, Vcl.StdCtrls, Services.Base.Cadastro;

type
  TfrmBaseCadastro = class(TfrmBase)
    pnlHeader: TPanel;
    lblTitle: TLabel;
    CardPanel: TCardPanel;
    CardVisualizar: TCard;
    CardCadastro: TCard;
    pnlBotoes: TPanel;
    btnIncluir: TSpeedButton;
    btnPesquisar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    pnlFooter: TPanel;
    DBGrid: TDBGrid;
    pnlFiltros: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    dsPesquisa: TDataSource;
    pnlFooterCadastro: TPanel;
    btnCancelar: TSpeedButton;
    btnConfirmar: TSpeedButton;
    dsCadastro: TDataSource;
    btnPrimeiro: TSpeedButton;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    btnUltimo: TSpeedButton;
    lblPagina: TLabel;
    pnlRegistros: TPanel;
    cmbRegistros: TComboBox;
    lblRegistros: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dsCadastroStateChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridDblClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure cmbRegistrosExit(Sender: TObject);
  private
     function getPageLimit(): integer;
    procedure calcularPaginacao();
    procedure listarRegistros();
  protected
    FService: TServiceBaseCadastro;
    procedure doBeforeList(); virtual;
  end;

implementation

{$R *.dfm}

procedure TfrmBaseCadastro.btnAlterarClick(Sender: TObject);
begin
  inherited;
  FService.alterar();
end;

procedure TfrmBaseCadastro.btnCancelarClick(Sender: TObject);
begin
  inherited;
  dsCadastro.DataSet.Cancel;
end;

procedure TfrmBaseCadastro.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pnlFooterCadastro.setFocus();
  FService.salvar();
end;

procedure TfrmBaseCadastro.btnExcluirClick(Sender: TObject);
begin
  inherited;
  FService.excluir();
end;

procedure TfrmBaseCadastro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FService.incluir();
end;

procedure TfrmBaseCadastro.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  listarRegistros();
end;

procedure TfrmBaseCadastro.btnPrimeiroClick(Sender: TObject);
begin
  inherited;
  if FService.page = 1 then
    exit;
  FService.page := 1;
  listarRegistros();
end;

procedure TfrmBaseCadastro.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  if FService.page = 1 then
    exit;
  FService.page := FService.page - 1;
  listarRegistros();
end;

procedure TfrmBaseCadastro.btnProximoClick(Sender: TObject);
begin
  inherited;
  if FService.page = FService.pages then
    exit;
  FService.page := FService.page + 1;
  listarRegistros();
end;

procedure TfrmBaseCadastro.btnUltimoClick(Sender: TObject);
begin
  inherited;
  if FService.page = FService.pages then
    exit;
  FService.page := FService.pages;
  listarRegistros();
end;

procedure TfrmBaseCadastro.calcularPaginacao;
begin
  if FService.page <= 0 then
    FService.page := 1;
  var LTotalPages := FService.records / getPageLimit();
  FService.pages := trunc(LTotalPages);
  if ((FService.pages - LTotalPages) > 0) or (FService.pages = 0) then
    FService.pages := FService.pages + 1;
end;

procedure TfrmBaseCadastro.cmbRegistrosExit(Sender: TObject);
begin
  inherited;
  FService.pageLimit := getPageLimit();
  listarRegistros();
end;

procedure TfrmBaseCadastro.DBGridDblClick(Sender: TObject);
begin
  inherited;
  btnAlterar.click();
end;

procedure TfrmBaseCadastro.doBeforeList();
begin

end;

procedure TfrmBaseCadastro.dsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if dsCadastro.dataSet.state in dsEditModes then
    CardCadastro.Show
  else
    CardVisualizar.Show;
end;

procedure TfrmBaseCadastro.FormDestroy(Sender: TObject);
begin
  if assigned(FService) then
    FService.free;
  inherited;
end;

procedure TfrmBaseCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_INSERT: if cardVisualizar.visible then btnIncluir.click;
    VK_F3: if cardVisualizar.visible then btnAlterar.click;
    VK_DELETE: if cardVisualizar.visible then btnExcluir.click;
    VK_F5: if cardVisualizar.visible then btnPesquisar.click;
    VK_F2: if cardCadastro.visible then btnConfirmar.click;
    VK_F4: if cardCadastro.visible then btnCancelar.click;
  end;
end;

procedure TfrmBaseCadastro.FormShow(Sender: TObject);
begin
  inherited;
  dsPesquisa.dataSet := FService.mtPesquisa;
  dsCadastro.dataSet := FService.mtCadastro;
  CardVisualizar.Show;
end;

function TfrmBaseCadastro.getPageLimit(): integer;
begin
  result := strToIntDef(cmbRegistros.text, 50);
end;

procedure TfrmBaseCadastro.listarRegistros;
begin
  doBeforeList();
  FService.listarRegistros();
  calcularPaginacao();
  lblPagina.caption := format('Página %d de %d', [FService.Page, FService.Pages]);
end;

end.
