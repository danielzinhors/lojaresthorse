unit Services.Base.Cadastro;

interface

uses
  System.SysUtils, System.Classes, Services.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.json;

type
  TServiceBaseCadastro = class(TServiceBase)
    mtPesquisa: TFDMemTable;
    mtCadastro: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
     FRecords, FPageLimit, FPage, FPages: integer;
     function getCampoChave: String;
  public
    property records: integer read FRecords write FRecords;
    property pageLimit: integer read FPageLimit write FPageLimit;
    property page: integer read FPage write FPage;
    property pages: integer read FPages write FPages;
    procedure listarRegistros(); virtual;
    procedure incluir(); virtual;
    procedure salvar(); virtual;
    procedure alterar(); virtual;
    procedure excluir(); virtual;
     function getResourceSuffix(): String;
  end;

implementation

uses
  Providers.Request, DataSet.serialize, Providers.Session;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServiceBaseCadastro }

procedure TServiceBaseCadastro.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FRecords := 0;
  FPageLimit := 50;
  FPage := 1;
  FPages := 1;
end;

procedure TServiceBaseCadastro.alterar();
begin
  if (not mtPesquisa.active) or (mtPesquisa.IsEmpty) then
    raise Exception.create('Escolha um registro para poder editar!');
  try
    var LResponse := request
                    .ResourceSuffix(getResourceSuffix())
                    .get;
    if LResponse.StatusCode <> 200 then
      raise Exception.Create(LResponse.content);
    if mtCadastro.active then
      mtCadastro.EmptyDataSet;
    mtCadastro.LoadFromJSON(LResponse.content);
    mtCadastro.edit;
  finally
  end;
end;

procedure TServiceBaseCadastro.excluir();
begin
  if (not mtPesquisa.active) or (mtPesquisa.IsEmpty) then
    raise Exception.create('Escolha um registro para poder excluir!');
  try
    var LResponse := request
                    .ResourceSuffix(getResourceSuffix())
                    .delete;
    if LResponse.StatusCode <> 204 then
      raise Exception.Create(LResponse.content);
    mtPesquisa.delete;
  finally
  end;
end;

function TServiceBaseCadastro.getCampoChave(): String;
begin
  for var LField in mtPesquisa.fields do
  begin
    if pfInKey in Lfield.providerFlags then
      exit(LField.FieldName);
  end;
end;

function TServiceBaseCadastro.getResourceSuffix(): String;
begin
  if mtCadastro.state = dsEdit then
    mtPesquisa.locate('id', mtCadastro.fieldByName(getCampoChave()).asString, []);
  for var LField in mtPesquisa.fields do
  begin
    if pfInKey in Lfield.providerFlags then
      exit(LField.asString);
  end;
end;

procedure TServiceBaseCadastro.incluir();
begin
  if not mtCadastro.active then
    mtCadastro.open;
  mtCadastro.append;
end;

procedure TServiceBaseCadastro.listarRegistros();
var
  LResponse: IResponse;
begin
  mtPesquisa.DisableControls;
  try
    LResponse := request
                  .ResourceSuffix(EmptyStr)
                  .ClearParams
                  .AddParam('limit', FPageLimit.toString)
                  .addParam('offset', (Pred(FPage) * FPageLimit).toString)
                  .get;
    if LResponse.StatusCode <> 200 then
      raise Exception.Create(LResponse.content);
    if mtPesquisa.active then
      mtPesquisa.EmptyDataSet;
    mtPesquisa.loadFromJSON(LResponse.JSONValue.getValue<TJSONArray>('data'), false);
    FRecords := LResponse.JSONValue.getValue<integer>('records');
  finally
    mtPesquisa.EnableControls;
  end;
end;

procedure TServiceBaseCadastro.salvar();
var
  LResponse: IResponse;
begin
  mtPesquisa.DisableControls;
  try
    request
          .ClearBody
          .AddBody(mtCadastro.ToJSONObject());
    if mtCadastro.state = dsEdit then
      LResponse := request
                     .ResourceSuffix(getResourceSuffix())//mtCadastro.fieldByName(getCampoChave()).asString)
                     .put
    else
      LResponse := request
                    .ResourceSuffix(EmptyStr)
                    .post;
    if not LResponse.StatusCode in [201, 204] then
      raise Exception.Create(LResponse.content);
    if not mtPesquisa.active then
      mtPesquisa.open;
    if mtCadastro.state = dsEdit then
      mtPesquisa.mergeFromJSONObject(mtCadastro.ToJSONObject())
    else
      mtPesquisa.LoadFromJSON(LResponse.content);
    mtCadastro.cancel;
  finally
    mtPesquisa.EnableControls;
  end;
end;

end.
