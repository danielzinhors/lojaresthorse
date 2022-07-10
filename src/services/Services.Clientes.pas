unit Services.Clientes;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceClientes = class(TServiceBaseCadastro)
    mtPesquisaid: TLargeintField;
    mtPesquisanome: TWideStringField;
    mtPesquisastatus: TSmallintField;
    mtCadastroid: TLargeintField;
    mtCadastronome: TWideStringField;
    mtCadastrostatus: TSmallintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceClientes: TServiceClientes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceClientes.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
     .baseUrl('http://localhost:9000')
     .resource('clientes');
end;

procedure TServiceClientes.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.asInteger := 1;
end;

procedure TServiceClientes.mtPesquisastatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  text := 'Ativo';
  if sender.asInteger = 0 then
    text := 'Inativo';
end;

end.
