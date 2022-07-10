program Desktop;

uses
  Vcl.Forms,
  Views.Principal in 'src\views\Views.Principal.pas' {frmPrincipal},
  Views.Login in 'src\views\Views.Login.pas' {FrmLogin},
  Services.Login in 'src\services\Services.Login.pas' {ServiceLogin: TDataModule},
  Providers.Session in 'src\providers\Providers.Session.pas',
  Providers.Models.Token in 'src\providers\Models\Providers.Models.Token.pas',
  Views.Base in 'src\views\Views.Base.pas' {frmBase},
  Views.Base.Cadastro in 'src\views\Views.Base.Cadastro.pas' {frmBaseCadastro},
  Services.Base in 'src\services\Services.Base.pas' {ServiceBase: TDataModule},
  Services.Base.Cadastro in 'src\services\Services.Base.Cadastro.pas' {ServiceBaseCadastro: TDataModule},
  Views.Clientes in 'src\views\Views.Clientes.pas' {frmClientes},
  Services.Produtos in 'src\services\Services.Produtos.pas' {ServiceProdutos: TDataModule},
  Views.Produtos in 'src\views\Views.Produtos.pas' {frmProdutos},
  Services.Usuarios in 'src\services\Services.Usuarios.pas' {ServiceUsuarios: TDataModule},
  Views.Usuarios in 'src\views\Views.Usuarios.pas' {frmUsuarios},
  Services.Clientes in 'src\services\Services.Clientes.pas' {ServiceClientes: TDataModule},
  Providers.Request.intf in 'src\providers\request\Providers.Request.intf.pas',
  Providers.Request in 'src\providers\request\Providers.Request.pas',
  Views.Home in 'src\views\Views.Home.pas' {frmHome};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
