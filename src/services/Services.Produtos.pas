unit Services.Produtos;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceProdutos = class(TServiceBaseCadastro)
    mtPesquisaid: TLargeintField;
    mtPesquisanome: TWideStringField;
    mtPesquisavalor: TFMTBCDField;
    mtPesquisastatus: TSmallintField;
    mtPesquisaestoque: TFMTBCDField;
    mtCadastroid: TLargeintField;
    mtCadastronome: TWideStringField;
    mtCadastrovalor: TFMTBCDField;
    mtCadastrostatus: TSmallintField;
    mtCadastroestoque: TFMTBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceProdutos.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
     .baseUrl('http://localhost:9000')
     .resource('produtos');
end;

procedure TServiceProdutos.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.asInteger := 1;
end;

procedure TServiceProdutos.mtPesquisastatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  text := 'Ativo';
  if sender.asInteger = 0 then
    text := 'Inativo';
end;

end.
