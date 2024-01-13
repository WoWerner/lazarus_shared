unit input;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls;

type

  { TfrmInput }

  TfrmInput = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    labCaption: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
    procedure SetDefaults(sCaption, Lab1, Text1, Lab2, Text2: string; Passwortmode: boolean);
  end; 

var
  frmInput: TfrmInput;

implementation

{$R *.lfm}
uses
  global;

procedure TfrmInput.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#13
    then
      begin
        btnOK.Click;  //enter
        key := #0;
      end;
end;


procedure TfrmInput.SetDefaults(sCaption, Lab1, Text1, Lab2, Text2: string; Passwortmode: boolean);

begin
  labCaption.Caption := sCaption;
  label1.caption     := Lab1;
  label2.caption     := Lab2;
  edit1.caption      := Text1;
  edit2.caption      := Text2;
  label2.visible     := (lab2 <> '');
  edit2.Visible      := (lab2 <> '');

  if Passwortmode
    then
      begin
        edit1.PasswordChar:= '*';
        edit2.PasswordChar:= '*';
      end
    else
      begin
        edit1.PasswordChar:= #0;
        edit2.PasswordChar:= #0;
      end;
end;

end.

