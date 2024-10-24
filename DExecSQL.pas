unit DExecSQL;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmExecSQL = class(TDataModule)
    qryExec: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ExecSQL(ASQL: string); overload;
    procedure ExecSQL(ASQL: string; AValues: array of Variant); overload;
    procedure ExecSQL(ASQL: String; ADataSet: TDataSet; ACampos: array of string); overload;
  end;

var
  dmExecSQL: TdmExecSQL;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmExecSQL }

uses DConexao;

procedure TdmExecSQL.ExecSQL(ASQL: String; ADataSet: TDataSet; ACampos: array of string);
var
    i: Integer;
    Campo: String;
begin
    qryExec.SQL.Text := ASQL;
    for i := Low(ACampos) to High(ACampos) do
    begin
        Campo := ACampos[i];
        qryExec.ParamByName(Campo).Value := ADataSet.FieldByName(Campo).Value;
    end;
    qryExec.ExecSQL;
end;



procedure TdmExecSQL.ExecSQL(ASQL: string; AValues: array of Variant);
var
    i: Integer;
begin
    qryExec.SQL.Text := ASQL;
    for i := 0 to qryExec.Params.Count - 1 do
    begin
        qryExec.Params[i].ParamType := ptInput;
        qryExec.Params[i].Value := AValues[i];
    end;
    qryExec.ExecSQL;
end;

procedure TdmExecSQL.ExecSQL(ASQL: string);
begin
    qryExec.SQL.Text := ASQL;
    qryExec.ExecSQL;
end;

end.
