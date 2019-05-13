unit code_project_prak;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls, Spin, Arrow, ColorBox, ActnList, Menus, Buttons, Types,
  LCLIntf, EditBtn;


type

  { TForm1 }
  Element = record
    x,y : integer;
    e : TColor;
  end;

  TForm1 = class(TForm)
    btnKubus: TSpeedButton;
    btnLingkaran: TSpeedButton;
    btnSegi3: TSpeedButton;
    btnPentagon: TSpeedButton;
    btnPiramid: TSpeedButton;
    cbLineStyle: TComboBox;
    ColorButton1: TColorButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnUp: TSpeedButton;
    btnUpleft: TSpeedButton;
    btnLeft: TSpeedButton;
    btnDown: TSpeedButton;
    btnUpright: TSpeedButton;
    btnRight: TSpeedButton;
    btnDownRight: TSpeedButton;
    btnDownleft: TSpeedButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    btnZoomin: TSpeedButton;
    btnZoomout: TSpeedButton;
    btnOpen: TMenuItem;
    GroupBox5: TGroupBox;
    btnSkewH: TSpeedButton;
    btnSkewV: TSpeedButton;
    GroupBox6: TGroupBox;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    btnFlipV: TSpeedButton;
    btnFlipH: TSpeedButton;
    spinSkew: TSpinEdit;
    spinZoom: TSpinEdit;
    spinShift: TSpinEdit;
    toolBox: TGroupBox;
    Image1: TImage;
    koordinat: TLabel;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    btnNew: TMenuItem;
    btnSimpan: TMenuItem;
    btnReset: TMenuItem;
    PageControl1: TPageControl;
    btnPen: TSpeedButton;
    btnEraser: TSpeedButton;
    btnFill: TSpeedButton;
    btnLine: TSpeedButton;
    btnKotak: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    trackRotate: TTrackBar;
    weightLine: TTrackBar;
    procedure btnDownClick(Sender: TObject);
    procedure btnDownleftClick(Sender: TObject);
    procedure btnDownRightClick(Sender: TObject);
    procedure btnFlipVClick(Sender: TObject);
    procedure btnFlipHClick(Sender: TObject);
    procedure btnKubusClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnLineClick(Sender: TObject);
    procedure btnLingkaranClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnPiramidClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure btnUpleftClick(Sender: TObject);
    procedure btnUprightClick(Sender: TObject);
    procedure btnZoomoutClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnNewClick(Sender: TObject);
    procedure Image1Paint(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnPenClick(Sender: TObject);
    procedure Shape(Sender: TObject);
    procedure boundary_fill(x,y,fill,boundary : integer);
    procedure btnUpClick(Sender: TObject);
    procedure btnZoominClick(Sender: TObject);
    procedure btnSkewHClick(Sender: TObject);
    procedure btnSkewVClick(Sender: TObject);
    procedure trackRotateChange(Sender: TObject);
    procedure TitikTengah(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  paintbmp: TBitmap;
  mousePress: Boolean;
  xDown, yDown, xUp, yUp, xFill, yFill  : integer;
  o, Temp : array[1..14] of Element;
  i,a,b,c,n, recentTrack: Integer;
  sdt : Real;
  formStatus: String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnResetClick(Sender: TObject);
begin
  FormActivate(Sender);
  paintbmp.Canvas.Pen.Style:=psSolid;
end;


procedure TForm1.btnPenClick(Sender: TObject);
begin

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  paintbmp.Canvas.Pen.Color:=clBlack;
  paintbmp.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  btnNewClick(Sender);
end;

procedure TForm1.btnLineClick(Sender: TObject);
begin

end;

procedure TForm1.btnLeftClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (formStatus = 'segitiga') or (formStatus = 'segilima') or (formStatus = 'kotak') or (formStatus = 'limas') or (formStatus = 'kubus') then
    begin
    for i:=1 to n do
        o[i].x-=spinShift.Value;
    xFill-=spinShift.Value;
    end
  else if (formStatus = 'lingkaran') then
  begin
    xDown-=spinShift.Value;
    xUp-=spinShift.Value;
    xFill-=spinShift.Value;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(xFill,yFill,fill,boundary);
   end;
end;

procedure TForm1.btnDownClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (formStatus = 'segitiga') or (formStatus = 'segilima') or (formStatus = 'kotak') or (formStatus = 'limas') or (formStatus = 'kubus') then
    begin
    for i:=1 to n do
        o[i].y+=spinShift.Value;
    yFill+=spinShift.Value;
    end
  else if (formStatus = 'lingkaran') then
  begin
    yDown+=spinShift.Value;
    yUp+=spinShift.Value;
    yFill+=spinShift.Value;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(xFill,yFill,fill,boundary);
   end;
end;

procedure TForm1.btnDownleftClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (formStatus = 'segitiga') or (formStatus = 'segilima') or (formStatus = 'kotak') or (formStatus = 'limas') or (formStatus = 'kubus') then
    begin
    for i:=1 to n do
       begin
        o[i].x-=spinShift.Value;
        o[i].y+=spinShift.Value;
        end;
    xFill-=spinShift.Value;
    yFill+=spinShift.Value;
    end
  else if (formStatus = 'lingkaran') then
  begin
    xDown-=spinShift.Value;
    xUp-=spinShift.Value;
    yDown+=spinShift.Value;
    yUp+=spinShift.Value;
    xFill-=spinShift.Value;
    yFill+=spinShift.Value;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(xFill,yFill,fill,boundary);
   end;
end;

procedure TForm1.btnDownRightClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (formStatus = 'segitiga') or (formStatus = 'segilima') or (formStatus = 'kotak') or (formStatus = 'limas') or (formStatus = 'kubus') then
    begin
    for i:=1 to n do
       begin
        o[i].x+=spinShift.Value;
        o[i].y+=spinShift.Value;
        end;
    xFill+=spinShift.Value;
    yFIll+=spinShift.Value;
    end
  else if (formStatus = 'lingkaran') then
  begin
    xDown+=spinShift.Value;
    xUp+=spinShift.Value;
    yDown+=spinShift.Value;
    yUp+=spinShift.Value;
    xFill+=spinShift.Value;
    yFill+=spinSHift.Value;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(xFill,yFill,fill,boundary);
   end;
end;

procedure TForm1.btnFlipVClick(Sender: TObject);
var
  p,q, yDownTemp, yUpTemp : integer;
begin
  p:=Image1.Width;
  q:=Image1.Height div 2;
  paintbmp.Canvas.MoveTo(0,q);
  paintbmp.Canvas.LineTo(p,q);
  if (formStatus = 'kotak') or (formStatus = 'segitiga') or (formStatus = 'segilima') then
  begin
    for i:=1 to n do
     begin
     Temp[i].y:=(o[i].y-(2*(o[i].y-q)));
     Temp[i].x:= o[i].x;
     end;
     paintbmp.Canvas.MoveTo(Temp[n].x,Temp[n].y);
    for i:=1 to n do
     begin
     paintbmp.Canvas.LineTo(Temp[i].x,Temp[i].y);
     end;
   end
  else if (formStatus = 'lingkaran') then
  begin
    yDownTemp := yDown-(2*(yDown-q));
    yUpTemp := yUp-(2*(yUp-q));

    paintbmp.Canvas.Ellipse(xDown,yDownTemp,xUp,yUpTemp);
   end;
  Image1Paint(Sender);
end;

procedure TForm1.btnFlipHClick(Sender: TObject);
var
  p,q, xDownTemp, xUpTemp : integer;
begin
  p:=Image1.Width div 2;
  q:=Image1.Height ;
  paintbmp.Canvas.MoveTo(p,0);
  paintbmp.Canvas.LineTo(p,q);
  if (formStatus = 'kotak') or (formStatus = 'segitiga') or (formStatus = 'segilima') then
  begin
    for i:=1 to n do
     begin
     Temp[i].x:=(o[i].x-(2*(o[i].x-p)));
     Temp[i].y:= o[i].y;
     end;
     paintbmp.Canvas.MoveTo(Temp[n].x,Temp[n].y);
    for i:=1 to n do
     begin
     paintbmp.Canvas.LineTo(Temp[i].x,Temp[i].y);
     end;
   end
  else if (formStatus = 'lingkaran') then
  begin
    xDownTemp := xDown-(2*(xDown-p));
    xUpTemp := xUp-(2*(xUp-p));

    paintbmp.Canvas.Ellipse(xDownTemp,yDown,xUpTemp,yUp);
   end;
  Image1Paint(Sender);
end;

procedure TForm1.btnKubusClick(Sender: TObject);
begin
  formStatus := 'kubus';
    o[1].x:=250;                        o[1].y:=315;
    o[2].x:=460;                          o[2].y:=315;
    o[3].x:=460;                        o[3].y:=105;
    o[4].x:=250;                          o[4].y:=105;
    o[5].x:=320;                          o[5].y:=230;
    o[6].x:=530;                          o[6].y:=230;
    o[7].x:=530;                          o[7].y:=20;
    o[8].x:=320;                          o[8].y:=20;
    n:= 8;
    FormShow(Sender);
end;

procedure TForm1.btnLingkaranClick(Sender: TObject);
begin

end;

procedure TForm1.btnOpenClick(Sender: TObject);
begin
  OpenDialog1.Execute;

  if (OpenDialog1.Files.Count > 0) then begin

    if (FileExists(OpenDialog1.FileName)) then begin
      paintbmp.LoadFromFile(OpenDialog1.FileName);
      Image1Paint(Sender);

    end else begin
      ShowMessage('File is not found. You will have to open an existing file.');

    end;

  end;
end;

procedure TForm1.btnPiramidClick(Sender: TObject);
begin
    formStatus := 'limas';
    o[1].x:=250;                        o[1].y:=315;
    o[2].x:=460;                          o[2].y:=315;
    o[3].x:=530;                        o[3].y:=230;
    o[4].x:=320;                          o[4].y:=230;
    o[5].x:=385;                          o[5].y:=15;
    n:= 5;
    FormShow(Sender);
end;

procedure TForm1.btnRightClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (formStatus = 'segitiga') or (formStatus = 'segilima') or (formStatus = 'kotak') or (formStatus = 'limas') or (formStatus = 'kubus') then
    begin
    for i:=1 to n do
        o[i].x+=spinShift.Value;
    xFill+=spinShift.Value;
    end
  else if (formStatus = 'lingkaran') then
  begin
    xDown+=spinShift.Value;
    xUp+=spinShift.Value;
    xFill+=SpinShift.Value;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(xFill,yFill,fill,boundary);
   end;
end;

procedure TForm1.btnSimpanClick(Sender: TObject);
begin
  SaveDialog1.Execute;

  if (SaveDialog1.Files.Count > 0) then begin
    if RightStr(SaveDialog1.FileName, 4) <> '.bmp' then
      SaveDialog1.FileName:=SaveDialog1.FileName+'.bmp';

    paintbmp.SaveToFile(SaveDialog1.FileName);

  end;
end;

procedure TForm1.btnUpleftClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (formStatus = 'segitiga') or (formStatus = 'segilima') or (formStatus = 'kotak') or (formStatus = 'limas') or (formStatus = 'kubus') then
    begin
    for i:=1 to n do
       begin
        o[i].x-=spinShift.Value;
        o[i].y-=spinShift.Value;
        end;
    xFill-=spinShift.Value;
    yFill-=spinShift.Value;
    end
  else if (formStatus = 'lingkaran') then
  begin
    xDown-=spinShift.Value;
    xUp-=spinShift.Value;
    yDown-=spinShift.Value;
    yUp-=spinShift.Value;
    xFill-=spinShift.Value;
    yFill-=spinShift.Value;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(xFill,yFill,fill,boundary);
   end;
end;

procedure TForm1.btnUprightClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (formStatus = 'segitiga') or (formStatus = 'segilima') or (formStatus = 'kotak') or (formStatus = 'limas') or (formStatus = 'kubus') then
    begin
    for i:=1 to n do
       begin
        o[i].x+=spinShift.Value;
        o[i].y-=spinShift.Value;
        end;
    xFill+=spinShift.Value;
    yFill-=spinShift.Value;
    end
  else if (formStatus = 'lingkaran') then
  begin
    xDown+=spinShift.Value;
    xUp+=spinShift.Value;
    yDown-=spinShift.Value;
    yUp-=spinShift.Value;
    xFill+=spinShift.Value;
    yFill-=spinShift.Value;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(xFill,yFill,fill,boundary);
   end;
end;

procedure TForm1.btnZoomoutClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (btnLingkaran.Down) or (formStatus = 'Lingkaran') then
  begin
    a := (xDown+xUp) div 2;
    b := (yDown+yUp) div 2;

    for i:=1 to 2 do
    begin
      o[i].x:=o[i].x-a;
      o[i].y:=o[i].y-b;
      Temp[i].x:=o[i].x div spinZoom.Value;
      Temp[i].y:=o[i].y div spinZoom.Value;
      o[i] := Temp[i];
      o[i].x:=o[i].x+a;
      o[i].y:=o[i].y+b;
    end;
    xDown :=  o[1].x;    yDown :=  o[1].y;
    xUp :=  o[2].x;      yUp :=  o[2].y;
  end
  else
  begin
    TitikTengah(Sender);
    for i:=1 to c do
    begin
      o[i].x:=o[i].x-a;
      o[i].y:=o[i].y-b;
      Temp[i].x:=o[i].x div spinZoom.Value;
      Temp[i].y:=o[i].y div spinZoom.Value;
      o[i] := Temp[i];
      o[i].x:=o[i].x+a;
      o[i].y:=o[i].y+b;
    end;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(a,b,fill,boundary);
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  btnNewClick(Sender);
end;

procedure TForm1.FormShow(Sender: TObject);
var
  fill,boundary:integer;
begin
  paintbmp.Canvas.Pen.Width:=weightLine.Position;
  paintbmp.Canvas.Pen.Color:=clBlack;
  if (btnPen.Down = true) then
    begin
      //paintbmp.Canvas.Pen.Color:=clBlack;
      //paintbmp.Canvas.Pen.Width:=weightLine.Position;
      paintbmp.Canvas.Line(xDown,yDown,xUp,yUp);
    end
  else if (btnEraser.Down = true) then
    begin
      paintbmp.Canvas.Pen.Color:=clWhite;
      paintbmp.Canvas.Pen.Style:=psSolid;
      //paintbmp.Canvas.Pen.Width:=weightLine.Position;
      paintbmp.Canvas.Line(xDown,yDown,xUp,yUp);
    end
  else
    begin
         paintbmp.Canvas.Brush.Color:=clwhite;
         paintbmp.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
    end;



  if (btnLine.Down = true) then
  begin
    c:=2;
    //paintbmp.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
    paintbmp.Canvas.MoveTo(o[1].x,o[1].y);
    paintbmp.Canvas.LineTo(o[2].x,o[2].y);
  end
  else if (btnSegi3.Down = true) or (formStatus = 'segitiga') then
   begin
     c:=3;
     //paintbmp.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
      paintbmp.Canvas.MoveTo(o[3].x,o[3].y);
      for i:= 1 to c do
      begin
        paintbmp.Canvas.LineTo(o[i].x,o[i].y);
      end;
   end
  else if (btnKotak.Down = true) or (formStatus = 'kotak') then
   begin
     c:=4;
      paintbmp.Canvas.MoveTo(o[4].x,o[4].y);
      for i:= 1 to c do
      begin
        paintbmp.Canvas.LineTo(o[i].x,o[i].y);
      end;
   end
  else if (btnLingkaran.Down = true) or (formStatus = 'lingkaran') then
   begin
     paintbmp.Canvas.Ellipse(xDown,yDown,xUp,yUp);
   end
  else if (btnPentagon.Down = true) or (formStatus = 'segilima') then
   begin
     c:=5;
      paintbmp.Canvas.MoveTo(O[5].x,O[5].y);
      for i:= 1 to c do
      begin
        paintbmp.Canvas.LineTo(O[i].x,O[i].y);
      end;
   end
  else if (btnPiramid.Down = true) or (formStatus = 'limas') then
   begin
     c:=5;
      paintbmp.Canvas.MoveTo(O[4].x,O[4].y);
      for i:= 1 to 4 do
      begin
        paintbmp.Canvas.LineTo(O[i].x,O[i].y);
      end;

      for i:= 1 to 4 do
      begin
        paintbmp.Canvas.MoveTo(o[i].x,o[i].y);
        paintbmp.Canvas.LineTo(o[5].x,o[5].y);
      end;
   end
   else if (btnKubus.Down = true) or (formStatus = 'kubus') then
   begin
     c:=8;
      paintbmp.Canvas.MoveTo(O[4].x,O[4].y);
      for i:= 1 to 4 do
      begin
        paintbmp.Canvas.LineTo(O[i].x,O[i].y);
      end;

      paintbmp.Canvas.MoveTo(O[8].x,O[8].y);
      for i:= 5 to 8 do
      begin
        paintbmp.Canvas.LineTo(O[i].x,O[i].y);
      end;

      for i:= 1 to 4 do
      begin
        paintbmp.Canvas.MoveTo(o[i].x,o[i].y);
        paintbmp.Canvas.LineTo(o[i+4].x,o[i+4].y);
      end;
   end;
  Image1Paint(Sender);


end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  fill,boundary:integer;
begin
  if (btnFill.Down) then
   begin
     xFIll := X;
     yFill := Y;
     fill := ColorButton1.ButtonColor;
     boundary := clBlack;
     boundary_fill(xFill,yFill,fill,boundary);
   end
  else
  begin
     mousePress := true;
     xDown := X;
     yDown := Y;
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  koordinat.Caption := 'Koordinat X:'+inttostr(X)+',Y:'+inttostr(Y);
  if (mousePress = true) then
    begin
      case cbLineStyle.ItemIndex of
      0: paintbmp.Canvas.Pen.Style := psSolid;
      1: paintbmp.Canvas.Pen.Style := psDash;
      2: paintbmp.Canvas.Pen.Style := psDot;
      3: paintbmp.Canvas.Pen.Style := psDashDot;
      4: paintbmp.Canvas.Pen.Style := psDashDotDot;
       end;
      xUp:=X;
      yUp:=Y;
      Shape(Sender);
      FormShow(Sender);
      if (btnPen.Down) or (btnEraser.Down) then
        begin
          xDown := xUp;
          yDown := yUp;
        end;
    end;

end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (mousePress = true) then
    begin
      case cbLineStyle.ItemIndex of
      0: paintbmp.Canvas.Pen.Style := psSolid;
      1: paintbmp.Canvas.Pen.Style := psDash;
      2: paintbmp.Canvas.Pen.Style := psDot;
      3: paintbmp.Canvas.Pen.Style := psDashDot;
      4: paintbmp.Canvas.Pen.Style := psDashDotDot;
       end;
      xUp:=X;
      yUp:=Y;
      Shape(Sender);
      FormShow(Sender);
    end;
    mousePress := false;
    paintbmp.Canvas.Pen.Color:=clBlack;

end;

procedure TForm1.btnNewClick(Sender: TObject);
begin
    recentTrack := 0;
    if paintbmp <> nil then
    paintbmp.Destroy;

    paintbmp := TBitmap.Create;

    paintbmp.SetSize(Image1.Width, Image1.Height);
    paintbmp.Canvas.FillRect(0,0,paintbmp.Width,paintbmp.Height);

    paintbmp.Canvas.Brush.Style:=bsClear;
    Image1.Canvas.Brush.Style:=bsClear;

    Image1Paint(Sender);
end;

procedure TForm1.Image1Paint(Sender: TObject);
begin
  if Image1.Width <> paintbmp.Width then
  begin
    Image1.Width:=paintbmp.Width;
    Exit;
  end;

  if Image1.Height <> paintbmp.Height then
  begin
    Image1.Height:=paintbmp.Height;
    Exit;
  end;
  Image1.Canvas.Draw(0,0,paintbmp);
end;

procedure TForm1.Shape(Sender: TObject);
begin
   trackRotate.Position:=0;

  if (btnPen.Down = true) then
     formStatus := 'pen'
  else if (btnEraser.Down = true) then
     formStatus := 'eraser';

  if (btnLine.Down = true) then
  begin
    formStatus := 'garis';
    o[1].x := xDown;   o[1].y := yDown;
    o[2].X := xUp;     o[2].y := yUp;
    n:=2;
  end
  else if (btnSegi3.Down = true) then
  begin;
    formStatus := 'segitiga';
    o[1].x:=((xUp-xDown) div 2)+xDown;    o[1].y:=yDown;
    o[2].x:=xUp;                          o[2].y:=yUp;
    o[3].x:=xDown;                        o[3].y:=yUp;
    n:= 3;
  end
  else if (btnKotak.Down = true) then
  begin
    formStatus := 'kotak';
    o[1].x:=xDown;                        o[1].y:=yDown;
    o[2].x:=xUp;                          o[2].y:=yDown;
    o[3].x:=xUp;                          o[3].y:=yUp;
    o[4].x:=xDown;                        o[4].y:=yUp;
    n:= 4;
  end
  else if (btnLingkaran.Down = true) then
  begin
    formStatus := 'lingkaran';
    o[1].x:=xDown;                        o[1].y:=yDown;
    o[2].x:=xUp;                        o[2].y:=yUp;
    n:= 2;
  end
  else if (btnPentagon.Down = true) then
  begin
    formStatus := 'segilima';
    O[1].x:=xDown;                               O[1].y:=yDown;
    O[2].x:=(((xUp+25-xDown) div 2)+xDown);      O[2].y:=yDown-40;
    O[3].x:=xUp+25;                              O[3].y:=yDown;
    O[4].x:=xuP;                                 O[4].y:=yUp;
    O[5].x:=xDown+25;                            O[5].y:=yUp;
    n:= 5;
  end;

end;

Procedure TForm1.boundary_fill(x,y,fill,boundary: integer);
var
  current : integer;
begin
   current := paintbmp.Canvas.Pixels[x,y];
   if (btnFill.Down) then
   begin
     if (current<>fill) and (current<>boundary) then
     begin
       paintbmp.Canvas.Pixels[x,y] := fill;
       boundary_fill(x+1,y,fill,boundary);
       boundary_fill(x-1,y,fill,boundary);
       boundary_fill(x,y+1,fill,boundary);
       boundary_fill(x,y-1,fill,boundary);
     end;
   end;
end;

procedure TForm1.btnUpClick(Sender: TObject);
var
  fill, boundary: integer;
begin
  if (formStatus = 'segitiga') or (formStatus = 'segilima') or (formStatus = 'kotak') or (formStatus = 'limas') or (formStatus = 'kubus') then
    begin
    for i:=1 to n do
        o[i].y-=spinShift.Value;
    yFIll := yFill-spinShift.Value;
    end
  else if (formStatus = 'lingkaran') then
  begin
    yDown-=spinShift.Value;
    yUp-=spinShift.Value;
    yFill-=spinShift.Value;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(xFill,yFill,fill,boundary);
   end;
end;

procedure TForm1.btnZoominClick(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (btnLingkaran.Down) or (formStatus = 'Lingkaran') then
  begin
    a := (xDown+xUp) div 2;
    b := (yDown+yUp) div 2;

    for i:=1 to 2 do
    begin
      o[i].x:=o[i].x-a;
      o[i].y:=o[i].y-b;
      Temp[i].x:=o[i].x * spinZoom.Value;
      Temp[i].y:=o[i].y * spinZoom.Value;
      o[i] := Temp[i];
      o[i].x:=o[i].x+a;
      o[i].y:=o[i].y+b;
    end;
    xDown :=  o[1].x;    yDown :=  o[1].y;
    xUp :=  o[2].x;      yUp :=  o[2].y;
  end
  else
  begin
    TitikTengah(Sender);
    for i:=1 to c do
    begin
      o[i].x:=o[i].x-a;
      o[i].y:=o[i].y-b;
      Temp[i].x:=o[i].x * spinZoom.Value;
      Temp[i].y:=o[i].y * spinZoom.Value;
      o[i] := Temp[i];
      o[i].x:=o[i].x+a;
      o[i].y:=o[i].y+b;
    end;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(a,b,fill,boundary);
   end;
end;

procedure TForm1.btnSkewHClick(Sender: TObject);
begin
  if (formStatus = 'segitiga') then
    begin
        o[2].x-=spinSkew.Value;
        o[3].x-=spinSkew.Value;
    end
  else if (formStatus = 'segilima') then
  begin
        o[4].x-=spinSkew.Value;
        o[1].x-=spinSkew.Value;
        o[5].x-=spinSkew.Value;
  end
  else if (formStatus = 'kotak') then
  begin
    o[3].x-=spinSkew.Value;
    o[4].x-=spinSkew.Value;
  end
  else if (formStatus = 'lingkaran') then
  begin
    xDown-=spinSkew.Value;
  end;
  FormShow(Sender);
end;

procedure TForm1.btnSkewVClick(Sender: TObject);
begin
  if (formStatus = 'segitiga') then
    begin
        o[2].y-=spinSkew.Value;
        o[1].y-=spinSkew.Value;
    end
  else if (formStatus = 'segilima') then
  begin
        o[4].y-=spinSkew.Value;
        o[3].y-=spinSkew.Value;
        o[2].y-=spinSkew.Value;
  end
  else if (formStatus = 'kotak') then
  begin
    o[3].y-=spinSkew.Value;
    o[2].y-=spinSkew.Value;
  end
  else if (formStatus = 'lingkaran') then
  begin
    yUp+=spinSkew.Value;
  end;
  FormShow(Sender);
end;

procedure TForm1.trackRotateChange(Sender: TObject);
var
  fill, boundary : integer;
begin
  if (btnLingkaran.Down) or (formStatus = 'Lingkaran') then
  begin
    a := (xDown+xUp) div 2;
    b := (yDown+yUp) div 2;

    for i:=1 to 2 do
    begin
      o[i].x := o[i].x - a;
      o[i].y := o[i].y - b;
      sdt := trackRotate.Position*PI/180;
      Temp[i].x := Round(o[i].x*cos(sdt) - o[i].y*sin(sdt));
      Temp[i].y := Round(o[i].x*sin(sdt) + o[i].y*cos(sdt));
      o[i] := Temp[i];
      o[i].x := o[i].x+a;
      o[i].y := o[i].y+b;
    end;
     xDown :=  o[1].x;    yDown :=  o[1].y;
     xUp :=  o[2].x;      yUp :=  o[2].y;
  end
  else
  begin
    TitikTengah(Sender);
    for i:=1 to c do
    begin
      o[i].x := o[i].x - a;
      o[i].y := o[i].y - b;
      sdt := trackRotate.Position*PI/180;
      Temp[i].x := Round(o[i].x*cos(sdt) - o[i].y*sin(sdt));
      Temp[i].y := Round(o[i].x*sin(sdt) + o[i].y*cos(sdt));
      o[i] := Temp[i];
      o[i].x := o[i].x+a;
      o[i].y := o[i].y+b;
    end;
  end;
  FormShow(Sender);
  if (btnFill.Down) then
   begin
     fill := ColorButton1.ButtonColor;
     boundary:=clblack;
     boundary_fill(a,b,fill,boundary);
   end;
end;

procedure TForm1.TitikTengah(Sender: TObject);
begin
  a:=0;b:=0;

  if (c <> 0) then
  begin
   for i:=1 to c do
  begin
    a := O[i].x + a;
    b := O[i].y + b;
  end;
  a := a div c;
  b := b div c;
  end;

end;


end.

