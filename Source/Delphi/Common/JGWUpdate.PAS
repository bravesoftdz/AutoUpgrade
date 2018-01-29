unit JGWUpdate;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Transfer;

type
  /// <summary>
  ///   ���¼������
  /// </summary>
  TChkType = (
    /// <summary>
    ///   ��
    /// </summary>
    chkNone,
    /// <summary>
    ///   �����ļ��汾���
    /// </summary>
    chkByVersion,
    /// <summary>
    ///   �������ڼ��
    /// </summary>
    chkByDate,
    /// <summary>
    ///   �����ļ���С���
    /// </summary>
    chkBySize,
    /// <summary>
    ///   Դ�ļ������ڵ��½�ģʽ
    /// </summary>
    chkCreat);
  /// <summary>
  ///   ���µķ�ʽ
  /// </summary>
  TUpdateType = (
    /// <summary>
    ///   �������£������ļ��������Ǿ��ļ���
    /// </summary>
    upCopy,
    /// <summary>
    ///   ִ�и��� ��ִ��һ�����³��������¡�
    /// </summary>
    upExecute);

  /// <summary>
  ///   ���¶������
  /// </summary>
  /// <remarks>
  ///   �����˸��¶���Ļ�����Ϣ
  /// </remarks>
  TUpdate = class(TPersistent)
  private
    FChkType: TChkType;
    FFileName: string;
    FLocalFile: string;
    FNewDate: TDateTime;
    FNewVersion: string;
    FTempPath: string;
    FTransferObj: TTransfer;
    FUpdateType: TUpdateType;
    FUpdateURL: string;
    FNewSize: Int64;
  protected
    function GetChkType: TChkType; virtual;
    function GetFileName: string; virtual;
    function GetLocalFile: string; virtual;
    function GetNewDate: TDateTime; virtual;
    function GetNewVersion: string; virtual;
    function GetTempPath: string; virtual;
    function GetTransferObj: TTransfer; virtual;
    function GetUpdateType: TUpdateType; virtual;
    function GetUpdateURL: string; virtual;
    procedure SetChkType(Value: TChkType); virtual;
    procedure SetFileName(const Value: string); virtual;
    procedure SetLocalFile(const Value: string); virtual;
    procedure SetNewDate(Value: TDateTime); virtual;
    procedure SetNewVersion(const Value: string); virtual;
    procedure SetTempPath(const Value: string); virtual;
    procedure SetTransferObj(Value: TTransfer); virtual;
    procedure SetUpdateType(Value: TUpdateType); virtual;
    procedure SetUpdateURL(const Value: string); virtual;
    function GetNewSize: Int64; virtual;
    procedure SetNewSize(const Value: Int64); virtual;
  public
    /// <summary>
    ///   �������·�ʽ������ָ�����·�ʽ�Ķ��󲢷��ء�
    /// </summary>
    function Analyse: TUpdate; virtual; abstract;
    /// <summary>
    ///   ��Ϣ��fu'zhi
    /// </summary>
    procedure AssignTo(Dest: TPersistent); override;
    /// <summary>
    ///   �������ݵ�ָ��·����
    /// </summary>
    /// <param name="FileName">
    ///   �ļ������·��
    /// </param>
    procedure Download(FileName: String); overload; virtual; abstract;
    /// <summary>
    ///   �������ݵ���
    /// </summary>
    /// <param name="Stream">
    ///   ��
    /// </param>
    procedure Download(Stream: TStream); overload; virtual; abstract;
    /// <summary>
    ///   �����ļ�
    /// </summary>
    /// <returns>
    ///   ִ�и��¶�����
    /// </returns>
    function UpdateIt: Boolean; virtual; abstract;
    /// <summary>
    ///   �������
    /// </summary>
    /// <value>
    ///   �ο�TchkType
    /// </value>
    /// <seealso cref="TchkType">
    ///   TchkType
    /// </seealso>
    property ChkType: TChkType read GetChkType write SetChkType;
    /// <summary>
    ///   �����ļ��� �ļ�����
    /// </summary>
    property FileName: string read GetFileName write SetFileName;
    /// <summary>
    ///   �����ļ������·����
    /// </summary>
    property LocalFile: string read GetLocalFile write SetLocalFile;
    /// <summary>
    ///   ���ļ�������
    /// </summary>
    property NewDate: TDateTime read GetNewDate write SetNewDate;
    /// <summary>
    ///   ���ļ��İ汾
    /// </summary>
    property NewVersion: string read GetNewVersion write SetNewVersion;
    /// <summary>
    ///   ��ʱ�ļ���·�������ļ���
    /// </summary>
    property TempPath: string read GetTempPath write SetTempPath;
    /// <summary>
    ///   �������
    /// </summary>
    property TransferObj: TTransfer read GetTransferObj write SetTransferObj;
    /// <summary>
    ///   ��������
    /// </summary>
    /// <seealso cref="TUpdateType">
    ///   TUpdateType
    /// </seealso>
    property UpdateType: TUpdateType read GetUpdateType write SetUpdateType;
    /// <summary>
    ///   ���������ļ��ĵ�ַURL
    /// </summary>
    property UpdateURL: string read GetUpdateURL write SetUpdateURL;
    /// <summary>
    ///   ���ļ��Ĵ�С
    /// </summary>
    property NewSize: Int64 read GetNewSize write SetNewSize;
  end;
  
  TFileUpdate = class(TUpdate)
  protected
  public
    /// <summary>
    ///   �������ݵ�ָ�����ļ�
    /// </summary>
    procedure Download(FileName: String); overload; override;
    /// <summary>
    ///   �ļ����µĻ���ʵ���࣬��ʵ���˻����ĸ�������Ϣ�Ͳ���������������װ����ʵ��Copy���º�ִ�и��¡�
    /// </summary>
    /// <seealso cref="TUpdate">
    ///   TUpdate
    /// </seealso>
    function Analyse: TUpdate; override;
    /// <summary>
    ///   �������ݵ�liu
    /// </summary>
    procedure Download(Stream: TStream); overload; override;
    /// <summary>
    ///   ִ�и��£���ʵ��ִ������װ��������ɵġ�
    /// </summary>
    function UpdateIt: Boolean; override;
  end;
  
  /// <summary>
  ///   װ�������
  /// </summary>
  TUpdateDecorator = class(TUpdate)
  private
    FOwnsUpdate: Boolean;
    FUpdate: TUpdate;
    function GetUpdate: TUpdate;
    procedure SetUpdate(Value: TUpdate);
  protected
    function GetChkType: TChkType; override;
    function GetFileName: string; override;
    function GetLocalFile: string; override;
    function GetNewDate: TDateTime; override;
    function GetNewVersion: string; override;
    function GetTempPath: string; override;
    function GetTransferObj: TTransfer; override;
    function GetUpdateType: TUpdateType; override;
    function GetUpdateURL: string; override;
    procedure SetChkType(Value: TChkType); override;
    procedure SetFileName(const Value: string); override;
    procedure SetLocalFile(const Value: string); override;
    procedure SetNewDate(Value: TDateTime); override;
    procedure SetNewVersion(const Value: string); override;
    procedure SetTempPath(const Value: string); override;
    procedure SetTransferObj(Value: TTransfer); override;
    procedure SetUpdateType(Value: TUpdateType); override;
    procedure SetUpdateURL(const Value: string); override;
    function GetNewSize: Int64; override;
    procedure SetNewSize(const Value: Int64); override;
  public
    /// <summary>
    ///   ���캯��
    /// </summary>
    /// <param name="AUpdate">
    ///   �������ִ���ࡣ
    /// </param>
    constructor Create(AUpdate: TUpdate);
    /// <summary>
    ///   ��������
    /// </summary>
    destructor Destroy; override;
    /// <summary>
    ///   �Ƿ���������Update������Ĭ��ΪTrue
    /// </summary>
    /// <value>
    ///   Ĭ��ΪTrue
    /// </value>
    property OwnsUpdate: Boolean read FOwnsUpdate write FOwnsUpdate;
    /// <summary>
    ///   ��������
    /// </summary>
    property Update: TUpdate read GetUpdate write SetUpdate;
  end;
  
  /// <summary>
  ///   Copy��ʽʵ����
  /// </summary>
  TCopyUpdate = class(TUpdateDecorator)
  protected
  public
    function Analyse: TUpdate; override;
    procedure Download(FileName: String); overload; override;
    procedure Download(Stream: TStream); overload; override;
    function UpdateIt: Boolean; override;
  end;
  
  /// <summary>
  ///   ִ�з�ʽʵ����
  /// </summary>
  TExecuteUpdate = class(TUpdateDecorator)
  protected
  public
    function Analyse: TUpdate; override;
    procedure Download(FileName: String); overload; override;
    procedure Download(Stream: TStream); overload; override;
    function UpdateIt: Boolean; override;
  end;


  TUpdateDecoratorClass = Class of TUpdateDecorator;

  TUpdateDecoratorFactory = class
  public
    class function CreateUpdateDecorator(UpdateDecoratorClass:
        TUpdateDecoratorClass; UpdateObj: TUpDate): TUpdateDecorator;
  end;

  const
    UpdateClassArray:array[0..1] of TUpdateDecoratorClass=(TCopyUpdate, TExecuteUpdate);


