unit Services.Usuarios;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceUsuarios = class(TServiceBaseCadastro)
    mtPesquisaid: TLargeintField;
    mtPesquisanome: TWideStringField;
    mtPesquisalogin: TWideStringField;
    mtPesquisastatus: TSmallintField;
    mtPesquisatelefone: TWideStringField;
    mtPesquisasexo: TSmallintField;
    mtCadastroid: TLargeintField;
    mtCadastronome: TWideStringField;
    mtCadastrologin: TWideStringField;
    mtCadastrosenha: TWideStringField;
    mtCadastrostatus: TSmallintField;
    mtCadastrotelefone: TWideStringField;
    mtCadastrosexo: TSmallintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtPesquisasexoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    procedure salvar(); override;
    procedure salvarFotoUser(const AFoto: TMemoryStream);
     function downloadFotoUser(): TMemoryStream;
  end;

implementation

uses
  Providers.Request, Providers.Session;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceUsuarios.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
     .baseUrl('http://localhost:9000')
     .resource('usuarios');
end;

procedure TServiceUsuarios.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.asInteger := 1;
  mtCadastrosexo.AsInteger := 0;
end;

procedure TServiceUsuarios.mtPesquisasexoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  text := 'Masculino';
  if sender.asInteger = 1 then
    text := 'Feminino';
end;

procedure TServiceUsuarios.mtPesquisastatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  text := 'Ativo';
  if sender.asInteger = 0 then
    text := 'Inativo';
end;

procedure TServiceUsuarios.salvar;
begin
  mtCadastrosenha.visible := not mtCadastrosenha.AsString.trim().isEmpty;
  inherited;
end;

procedure TServiceUsuarios.salvarFotoUser(const AFoto: TMemoryStream);
begin
  AFoto.position := 0;
  //
  var LResponse := TRequest
      .new
      .baseUrl('http://localhost:9000')
      .resource('usuarios/' + getResourceSuffix() + '/foto')
      .addBody(AFoto)
      .contentType('application/octet-stream')
      .post;
  if LResponse.statusCode <> 204 then
    raise Exception.create(LResponse.content);
end;

function TServiceUsuarios.downloadFotoUser: TMemoryStream;
begin
  result := TMemoryStream.create();
  var LResponse := TRequest
      .new
      .baseUrl('http://localhost:9000')
      .resource('usuarios/' + getResourceSuffix() + '/foto')
      .contentType('application/octet-stream')
      .get;
  if LResponse.statusCode <> 200 then
    exit(result);//raise Exception.create(LResponse.content);
  if length(LResponse.RawBytes) > 0 then
  begin
    result.WriteBuffer(LResponse.RawBytes[0], length(LResponse.RawBytes));
    result.Position := 0;
  end;
end;


end.
