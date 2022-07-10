unit Views.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Services.Login,
  Vcl.Imaging.pngimage, Views.Base;

type
  TFrmLogin = class(TfrmBase)
    pnlBackground: TPanel;
    imgLogo: TImage;
    lblUsuario: TLinkLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    lblSenha: TLinkLabel;
    btnEntrar: TButton;
    btnCancelar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
  private
    FService: TServiceLogin;
  end;

implementation

uses
  Providers.Session;

{$R *.dfm}

procedure TFrmLogin.btnEntrarClick(Sender: TObject);
begin
  FService.login(edtUsuario.text, edtSenha.text);
  close;
  modalResult := mrOk;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  FService := TServiceLogin.create(self);
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
  FService.free;
end;

end.