implementation

uses AnalyserCmd, FmxUtils, uFileAction, System.IOUtils;

{
*********************************** TUpdate ************************************
}
procedure TUpdate.AssignTo(Dest: TPersistent);
var
  Update: TUpdate;
begin
  Update := Dest as TUpdate;
  UpDate.FileName := Self.FileName;
  Update.LocalFile := self.LocalFile;
  Update.NewDate := self.NewDate;
  Update.NewVersion := self.NewVersion;
  Update.TempPath := self.TempPath;
  Update.UpdateURL := self.UpdateURL;
  Update.ChkType := self.ChkType;
  Update.NewSize := self.NewSize;
  Update.UpdateType := self.UpdateType;
end;

function TUpdate.GetChkType: TChkType;
begin
  Result := FChkType;
end;

function TUpdate.GetFileName: string;
begin
  Result := FFileName;
end;

function TUpdate.GetLocalFile: string;
begin
  Result := FLocalFile;
end;

function TUpdate.GetNewDate: TDateTime;
begin
  Result := FNewDate;
end;

function TUpdate.GetNewVersion: string;
begin
  Result := FNewVersion;
end;

function TUpdate.GetTempPath: string;
begin
  Result := FTempPath;
end;

function TUpdate.GetTransferObj: TTransfer;
begin
  Result := FTransferObj;
