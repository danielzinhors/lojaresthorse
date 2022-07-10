unit Views.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.WinXCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.CategoryButtons;

type
  TfrmPrincipal = class(TForm)
    pnlToolBar: TPanel;
    Image1: TImage;
    lblTitle: TLabel;
    pnlContent: TPanel;
    SplitView: TSplitView;
    ImageList: TImageList;
    ActionList: TActionList;
    actHome: TAction;
    actClientes: TAction;
    actProdutos: TAction;
    actUsuarios: TAction;
    CategoryButtons: TCategoryButtons;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure actClientesExecute(Sender: TObject);
    procedure actProdutosExecute(Sender: TObject);
    procedure actUsuariosExecute(Sender: TObject);
  private
    FFormActive: TForm;
    procedure login();
    procedure showForm(const AFormClass: TComponentClass; var AForm);
  end;

var
  FrmPrincipal: TfrmPrincipal;

implementation

uses
  Views.Login, Views.Clientes, Views.Produtos, Views.Usuarios, Views.Home;

{$R *.dfm}

procedure TfrmPrincipal.actClientesExecute(Sender: TObject);
var
  LClient: TFrmClientes;
begin
  showForm(TFrmClientes, LClient);
end;

procedure TfrmPrincipal.actHomeExecute(Sender: TObject);
var
  LHome: TFrmHome;
begin
  showForm(TFrmHome, LHome);
end;

procedure TfrmPrincipal.actProdutosExecute(Sender: TObject);
var
  LProd: TFrmProdutos;
begin
  showForm(TFrmProdutos, LProd);
end;

procedure TfrmPrincipal.actUsuariosExecute(Sender: TObject);
var
  LUser: TFrmUsuarios;
begin
  showForm(TFrmUsuarios, LUser);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  login
end;

procedure TfrmPrincipal.Image1Click(Sender: TObject);
begin
  if SplitView.opened then
  begin
    SplitView.Close;
    CategoryButtons.ButtonOptions := CategoryButtons.ButtonOptions - [boShowCaptions];
  end
  else
  begin
    SplitView.open;
    CategoryButtons.ButtonOptions := CategoryButtons.ButtonOptions + [boShowCaptions];
  end;
end;

procedure TfrmPrincipal.login;
begin
  var LForm := TFrmLogin.create(self);
  try
    if LForm.showModal <> mrOK then
      application.terminate;
  finally
    LForm.free;
  end;
end;

procedure TfrmPrincipal.showForm(const AFormClass: TComponentClass; var AForm);
begin
  if assigned(FFormActive) then
    FFormActive.close;
  application.createForm(AFormClass, AForm);
  with TForm(AForm) do
  begin
    parent := pnlContent;
    align := TAlign.alClient;
    windowState := TWindowState.wsMaximized;
    show;
  end;
  FFormActive := TForm(AForm);
end;

end.
