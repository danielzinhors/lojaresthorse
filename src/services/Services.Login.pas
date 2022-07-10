unit Services.Login;

interface

uses
  System.SysUtils, System.Classes;

type
  TServiceLogin = class(TDataModule)
  private
    { Private declarations }
  public
    procedure login(const AUsername, ASenha: String);
  end;

implementation

uses
  System.JSON, Providers.Request, Providers.Session;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServiceLogin }

procedure TServiceLogin.login(const AUsername, ASenha: String);
begin
  if AUsername.trim.isEmpty or ASenha.trim.isEmpty then
    raise Exception.create('Informe o usuário e senha!');
  var LJSON := TJSONObject.create()
     .addPair('username', AUsername)
     .addPair('senha', ASenha);
  var LResponse := TRequest
                      .new
                      .baseURL('http://localhost:9001')
                      .resource('login')
                      .addBody(LJSON)
                      .post;
  if LResponse.StatusCode <> 200 then
    raise exception.create(LResponse.JSONValue.GetValue<string>('error'));
  TSession.getInstance().token.Access := LResponse.JSONValue.GetValue<string>('access');
  TSession.getInstance().token.Refresh := LResponse.JSONValue.GetValue<string>('refresh');
end;

end.
