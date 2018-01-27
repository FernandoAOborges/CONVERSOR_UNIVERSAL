unit untEstados;

interface

uses
  untDM;


type
  TEstados = class
  private
    { private declarations }
  public
    procedure CopiarEstados;
  end;

const
  SQL_VERIFICA_ESTADO = 'SELECT COD_ESTADO, '+
                        '       COD_PAIS,   '+
                        '       SGL_ESTADO, '+
                        '       NOM_ESTADO  '+
                        ' FROM ESTADO where NOM_ESTADO = ';


  SQL_ESTADO_INSERT =  'INSERT INTO ESTADO' +
                       '  (COD_ESTADO,' +
                       '   COD_PAIS,' +
                       '   SGL_ESTADO,' +
                       '   NOM_ESTADO)' +
                       'VALUES' +
                       '  (:COD_ESTADO,' +
                       '   :COD_PAIS,' +
                       '   :SGL_ESTADO,' +
                       '   :NOM_ESTADO)';

implementation

uses
  System.SysUtils, untPrincipal, Vcl.Dialogs, Vcl.Forms;

{ TEstados }

procedure TEstados.CopiarEstados;
var
  vInt: Integer;
begin
  DM.ConexaoDestino.StartTransaction;
  try
    DM.QueryOrigem.First;
    vInt := 0;
    while not DM.QueryOrigem.Eof do
    begin
      Inc(vInt);
      frmPrincipal.Caption := 'Inserindo Estados - ' + IntToStr(vInt);
      frmPrincipal.lblposicao.Caption := 'Inserindo Estados - ' + IntToStr(vInt);
      Application.ProcessMessages;
      if Length(Trim(DM.QueryOrigem.FieldByName('NOM_ESTADO').AsString)) <> 0 then
      begin
        DM.QueryDestino.Close;   
        DM.QueryDestino.SQL.Text := SQL_VERIFICA_ESTADO + QuotedStr(DM.QueryOrigem.FieldByName('NOM_ESTADO').AsString);
        DM.QueryDestino.Open;
        if DM.QueryDestino.IsEmpty then
        begin
          DM.QueryDestino.SQL.Text := SQL_ESTADO_INSERT;
          DM.QueryDestino.ParamByName('COD_ESTADO').AsString :=   DM.QueryOrigem.FieldByName('COD_ESTADO').AsString;
          DM.QueryDestino.ParamByName('COD_PAIS').AsString   :=   DM.QueryOrigem.FieldByName('COD_PAIS').AsString;
          DM.QueryDestino.ParamByName('SGL_ESTADO').AsString :=   DM.QueryOrigem.FieldByName('SGL_ESTADO').AsString;
          DM.QueryDestino.ParamByName('NOM_ESTADO').AsString :=   DM.QueryOrigem.FieldByName('NOM_ESTADO').AsString;
          DM.QueryDestino.ExecSQL;
        end
        else
        begin
          frmPrincipal.Caption := EmptyStr;
          frmPrincipal.lblposicao.Caption := EmptyStr;
          raise Exception.Create('Tabela de destino não está vazia, verifique opção de update!');
        end;                                                                
      end;
      DM.QueryOrigem.Next;
    end;
    DM.ConexaoDestino.Commit;
    ShowMessage('Estados importado com sucesso!');
  except on E: Exception do
  begin
    DM.ConexaoDestino.Rollback;
    raise Exception.CreateFmt('Erro ao inserir Estado : %s',[E.Message]);
  end;
  end;
end;
end.
