unit untDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.FBDef,
  FireDAC.Phys.OracleDef, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  FireDAC.Phys.Oracle, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI,
  FireDAC.VCLUI.Login, ODBCUniProvider, AccessUniProvider, InterBaseUniProvider,
  SQLiteUniProvider, SQLServerUniProvider, PostgreSQLUniProvider,
  OracleUniProvider, UniProvider, MySQLUniProvider, MemDS, DBAccess, Uni,
  UniDacVcl;

type
  TDM = class(TDataModule)
    ConOrigem: TUniConnection;
    ConDestino: TUniConnection;
    fdqOrigem: TUniQuery;
    fdqDestino: TUniQuery;
    MySQLUniProvider1: TMySQLUniProvider;
    OracleUniProvider1: TOracleUniProvider;
    PostgreSQLUniProvider1: TPostgreSQLUniProvider;
    SQLServerUniProvider1: TSQLServerUniProvider;
    SQLiteUniProvider1: TSQLiteUniProvider;
    InterBaseUniProvider1: TInterBaseUniProvider;
    AccessUniProvider1: TAccessUniProvider;
    DialogOrigem: TUniConnectDialog;
    DialogDestino: TUniConnectDialog;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FPegaBDOrigem: string;
    FPegaBDDestino: string;
    FQueryOrigem: TUniQuery;
    FQueryDestino: TUniQuery;
    procedure SetPegaBDOrigem(const Value: string);
    procedure SetPegaBDDestino(const Value: string);
    procedure SetQueryOrigem(const Value: TUniQuery);
    procedure SetQueryDestino(const Value: TUniQuery);
    { Private declarations }
  public

    property PegaBDOrigem: string read FPegaBDOrigem write SetPegaBDOrigem;
    property PegaBDDestino: string read FPegaBDDestino write SetPegaBDDestino;
    procedure ExecutaQueryOrigem(pSQL: string);
    {conexao e query para origem}
    function ConexaoOrigem: TUniConnection;
    property QueryOrigem: TUniQuery read FQueryOrigem write SetQueryOrigem;
     {conexao e query para destino}
    function ConexaoDestino: TUniConnection;
    property QueryDestino: TUniQuery read FQueryDestino write SetQueryDestino;

  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

function TDM.ConexaoDestino: TUniConnection;
begin
  Result := ConDestino;
end;

function TDM.ConexaoOrigem: TUniConnection;
begin
  Result := ConOrigem;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  fdqOrigem.Connection := ConexaoOrigem;
  fdqDestino.Connection := ConDestino;
  QueryDestino := fdqDestino;
  QueryOrigem := fdqOrigem;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  ConOrigem.Free;
  ConDestino.Free;
end;

procedure TDM.ExecutaQueryOrigem(pSQL: string);
begin
  QueryOrigem.Close;
  QueryOrigem.SQL.Clear;
  QueryOrigem.SQL.Text := pSQL;
  QueryOrigem.Open;
end;

procedure TDM.SetPegaBDDestino(const Value: string);
begin
  FPegaBDDestino := Value;
end;

procedure TDM.SetPegaBDOrigem(const Value: string);
begin
  FPegaBDOrigem := Value;
end;

procedure TDM.SetQueryDestino(const Value: TUniQuery);
begin
  FQueryDestino := Value;
end;

procedure TDM.SetQueryOrigem(const Value: TUniQuery);
begin
  FQueryOrigem := Value;
end;
end.
