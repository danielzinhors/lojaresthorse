unit Services.Base;

interface

uses
  System.SysUtils, System.Classes, Providers.Request;

type
  TServiceBase = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FRequest: IRequest;
  public
    property Request: IRequest read FRequest write FRequest;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceBase.DataModuleCreate(Sender: TObject);
begin
  FRequest := TRequest.new;
end;

procedure TServiceBase.DataModuleDestroy(Sender: TObject);
begin
  FRequest := nil;
end;

end.