end;

function TUpdate.GetUpdateType: TUpdateType;
begin
  Result := FUpdateType;
end;

function TUpdate.GetUpdateURL: string;
begin
  Result := FUpdateURL;
end;

procedure TUpdate.SetChkType(Value: TChkType);
begin
  FChkType := Value;
end;

procedure TUpdate.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TUpdate.SetLocalFile(const Value: string);
begin
  FLocalFile := Value;
  
end;

procedure TUpdate.SetNewDate(Value: TDateTime);
begin
  FNewDate := Value;
end;

procedure TUpdate.SetNewVersion(const Value: string);
begin
  FNewVersion := Value;
end;

procedure TUpdate.SetTempPath(const Value: string);
begin
  FTempPath := Value;
end;

procedure TUpdate.SetTransferObj(Value: TTransfer);
begin
  FTransferObj := Value;
end;

procedure TUpdate.SetUpdateType(Value: TUpdateType);
begin
  // TODO -cMM: TUpdate.SetUpdateType default body inserted
  FUpdateType := Value;
end;

procedure TUpdate.SetUpdateURL(const Value: string);
begin
  FUpdateURL := Value;
end;

function TUpdate.GetNewSize: Int64;
begin
  Result := FNewSize;
end;

procedure TUpdate.SetNewSize(const Value: Int64);
begin
  FNewSize := Value;
end;

{
********************************* TFileUpdate **********************************
}
function TFileUpdate.Analyse: TUpdate;
var
  Anaslyse: TAnalyseCmd;
begin
  Anaslyse := TAnalyseCmdFactory.CreateAnalyseCmd(ChkTypeArrar[Integer(self.chkType)]);
  Result := Anaslyse.Run(self as TUpdate);
  FreeAndNil(Anaslyse);
end;

procedure TFileUpdate.Download(FileName: String);
begin
  if (Assigned(TransferObj)) then
    TransferObj.Get(FileName);
end;

procedure TFileUpdate.Download(Stream: TStream);
begin
  if (Assigned(TransferObj)) then
    TransferObj.Get(Stream);
end;

function TFileUpdate.UpdateIt: Boolean;
begin
  Result := true
end;

{
******************************* TUpdateDecorator *******************************
}
constructor TUpdateDecorator.Create(AUpdate: TUpdate);
begin
  inherited Create;
  Update := AUpdate;
  FOwnsUpdate := True;
end;

destructor TUpdateDecorator.Destroy;
begin
  Update := nil;
  if (Assigned(FUpdate)) and FOwnsUpdate then
    FreeAndNil(FUpdate);
  inherited Destroy;
end;

function TUpdateDecorator.GetChkType: TChkType;
begin
  Result := FUpdate.GetChkType;
end;

function TUpdateDecorator.GetFileName: string;
begin
  Result := FUpdate.GetFileName;
end;

