unit Principale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Menus, ToolWin, Buttons, ImgList, ExtCtrls,
  System.ImageList, System.UITypes;

type
  TForm1 = class(TForm)
    RichEdit1: TRichEdit;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Nuovo1: TMenuItem;
    Apri1: TMenuItem;
    Salva1: TMenuItem;
    Salvaconnome1: TMenuItem;
    N1: TMenuItem;
    Invia1: TMenuItem;
    Stampa1: TMenuItem;
    Impostastampante1: TMenuItem;
    N2: TMenuItem;
    Esci1: TMenuItem;
    Modifica1: TMenuItem;
    AnnullaRipeti1: TMenuItem;
    N3: TMenuItem;
    Copia1: TMenuItem;
    Taglia1: TMenuItem;
    Incolla1: TMenuItem;
    Selezionatutto1: TMenuItem;
    N4: TMenuItem;
    Carattere1: TMenuItem;
    Visualizza1: TMenuItem;
    mrighello: TMenuItem;
    mwrap: TMenuItem;
    N6: TMenuItem;
    About1: TMenuItem;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    bnuovo: TToolButton;
    bapri: TToolButton;
    bsalva: TToolButton;
    ToolButton4: TToolButton;
    bstampa: TToolButton;
    ToolButton6: TToolButton;
    btaglia: TToolButton;
    bcopia: TToolButton;
    bincolla: TToolButton;
    ToolButton10: TToolButton;
    bundo: TToolButton;
    ToolButton12: TToolButton;
    bemail: TToolButton;
    ToolButton14: TToolButton;
    binfo: TToolButton;
    ToolBar2: TToolBar;
    ToolButton20: TToolButton;
    elenpunt: TToolButton;
    ToolButton22: TToolButton;
    bsin: TToolButton;
    bcen: TToolButton;
    bdes: TToolButton;
    ToolButton28: TToolButton;
    bfont: TSpeedButton;
    ToolButton29: TToolButton;
    bcol: TToolButton;
    ToolButton31: TToolButton;
    baum: TToolButton;
    bdim: TToolButton;
    bar: TSpeedButton;
    gra: TSpeedButton;
    cor: TSpeedButton;
    sot: TSpeedButton;
    CoolBar1: TCoolBar;
    Ruler: TPanel;
    rulerline: TBevel;
    LeftInd: TLabel;
    FirstInd: TLabel;
    RightInd: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    PopupMenu1: TPopupMenu;
    aglia1: TMenuItem;
    Copia2: TMenuItem;
    Incolla2: TMenuItem;
    N7: TMenuItem;
    SelezionaTuttu1: TMenuItem;
    N8: TMenuItem;
    Annulla1: TMenuItem;
    procedure ShowHint(Sender: TObject);
    procedure RichEdit1SelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bnuovoClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bapriClick(Sender: TObject);
    procedure bsalvaClick(Sender: TObject);
    procedure Salvaconnome1Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure bstampaClick(Sender: TObject);
    procedure Impostastampante1Click(Sender: TObject);
    procedure bcopiaClick(Sender: TObject);
    procedure btagliaClick(Sender: TObject);
    procedure bincollaClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure bfontClick(Sender: TObject);
    procedure graClick(Sender: TObject);
    procedure corClick(Sender: TObject);
    procedure sotClick(Sender: TObject);
    procedure barClick(Sender: TObject);
    procedure elenpuntClick(Sender: TObject);
    procedure Allineamento(Sender: TObject);
    procedure bcolClick(Sender: TObject);
    procedure baumClick(Sender: TObject);
    procedure bdimClick(Sender: TObject);
    procedure rulitmdown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rulitmmove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure fstindup(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lftindup(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rgtindup(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerResize(Sender: TObject);
    procedure bundoClick(Sender: TObject);
    procedure mrighelloClick(Sender: TObject);
    procedure mwrapClick(Sender: TObject);
    procedure bemailClick(Sender: TObject);
    procedure Esci1Click(Sender: TObject);
    procedure binfoClick(Sender: TObject);
  private
    FDragOfs: Integer;
    FDragging: Boolean;
    procedure SetupRuler;
    procedure SetEditRect;
    procedure solotesto;
    procedure IdleLoop(Sender: TObject; var Done: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  sfile: string;
  m, mess: integer;
  salvato: boolean;
implementation
uses Mapi, About, richedit;
const
  versione = 'SpeedyEdit 2.5.4 -by KaneB-';
  extversione = '2.5beta4 Freeware';
  ndoc = 'Nuovo Documento';
  RulerAdj = 4/3;
  GutterWid = 6;
{$R *.DFM}

procedure TForm1.setupruler;
var
  i: integer;
  s: string;
begin
  setlength(s, 201);
  i:=1;
  while i<200 do
  begin
    s[i]:=#9;
    s[i+1]:='|';
    inc(i,2);
  end;
  ruler.Caption:=s;
end;

procedure TForm1.RichEdit1SelectionChange(Sender: TObject);
begin
  with richedit1.paragraph do
    try
      FirstInd.Left:=Trunc(FirstIndent*RulerAdj)-4+GutterWid;
      LeftInd.Left:=trunc((leftindent+firstindent)*RulerAdj)-4+GutterWid;
      RightInd.Left:=Ruler.ClientWidth-6-trunc((RightIndent+gutterwid)*ruleradj);
      if integer(numbering) = 0 then elenpunt.down := false
         else elenpunt.Down := true;
      gra.Down:= fsbold in richedit1.SelAttributes.Style;
      cor.down:= fsitalic in richedit1.SelAttributes.Style;
      sot.down:= fsunderline in richedit1.SelAttributes.Style;
      bar.down:= fsstrikeout in richedit1.SelAttributes.Style;
      case ord(alignment) of
        0: bsin.down:=true;
        1: bdes.Down:=true;
        2: bcen.Down:=true;
      end;
    finally
    end;
end;

procedure TForm1.solotesto;
begin
  if uppercase(extractfileext(sfile)) <> '.RTF' then
    with richedit1.defattributes do
      begin
        richedit1.plaintext:=true;
        name:='Courier New';
        size:=10;
        color:=clBlack;
        style:= [];
      end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  setupruler;
  if paramcount > 0 then
    begin
      sfile:=paramstr(1);
      if uppercase(extractfileext(sfile)) = '.RTF' then
      richedit1.PlainText:=false else
      richedit1.PlainText:=true;
      richedit1.lines.LoadFromFile(sfile);
      solotesto;
      form1.Caption:=(extractfilename(sfile) + ' - ' + versione);
      richedit1.modified:= false;
      salvato:=true;
      richedit1selectionchange(Sender);
    end
  else bnuovoclick(Sender);
  application.onhint:= showhint;
  application.onidle:= IdleLoop;
end;

procedure TForm1.bnuovoClick(Sender: TObject);
begin
  if RichEdit1.Modified then
    begin
      mess:= Application.MessageBox('Vuoi salvare le ultime modifiche?', versione, mb_YesNoCancel + mb_iconquestion);
      case mess of
        idYes: bsalvaClick(Self);
        idNo: {Non fa niente};
        idCancel: Abort;
      end;
    end;
  richedit1.lines.clear;
  form1.caption:=(ndoc + ' - '+ versione);
  richedit1.readonly:=false;
  richedit1.plaintext:= false; //modificare questa riga dopo l'implementazione della finestra di opzioni
  with richedit1.defattributes do
    begin
      color:= clBlack;  //modificare questa riga dopo l'implementazione della finestra di opzioni
      name:= 'Times New Roman';  //modificare questa riga dopo l'implementazione della finestra di opzioni
      size:= 11;  //modificare questa riga dopo l'implementazione della finestra di opzioni
      style:= style - [fsBold, fsItalic, fsUnderline, fsStrikeout]; //modificare questa riga dopo l'implementazione della finestra di opzioni
    end;
  firstind.left:= 8;
  leftind.left:= 8;
  rightind.left:= ruler.width-10;
  RichEdit1.Paragraph.FirstIndent := Trunc((FirstInd.Left+5-GutterWid) / RulerAdj);
  RichEdit1.Paragraph.LeftIndent := Trunc((LeftInd.Left+5-GutterWid) / RulerAdj)-RichEdit1.Paragraph.FirstIndent;
  RichEdit1.Paragraph.RightIndent := Trunc((Ruler.ClientWidth-RightInd.Left+4-2) / RulerAdj)-2*GutterWid;
  richedit1.paragraph.alignment:= taLeftJustify;
  form1.RichEdit1SelectionChange(Sender);
  richedit1.paragraph.numbering:= nsNone;
  elenpunt.down:=false;
  richedit1.modified:= false;
  salvato:=false;
end;

procedure TForm1.ShowHint(Sender: TObject);
begin
  StatusBar1.panels.items[2].text:= Application.Hint;
end;

procedure TForm1.SetEditRect;
var
  R: TRect;
begin
  with RichEdit1 do
  begin
    R := Rect(GutterWid, 0, ClientWidth-GutterWid, ClientHeight);
    SendMessage(Handle, EM_SETRECT, 0, Longint(@R));
  end;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  seteditrect;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  SetEditRect;
  RichEdit1SelectionChange(Sender);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if RichEdit1.Modified then
    begin
      mess:= Application.MessageBox('Vuoi salvare le ultime modifiche?', versione, mb_YesNoCancel + mb_iconquestion);
      case mess of
        idYes: bsalvaClick(Self);
        idNo: {Niente};
        idCancel: Abort;
      end;
    end;
end;

procedure TForm1.IdleLoop(Sender: TObject; var Done: Boolean);
begin
if richedit1.modified then
    begin
      statusbar1.panels.items[1].text:='Modificato';
      salvato:=false;
    end
  else statusbar1.panels.items[1].text:='';
  if salvato then statusbar1.panels.items[0].text:='Salvato'
  else statusbar1.panels.items[0].text:='Non salvato';
end;

procedure TForm1.bapriClick(Sender: TObject);
begin
  if opendialog1.execute then
    begin
      bnuovoclick(Sender);
      sfile:=(opendialog1.filename);
      richedit1.lines.loadfromfile(sfile);
      solotesto;
      form1.caption:=(extractfilename(sfile) + ' - ' + versione);
      richedit1.modified:= false;
      richedit1.readonly:= ofreadonly in opendialog1.options;
      salvato:=true;
      richedit1selectionchange(Sender);
    end;
end;

procedure TForm1.bsalvaClick(Sender: TObject);
begin
  if richedit1.readonly then
    begin
      mess:= Application.MessageBox('Non posso scrivere su un file di sola lettura, salvare su un altro file', versione, mb_OK + mb_iconexclamation);
      salvaconnome1click(sender);
      exit;
    end;
  if not fileExists(sfile) then
    begin
      salvaconnome1click(sender);
    end
  else
    begin
      if richedit1.plaintext then solotesto;
      richedit1.lines.savetofile(sfile);
      richedit1.modified:= false;
      salvato:=true;
    end;
end;

procedure TForm1.Salvaconnome1Click(Sender: TObject);
begin
  if savedialog1.execute then
    begin
      if savedialog1.filterindex = 1 then richedit1.plaintext:=false else richedit1.plaintext:=true;
      richedit1.lines.savetofile(savedialog1.filename);
      sfile:=(savedialog1.filename);
      solotesto;
      form1.caption:=(extractfilename(sfile) + ' - ' + versione);
      richedit1.modified:= false;
      salvato:=true;
    end;
end;

procedure TForm1.Stampa1Click(Sender: TObject);
begin
  if printdialog1.execute then
    begin
      if sfile <> ('Nuovo documento') then richedit1.print(extractfilename(sfile))
      else richedit1.print(sfile);
    end;
end;

procedure TForm1.bstampaClick(Sender: TObject);
begin
  if sfile <> ndoc then richedit1.print(extractfilename(sfile))
  else richedit1.print(sfile);
end;

procedure TForm1.Impostastampante1Click(Sender: TObject);
begin
  printersetupdialog1.execute;
end;

procedure TForm1.bcopiaClick(Sender: TObject);
begin
  richedit1.copytoclipboard;
end;

procedure TForm1.btagliaClick(Sender: TObject);
begin
  richedit1.cuttoclipboard;
end;

procedure TForm1.bincollaClick(Sender: TObject);
begin
  richedit1.pastefromclipboard;
end;

procedure TForm1.Selezionatutto1Click(Sender: TObject);
begin
  richedit1.selectall;
end;

procedure TForm1.bfontClick(Sender: TObject);
begin
fontdialog1.Font.Name:=richedit1.selattributes.name;
fontdialog1.Font.size:=richedit1.selattributes.size;
fontdialog1.Font.color:=richedit1.selattributes.color;
fontdialog1.Font.style:=richedit1.selattributes.style;
  if fontdialog1.execute then
    begin
      richedit1.selattributes.name:=(fontdialog1.font.name);
      richedit1.selattributes.size:=(fontdialog1.font.size);
      richedit1.selattributes.color:=(fontdialog1.font.color);
      richedit1.selattributes.style:=(fontdialog1.font.style);
    end;

end;

procedure TForm1.graClick(Sender: TObject);
begin
  if gra.down then richedit1.selattributes.style:= richedit1.selattributes.style + [fsbold]
  else  richedit1.selattributes.style:= richedit1.selattributes.style - [fsbold];

end;

procedure TForm1.corClick(Sender: TObject);
begin
  if cor.down then richedit1.selattributes.style:= richedit1.selattributes.style + [fsitalic]
  else richedit1.selattributes.style:= richedit1.selattributes.style - [fsitalic];

end;

procedure TForm1.sotClick(Sender: TObject);
begin
  if sot.down then richedit1.selattributes.style:= richedit1.selattributes.style + [fsunderline]
  else richedit1.selattributes.style:= richedit1.selattributes.style - [fsunderline];

end;

procedure TForm1.barClick(Sender: TObject);
begin
  if bar.down then richedit1.selattributes.style:= richedit1.selattributes.style + [fsstrikeout]
  else richedit1.selattributes.style:= richedit1.selattributes.style - [fsstrikeout];

end;

procedure TForm1.elenpuntClick(Sender: TObject);
begin
  RichEdit1.Paragraph.Numbering := TNumberingStyle(elenpunt.Down);
end;

procedure TForm1.Allineamento(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := TAlignment(TControl(Sender).Tag);

end;

procedure TForm1.bcolClick(Sender: TObject);
begin
  colordialog1.color := richedit1.SelAttributes.color;
  if colordialog1.execute then richedit1.selattributes.color:=colordialog1.color;

end;

procedure TForm1.baumClick(Sender: TObject);
begin
  with richedit1.selattributes do
    begin
      if size<72 then size:=size+2;
      SetEditRect;
    end;

end;

procedure TForm1.bdimClick(Sender: TObject);
begin
  with richedit1.selattributes do
    begin
      if size>5 then size:=size-2;
      SetEditRect;
    end;

end;

procedure TForm1.rulitmdown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left+X-FDragOfs;
  FDragging := True;

end;

procedure TForm1.rulitmmove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if FDragging then
    TLabel(Sender).Left :=  TLabel(Sender).Left+X-FDragOfs

end;

procedure TForm1.fstindup(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  RichEdit1.Paragraph.FirstIndent := Trunc((FirstInd.Left+FDragOfs-GutterWid) / RulerAdj);
  Lftindup(Sender, Button, Shift, X, Y);

end;

procedure TForm1.lftindup(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  RichEdit1.Paragraph.LeftIndent := Trunc((LeftInd.Left+FDragOfs-GutterWid) / RulerAdj)-RichEdit1.Paragraph.FirstIndent;
  RichEdit1SelectionChange(Sender);

end;

procedure TForm1.rgtindup(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  RichEdit1.Paragraph.RightIndent := Trunc((Ruler.ClientWidth-RightInd.Left+FDragOfs-2) / RulerAdj)-2*GutterWid;
  RichEdit1SelectionChange(Sender);

end;

procedure TForm1.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left*2);

end;

procedure TForm1.bundoClick(Sender: TObject);
begin
  with RichEdit1 do
    if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);

end;

procedure TForm1.mrighelloClick(Sender: TObject);
begin
  mrighello.checked:= not mrighello.checked;
  ruler.visible:= not ruler.visible;

end;

procedure TForm1.mwrapClick(Sender: TObject);
begin
  richedit1.wordwrap:= not richedit1.wordwrap;
  mwrap.checked:= not mwrap.checked;

end;

procedure TForm1.bemailClick(Sender: TObject);
var
  MapiMessage: TMapiMessage;
  MError: Cardinal;
begin
  with MapiMessage do
    begin
      ulReserved := 0;
      lpszSubject := nil;
      lpszNoteText := PAnsiChar(AnsiString(RichEdit1.Lines.Text));
      lpszMessageType := nil;
      lpszDateReceived := nil;
      lpszConversationID := nil;
      flFlags := 0;
      lpOriginator := nil;
      nRecipCount := 0;
      lpRecips := nil;
      nFileCount := 0;
      lpFiles := nil;
    end;
  MError := MapiSendMail(0, Application.Handle{0}, MapiMessage,
  MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0);
  if MError == 0 then Application.MessageBox('E-mail spedita correttamente.', 'SpeedyEdit 2.0', mb_OK + mb_iconinformation);
  else if MError == 1 then Application.MessageBox('Errore: nessun client di posta installato o richiesta annullata dall''utente.', 'SpeedyEdit 2.0', mb_OK + mb_iconexclamation);
  else if MError == 3 then Application.MessageBox('Errore: nessun account di posta trovato.', 'SpeedyEdit 2.0', mb_OK + mb_iconinformation);
  else if MError <> 0 then mess:= Application.MessageBox('Si � verificato un errore. Non � stato possibile inviare l''e-mail.', 'SpeedyEdit 2.0', mb_OK + mb_iconexclamation);

end;

procedure TForm1.Esci1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.binfoClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

end.
