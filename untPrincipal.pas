unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxPC,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.ComCtrls, dxBarBuiltInMenu, untDM, untEstados, Vcl.Menus, Vcl.ToolWin,
  Vcl.PlatformDefaultStyleActnCtrls, System.Actions, Vcl.ActnList, Vcl.ActnMan,
  Vcl.ActnCtrls;

type
  TfrmPrincipal = class(TForm)
    pcPrincipal: TcxPageControl;
    tbsOrigem: TcxTabSheet;
    tbsDestino: TcxTabSheet;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    stat1: TStatusBar;
    grp1: TGroupBox;
    Timer1: TTimer;
    grp2: TGroupBox;
    tbsTabelas: TcxTabSheet;
    btnDesconectarOrigem: TButton;
    btnDesconectarDestino: TButton;
    PopupMenuEstado: TPopupMenu;
    tlb1: TToolBar;
    btn2: TToolButton;
    IMPORTARESTADOS1: TMenuItem;
    UPDATEESTADOS1: TMenuItem;
    lblposicao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDesconectarOrigemClick(Sender: TObject);
    procedure pcPrincipalClick(Sender: TObject);
    procedure btnDesconectarDestinoClick(Sender: TObject);
    procedure IMPORTARESTADOS1Click(Sender: TObject);
  private
    
  public
    procedure VerificaEstado;
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  vSql_Origem : TStringList;
  vEstados: TEstados;

implementation

{$R *.dfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.btnDesconectarDestinoClick(Sender: TObject);
begin
  if DM.DialogDestino.Connection.Connected then
  begin
    DM.DialogDestino.Connection.Close;
    VerificaEstado;
    ShowMessage('Conexão de destino desconectado.');
  end;
end;

procedure TfrmPrincipal.btnDesconectarOrigemClick(Sender: TObject);
begin
  if DM.DialogOrigem.Connection.Connected then
  begin
    DM.DialogOrigem.Connection.Close;
    VerificaEstado;
    ShowMessage('Conexão de origem desconectado.');
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vSql_Origem.Free;
  vEstados.Free;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Width := 658;
  Height := 218;
  tbsDestino.TabVisible := False;
  tbsTabelas.TabVisible := False;
  pcPrincipal.ActivePage := tbsOrigem;
  vSql_Origem := TStringList.Create;
  vEstados := TEstados.Create;
end;

procedure TfrmPrincipal.IMPORTARESTADOS1Click(Sender: TObject);
var
  vCaminho: string;
begin
  if OpenDialog1.Execute then
  begin
    vCaminho := OpenDialog1.FileName;
  end;

    if Length(vCaminho) <= 0 then
      raise Exception.Create('Campo sql de origem está vazio');

     vSql_Origem.LoadFromFile(vCaminho);
     DM.ExecutaQueryOrigem(vSql_Origem.Text);
     vEstados.CopiarEstados;
end;

procedure TfrmPrincipal.pcPrincipalClick(Sender: TObject);
begin
  case pcPrincipal.ActivePageIndex of
  0:begin
      if DM.DialogOrigem.Connection.Connected then
      begin
       if btnDesconectarOrigem.CanFocus then
        btnDesconectarOrigem.SetFocus;
      end;

      if (not DM.DialogOrigem.Connection.Connected) then
      begin
        if DM.DialogOrigem.Execute then
        begin
          if DM.DialogOrigem.Connection.Connected then
          begin
            VerificaEstado;
          end;
        end;
      end;
    end;

    1:begin
      if DM.DialogDestino.Connection.Connected then
      begin
       if btnDesconectarDestino.CanFocus then
        btnDesconectarDestino.SetFocus;
      end;

      if (not DM.DialogDestino.Connection.Connected) then
      begin
        if DM.DialogDestino.Execute then
        begin
          if DM.DialogDestino.Connection.Connected then
          begin
            VerificaEstado;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmPrincipal.VerificaEstado;
begin
  if DM.DialogOrigem.Connection.Connected then
    begin
      DM.PegaBDOrigem := 'Conectado.';
      if DM.DialogDestino.Connection.Connected then
      begin
        DM.PegaBDDestino := 'Conectado.';
        tbsTabelas.TabVisible := True;
      end
      else
      begin
        tbsTabelas.TabVisible := False;
      end;
      stat1.Panels[0].Text := 'Data: ' + FormatDateTime('dd/mm/yy', Now)+'   '+'Hora: '+ TimeToStr(Time);
      stat1.Panels[1].Text := 'Banco Origem: ' + DM.PegaBDOrigem;
      stat1.Panels[2].Text := 'Banco Destino: ' + DM.PegaBDDestino;
      tbsDestino.TabVisible := True;
      if tbsDestino.CanFocus then
        tbsDestino.SetFocus;
    end
    else
    begin
      DM.DialogDestino.Connection.Close;
      stat1.Panels[0].Text := 'Desconectado';
      stat1.Panels[1].Text := 'Desconectado';
      stat1.Panels[2].Text := 'Desconectado';
      tbsDestino.TabVisible := False;
      tbsTabelas.TabVisible := False;
    end;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;
end.