function TUpdateDecorator.GetLocalFile: string;
begin
  Result := FUpdate.GetLocalFile;
end;

function TUpdateDecorator.GetNewDate: TDateTime;
begin
  Result := FUpdate.GetNewDate;
end;

function TUpdateDecorator.GetNewVersion: string;
begin
  Result := FUpdate.GetNewVersion;
end;

function TUpdateDecorator.GetTempPath: string;
begin
  Result := FUpdate.GetTempPath;
end;

function TUpdateDecorator.GetTransferObj: TTransfer;
begin
  Result := FUpdate.GetTransferObj;
end;

function TUpdateDecorator.GetUpdate: TUpdate;
begin
  Result := FUpdate;
end;

function TUpdateDecorator.GetUpdateType: TUpdateType;
begin
  Result := FUpdate.GetUpdateType;
end;

function TUpdateDecorator.GetUpdateURL: string;
begin
  Result := FUpdate.GetUpdateURL;
end;

procedure TUpdateDecorator.SetChkType(Value: TChkType);
begin
  FUpdate.SetChkType(Value);
end;

procedure TUpdateDecorator.SetFileName(const Value: string);
begin
  FUpdate.SetFileName(Value);
end;

procedure TUpdateDecorator.SetLocalFile(const Value: string);
begin
  FUpdate.SetLocalFile(Value);
end;

procedure TUpdateDecorator.SetNewDate(Value: TDateTime);
begin
  FUpdate.SetNewDate(Value);
end;

procedure TUpdateDecorator.SetNewVersion(const Value: string);
begin
  FUpdate.SetNewVersion(Value);
end;

procedure TUpdateDecorator.SetTempPath(const Value: string);
begin
  FUpdate.SetTempPath(Value);
end;

procedure TUpdateDecorator.SetTransferObj(Value: TTransfer);
begin
  FUpdate.SetTransferObj(Value);
end;

procedure TUpdateDecorator.SetUpdate(Value: TUpdate);
begin
  if Value <> FUpdate then
  begin
    if OwnsUpdate then FUpdate.Free;
      FUpdate := Value;
  end;
end;

procedure TUpdateDecorator.SetUpdateType(Value: TUpdateType);
begin
  FUpdate.SetUpdateType(Value);
end;

procedure TUpdateDecorator.SetUpdateURL(const Value: string);
begin
  FUpdate.SetUpdateURL(Value);
end;

function TUpdateDecorator.GetNewSize: Int64;
begin
  Result := FUpdate.GetNewSize;
end;

procedure TUpdateDecorator.SetNewSize(const Value: Int64);
begin
  FUpdate.SetNewSize(Value);
end;


{
********************************* TCopyUpdate **********************************
}
function TCopyUpdate.Analyse: TUpdate;
begin
  Result := Self;
end;

procedure TCopyUpdate.Download(FileName: String);
begin
  Update.Download(FileName);
end;

procedure TCopyUpdate.Download(Stream: TStream);
begin
  Update.Download(Stream);
end;

function TCopyUpdate.UpdateIt: Boolean;
begin
  try
    if not TDirectory.Exists(ExtractFilePath(LocalFile)) then
      TDirectory.CreateDirectory(ExtractFilePath(LocalFile));

    MoveFile(TempPath, LocalFile);
    Result := true;
  except
    Result := false;
  end;
end;

{
******************************** TExecuteUpdate ********************************
}
function TExecuteUpdate.Analyse: TUpdate;
begin
  Result := Self;
end;

procedure TExecuteUpdate.Download(FileName: String);
begin
  Update.Download(FileName);
end;

procedure TExecuteUpdate.Download(Stream: TStream);
begin
  Update.Download(Stream);
end;

function TExecuteUpdate.UpdateIt: Boolean;
var
  FileAction : TFileAction;
begin
  FileAction := TFileAction.Create(Update.TempPath);
  try
    try
      if FileAction.Execute(SW_SHOWNORMAL) <> INFINITE then
      begin
         //MoveFile(Update.TempPath, Update.LocalFile);
         Result := true;
      end
      else
        Result := false;
    except
      Result := false;
    end;

  finally
    FreeAndNil(FileAction);
  end;
end;

class function TUpdateDecoratorFactory.CreateUpdateDecorator(
    UpdateDecoratorClass: TUpdateDecoratorClass; UpdateObj: TUpDate):
    TUpdateDecorator;
begin
  // TODO -cMM: TUpdateDecoratorFactory.CreateUpdateDecorator default body inserted
  Result := UpdateDecoratorClass.Create(UpdateObj);
end;


end.