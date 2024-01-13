unit Freelist;

interface

uses
  Classes,
  Graphics,
  Forms,
  Controls,
  Buttons,
  StdCtrls,
  Dialogs,
  sysUtils;

type

  { TfrmFreieListe }

  TfrmFreieListe = class(TForm)
    OKBtn: TBitBtn;
    rbCSV: TRadioButton;
    rbFix: TRadioButton;
    SrcList: TListBox;
    DstList: TListBox;
    SrcLabel: TLabel;
    DstLabel: TLabel;
    IncludeBtn: TSpeedButton;
    IncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function  GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFreieListe: TfrmFreieListe;

implementation

{$R *.lfm}

{******************************************************************************}

procedure TfrmFreieListe.IncludeBtnClick(Sender: TObject);

var Index: Integer;

begin
  Index := GetFirstSelection(SrcList);
  MoveSelected(SrcList, DstList.Items);
  SetItem(SrcList, Index);
end;

procedure TfrmFreieListe.FormShow(Sender: TObject);
begin
  SetButtons;
  SetItem(SrcList, 0);
end;

{******************************************************************************}

procedure TfrmFreieListe.ExcludeBtnClick(Sender: TObject);

var  Index: Integer;

begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  SetItem(DstList, Index);
end;

{******************************************************************************}

procedure TfrmFreieListe.IncAllBtnClick(Sender: TObject);

var  I: Integer;

begin
  for I := 0 to SrcList.Items.Count - 1 do
    DstList.Items.AddObject(SrcList.Items[I], SrcList.Items.Objects[I]);
  SrcList.Items.Clear;
  SetItem(DstList, 0);
end;

{******************************************************************************}

procedure TfrmFreieListe.ExcAllBtnClick(Sender: TObject);

var I: Integer;

begin
  for I := 0 to DstList.Items.Count - 1 do
    SrcList.Items.AddObject(DstList.Items[I], DstList.Items.Objects[I]);
  DstList.Items.Clear;
  SetItem(SrcList, 0);
end;

{******************************************************************************}

procedure TfrmFreieListe.MoveSelected(List: TCustomListBox; Items: TStrings);

var  I: Integer;

begin
  for I := List.Items.Count - 1 downto 0 do
    if List.Selected[I] then
      begin
        Items.AddObject(List.Items[I], List.Items.Objects[I]);
        List.Items.Delete(I);
      end;
end;

{******************************************************************************}

procedure TfrmFreieListe.SetButtons;

var SrcEmpty, DstEmpty: Boolean;

begin
  SrcEmpty           := SrcList.Items.Count = 0;
  DstEmpty           := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  IncAllBtn.Enabled  := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled   := not DstEmpty;
end;

{******************************************************************************}

function TfrmFreieListe.GetFirstSelection(List: TCustomListBox): Integer;

begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := -1;
end;

{******************************************************************************}

procedure TfrmFreieListe.SetItem(List: TListBox; Index: Integer);

var MaxIndex: Integer;

begin
  with List do
    begin
      SetFocus;
      MaxIndex := List.Items.Count - 1;
      if Index > MaxIndex then Index := MaxIndex;
      if Index <> -1 then Selected[Index] := True;
    end;
  SetButtons;
end;

{******************************************************************************}

procedure TfrmFreieListe.OKBtnClick(Sender: TObject);

begin
  modalresult := mrOK;
end;


end.
