unit AnalyserCmd;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, JGWUpdate;

type
  TAnalyseCmd = class(TObject)
  protected
    function CreateUpdateDecorator(UpDate: TUpdate): TUpdateDecorator; virtual;
  public
    function Run(Update: TUpdate): TUpdate; virtual; abstract;
  end;
  
  TVersionAnalyse = class(TAnalyseCmd)
  public
    function Run(Update: TUpdate): TUpdate; override;
  end;
  
  TDefaultAnalyse = class(TAnalyseCmd)
  public
    function Run(Update: TUpdate): TUpdate; override;
  end;
  
  TAnalyseCmdClass = Class of TAnalyseCmd;

  TDateAnalyse = class(TAnalyseCmd)
  public
    function Run(Update: TUpdate): TUpdate; override;
  end;
  
  TSizeAnalyse = class(TAnalyseCmd)
  public
    function Run(Update: TUpdate): TUpdate; override;
  end;
  
  TCreateAnalyse = class(TAnalyseCmd)
  public
    function Run(Update: TUpdate): TUpdate; override;
  end;
  
  TAnalyseCmdFactory = class(TObject)
  public
    class function CreateAnalyseCmd(AnalyseCmdClass: TAnalyseCmdClass):
            TAnalyseCmd;
  end;
  
  const
    ChkTypeArrar:array[0..4] of TAnalyseCmdClass=(TDefaultAnalyse,
                                                  TVersionAnalyse,
                                                  TDateAnalyse,
                                                  TSizeAnalyse,
                                                  TCreateAnalyse);


implementation

uses uFileAction;

{
********************************* TAnalyseCmd **********************************
}
function TAnalyseCmd.CreateUpdateDecorator(UpDate: TUpdate): TUpdateDecorator;
begin
  try
    Result := TUpdateDecoratorFactory.CreateUpdateDecorator(UpdateClassArray[Integer(Update.UpdateType)], Update);
  except
    Raise;
  end;
end;

{
******************************* TVersionAnalyse ********************************
}
function TVersionAnalyse.Run(Update: TUpdate): TUpdate;
var
  NewUpdate: TUpdate;
  FileAction: TFileAction;
begin
  //Update.LocalFile
  Result := nil;
  FileAction := TFileAction.Create(Update.LocalFile);
  try
    if (FileAction.FileExit) then
      begin
      if Update.NewVersion > FileAction.GetFileVersionAsText then
      begin
        NewUpdate := TFileUpdate.Create;
        NewUpdate.Assign(Update);
        Result := CreateUpdateDecorator(NewUpdate);
      end;
    end;
  finally
    FreeAndNil(FileAction);
  end;
end;

{
******************************* TDefaultAnalyse ********************************
}
function TDefaultAnalyse.Run(Update: TUpdate): TUpdate;
var
  NewUpdate: TUpdate;
begin
  // TODO -cMM: TDefaultAnalyse.Run default body inserted
  NewUpdate := TFileUpdate.Create;
  NewUpdate.Assign(Update);
  Result := CreateUpdateDecorator(NewUpdate);
end;

{
********************************* TDateAnalyse *********************************
}
function TDateAnalyse.Run(Update: TUpdate): TUpdate;
var
  FileAction: TFileAction;
  NewUpdate: TUpdate;
begin
  Result := nil;
  FileAction := TFileAction.Create(Update.LocalFile);
  try
    if (FileAction.FileExit) then
    begin
      if (FileAction.GetFileDate < Update.NewDate) then
      begin
        NewUpdate := TFileUpdate.Create;
        NewUpdate.Assign(Update);
        Result := CreateUpdateDecorator(NewUpdate);
      end;
    end;
  finally
    freeAndNil(FileAction);
  end;
end;

{
********************************* TSizeAnalyse *********************************
}
function TSizeAnalyse.Run(Update: TUpdate): TUpdate;
var
  FileAction: TFileAction;
  NewUpdate: TUpdate;
begin
  Result := nil;
  FileAction := TFileAction.Create(Update.LocalFile);
  try
    if (FileAction.FileExit) then
    begin
      if (FileAction.GetFileSize > Update.NewSize) then
      begin
        NewUpdate := TFileUpdate.Create;
        NewUpdate.Assign(Update);
        Result := CreateUpdateDecorator(NewUpdate);
      end;
    end;
  finally
    FreeAndNil(FileAction);
  end;
end;

{
******************************** TCreateAnalyse ********************************
}
function TCreateAnalyse.Run(Update: TUpdate): TUpdate;
var
  FileAction: TFileAction;
  NewUpdate: TUpdate;
begin
  Result := nil;
  FileAction := TFileAction.Create(Update.LocalFile);
  try
    if (not FileAction.FileExit) then
    begin
      NewUpdate := TFileUpdate.Create;
      NewUpdate.Assign(Update);
      Result := CreateUpdateDecorator(NewUpdate);
    end
    else
    begin
      if (FileAction.GetFileDate < Update.NewDate) then
      begin
        NewUpdate := TFileUpdate.Create;
        NewUpdate.Assign(Update);
        Result := CreateUpdateDecorator(NewUpdate);
      end;
    end;
  finally
    FreeAndNil(FileAction);
  end;
end;

{
****************************** TAnalyseCmdFactory ******************************
}
class function TAnalyseCmdFactory.CreateAnalyseCmd(AnalyseCmdClass:
        TAnalyseCmdClass): TAnalyseCmd;
begin
  // TODO -cMM: TAnalyseCmdFactory.CreateAnalyseCmd default body inserted
  Result := AnalyseCmdClass.Create;
end;

end.
