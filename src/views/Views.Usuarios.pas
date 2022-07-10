unit Views.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels,
  Vcl.DBCtrls, Vcl.Mask;

type
  TfrmUsuarios = class(TfrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    edtPesquisaCodigo: TEdit;
    lblPesquisaNome: TLabel;
    edtPesquisaNome: TEdit;
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    lblNome: TLabel;
    edtNome: TDBEdit;
    ckbStatus: TDBCheckBox;
    lblTelefone: TLabel;
    edtTelefone: TDBEdit;
    edtLogin: TDBEdit;
    lblLogin: TLabel;
    edtSenha: TDBEdit;
    lblSenha: TLabel;
    cmbSexo: TComboBox;
    lblSexo: TLabel;
    btnAlterarFoto: TButton;
    btnLimparFoto: TButton;
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    imgPerfil: TImage;
    procedure dsCadastroStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnAlterarFotoClick(Sender: TObject);
    procedure btnLimparFotoClick(Sender: TObject);
  private
     function getStreamFotoUsuario(): TMemoryStream;
    procedure carregarFotoUsusario;
  public
    procedure doBeforeList(); override;
  end;

implementation

{$R *.dfm}

uses Services.Usuarios, JPeg;

{ TfrmUsuario }

procedure TfrmUsuarios.btnAlterarFotoClick(Sender: TObject);
begin
  inherited;
  if openDialog.execute then
    imgPerfil.picture.LoadFromFile(openDialog.FileName);
end;

procedure TfrmUsuarios.btnConfirmarClick(Sender: TObject);
begin
  if dsCadastro.dataSet.state in dsEditModes then
    TServiceUsuarios(FService).mtCadastrosexo.AsInteger := cmbSexo.ItemIndex;
  inherited;
  TServiceUsuarios(FService).salvarFotoUser(getStreamFotoUsuario());
end;

procedure TfrmUsuarios.btnLimparFotoClick(Sender: TObject);
begin
  inherited;
  imgPerfil.Picture := nil;
end;

procedure TfrmUsuarios.doBeforeList();
begin
  FService.request
          .clearParams
          .addParam('id', edtPesquisaCodigo.text)
          .addParam('nome', edtPesquisaNome.text);
end;

procedure TfrmUsuarios.dsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if dsCadastro.dataSet.state in dsEditModes then
  begin
    cmbSexo.ItemIndex := TServiceUsuarios(FService).mtCadastrosexo.AsInteger;
    if dsCadastro.dataSet.state in [dsInsert] then
      imgPerfil.Picture := nil
    else
      carregarFotoUsusario();
    edtNome.setFocus;
  end;
end;

procedure TfrmUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceUsuarios.create(self);
end;

procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisaCodigo.setFocus();
end;

function TfrmUsuarios.getStreamFotoUsuario: TMemoryStream;
begin
  result := TMemoryStream.create();
  imgPerfil.Picture.SaveToStream(result);
end;

procedure TfrmUsuarios.carregarFotoUsusario();
begin
  var LFoto := TServiceUsuarios(FService).downloadFotoUser();
  try
    if LFoto.size = 0 then
    begin
      imgPerfil.Picture := nil;
      exit;
    end;
    var LJPEGImag := TJPEGImage.create();
    try
      LJPEGImag.LoadFromStream(LFoto);
      imgPerfil.Picture.Assign(LJPEGImag);
    finally
      LJPEGImag.free;
    end;
  finally
    LFoto.free;
  end;
end;

end.
