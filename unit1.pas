unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Image2: TImage;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
var namee:string;
procedure clear();
begin
  Form1.Image1.Canvas.Brush.Color:=clwhite;
  Form1.Image2.Canvas.Brush.Color:=clwhite;
  Form1.Image1.Canvas.Pen.Color:= clwhite;
  Form1.Image2.Canvas.Pen.Color:=clwhite;

  Form1.Image1.Canvas.Rectangle(Form1.Image1.ClientRect);
  Form1.Image2.Canvas.Rectangle(Form1.Image2.ClientRect);

  //Form1.Image1.Canvas.Brush.Color:=clblack;
  //Form1.Image2.Canvas.Brush.Color:=clblack;
  Form1.Image1.Canvas.Pen.Color:= clblack;
  Form1.Image2.Canvas.Pen.Color:=clblack;
end;

function rect():string;
var x1,y1,x2,y2,stranax,stranay:integer;
    str:string;
begin
  Randomize;
  stranax:= random(80)+50;
  stranay:= random(80)+50;

  x1:= random(Form1.Image1.Canvas.Width -stranax -1)+1;
  y1:= random(Form1.Image1.Canvas.Height -stranay -1)+1;
  x2:= x1 + stranax;
  y2:= y1 + stranay;

  Form1.Image1.Canvas.Rectangle(x1,y1,x2,y2);
  str:= 'R ' + IntToStr(x1) + ' ' + IntToStr(y1) + ' ' + IntToStr(x2) + ' ' + IntToStr(y2);
  Form1.Memo1.Lines.Add(str);
  Result:= str;
end;

function elipse():string;
var r,sx,sy:integer;
    str:string;
begin
  Randomize;
  r:= random(Form1.Image1.Height div 2 - 50) +10;
  sx:= r + random(Form1.Image1.Width - (2*r));
  sy:= r + random(Form1.Image1.Height - (2*r));
  Form1.Image1.Canvas.Ellipse(sx-r, sy-r, sx+r, sy+r);
  str:= 'E ' + IntToStr(sx) + ' ' + IntToStr(sy) + ' ' + IntToStr(r);
  Form1.Memo1.Lines.Add(str);
  Result:= str;
end;

function line():string;
var xmax, ymax, x1, y1, x2, y2, length:integer;
    str:string;
begin
  xmax:= Form1.Image1.Canvas.Width;
  ymax:= Form1.Image1.Canvas.Height;

  Randomize;
  length:= random(100) + 20;
  x1:= random(xmax -1 -length) +1;
  y1:= random(ymax -1 -length) +1;
  x2:= length + random(xmax -1 -length) +1;
  y2:= length + random(ymax -1 -length) +1;

  Form1.Image1.Canvas.Line(x1,y1,x2,y2);
  str:= 'L ' + IntToStr(x1) + ' ' + IntToStr(y1) + ' ' + IntToStr(x2) + ' ' + IntToStr(y2);
  Form1.Memo1.Lines.Add(str);
  Result:= str;
end;

procedure writeToFile(rand:integer; name:string);
var F:TextFile;
begin
  AssignFile(F, name);
  if not(FileExists(name)) then Rewrite(F);
  Append(F);

  case rand of
       1:writeln(F,rect());  //REKDangle
       2:writeln(F,line());  //line
       3:writeln(F,elipse());//ellipse
  end;
  CloseFile(F);
end;

procedure readFromFile(name:string);
var F:TextFile;
    x1,y1,x2,y2,sx,sy,r:integer;
    ch:char;
begin
  AssignFile(F, name);
  Reset(F);
  while not EOF(F) do
  begin
     read(F,ch);

     case ch of
          'L','l':  // lajno
          begin
               readln(F,x1,y1,x2,y2);
               Form1.Image2.Canvas.Line(x1,y1,x2,y2);
          end;
          'R','r':  // REKTangle
          begin
               readln(F,x1,y1,x2,y2);
               Form1.Image2.Canvas.Rectangle(x1,y1,x2,y2);
          end;
          'E','e': // ellipse
          begin
               readln(F,sx,sy,r);
               Form1.Image2.Canvas.Ellipse(sx-r,sy-r,sx+r,sy+r);
          end;

     end;

  end;
end;
                 { TForm1 }
procedure TForm1.Button3Click(Sender: TObject);
begin                  //CLEAR MEMO
  clear();
end;

procedure TForm1.Button4Click(Sender: TObject);
var F:TextFile;        //DELETE THE FILE
begin
  AssignFile(F,'/Users/ginie/Documents/lazarus/generatorText/' + namee);
  Erase (F);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin                  //SET FILE NAME
  namee:= Form1.Edit1.Text;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin                  //STARTUP
  namee:= Form1.Edit1.Text;
  clear();
end;

procedure TForm1.Button1Click(Sender: TObject);
var rand:integer;
begin                  // WRITE
   Randomize;
   rand:= random(3)+1;
   writeToFile(rand, namee);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin                  //READ
  readFromFile(namee);
end;

end.













