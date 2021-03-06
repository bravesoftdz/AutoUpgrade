program AutoUpdate;

uses
  Forms,
  Analyse in '..\..\Common\Analyse.PAS',
  AnalyserCmd in '..\..\Common\AnalyserCmd.PAS',
  AppInfo in '..\..\Common\AppInfo.PAS',
  FmxUtils in '..\..\Common\FmxUtils.pas',
  Transfer in '..\..\Common\Transfer.pas',
  uFileAction in '..\..\Common\uFileAction.pas',
  Update in '..\..\Common\Update.PAS',
  FSeting in '..\..\UI\FSeting.pas' {frmSeting},
  FUpdate in '..\..\UI\FUpdate.pas' {frmAutoUpdate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmAutoUpdate, frmAutoUpdate);
  Application.CreateForm(TfrmSeting, frmSeting);
  Application.Run;
end.
