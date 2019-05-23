unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ver: TLabel;
    extver: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;
const
  versione = 'SpeedyEdit 2.5.3 -by KaneB-';
  extversione = '2.5beta3 Freeware';
implementation
uses Principale;

{$R *.DFM}

procedure TAboutBox.FormCreate(Sender: TObject);
begin
ver.caption:=versione;
extver.caption:=extversione;
caption:=versione;
end;

end.
 
