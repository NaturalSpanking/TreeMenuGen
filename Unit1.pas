unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Grids, Vcl.ValEdit, Vcl.Menus, ShellAPI, UITypes;

type

  TM_Unit = record // ????????? ???? ??????
    is_param: boolean;
    name: string[30];
    value: integer;
    v_min: integer;
    v_max: integer;
    delta: integer;
    d_min: integer;
    d_max: integer;
  end;

  PM_Unit = ^TM_Unit; // ????????? ?? ?????????

  TForm1 = class(TForm)
    TreeView1: TTreeView;
    Panel1: TPanel;
    Button1: TButton;
    ValueListEditor1: TValueListEditor;
    MainMenu1: TMainMenu;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Exit1: TMenuItem;
    ree1: TMenuItem;
    Addroot1: TMenuItem;
    Addchild1: TMenuItem;
    Remove1: TMenuItem;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Generate1: TMenuItem;
    Saveas1: TMenuItem;
    About1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Addroot2: TMenuItem;
    Addchild2: TMenuItem;
    Remove2: TMenuItem;
    Expandall1: TMenuItem;
    Collapseall1: TMenuItem;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Deletion(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Edited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure Button1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Addroot1Click(Sender: TObject);
    procedure Addchild1Click(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure Generate1Click(Sender: TObject);
    procedure ValueListEditor1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Saveas1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Expandall1Click(Sender: TObject);
    procedure Collapseall1Click(Sender: TObject);
  private
    has_global_changes: boolean;
    has_param_changes: boolean;
    curNode: TTreeNode;
    global_counter: integer;
    function GetParentCount(Node: TTreeNode): integer;
    function TM_CreateUnit: PM_Unit;
    procedure TM_AddChild;
    procedure TM_AddRoot;
    procedure TM_Remove;
    procedure TM_Save(FName: string);
    procedure TM_Load(FName: string);
    procedure TM_Apply;
    procedure TM_Generate(FName: string);
    procedure TM_GenTreeArray(var SL: TStringList);
    procedure TM_GenParamArray(var SL: TStringList);
    procedure TM_GenPrintFunc(var SL: TStringList);
    procedure TM_GenChangeFunc(var SL: TStringList);
    procedure TM_GenSpecFunc(var SL: TStringList);
    procedure TM_GenExecFunc(var SL: TStringList);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses About;

{$R *.dfm}

function TForm1.TM_CreateUnit: PM_Unit;
var
  tmp_unit: PM_Unit;
begin
  tmp_unit := new(PM_Unit);
  tmp_unit.is_param := true;
  tmp_unit.name := ShortString('Menu' + IntToStr(global_counter));
  tmp_unit.value := 0;
  tmp_unit.v_min := 0;
  tmp_unit.v_max := 100;
  tmp_unit.delta := 10;
  tmp_unit.d_min := 1;
  tmp_unit.d_max := 100;
  inc(global_counter);
  Result := tmp_unit;
end;

procedure TForm1.TM_AddChild;
var
  tmp_unit: PM_Unit;
  // tmp_node: TTreeNode;
begin
  if curNode <> nil then
  begin
    tmp_unit := TM_CreateUnit;
    TreeView1.Items.AddChildObject(curNode, string(tmp_unit.name), tmp_unit);
    tmp_unit := curNode.Data;
    tmp_unit.is_param := false;
    ValueListEditor1.Values['Is parameter'] :=
      BoolToStr(tmp_unit.is_param, true);
    curNode.Expand(false);
    has_global_changes := true;
  end;
end;

procedure TForm1.TM_AddRoot;
var
  tmp_unit: PM_Unit;
begin
  tmp_unit := TM_CreateUnit;
  TreeView1.Items.AddObject(nil, string(tmp_unit.name), tmp_unit);
  has_global_changes := true;
end;

procedure TForm1.TM_Apply;
var
  tmp_unit: PM_Unit;
begin
  if curNode = nil then
    Exit;

  if (curNode.getFirstChild <> nil) and
    (StrToBool(ValueListEditor1.Values['Is parameter'])) then
  begin
    MessageDlg('This node cannot be parameter because has children..',
      mtInformation, [mbOK], 0);
    ValueListEditor1.Values['Is parameter'] := 'False';
  end;
  tmp_unit := curNode.Data;
  tmp_unit.is_param := StrToBool(ValueListEditor1.Values['Is parameter']);
  tmp_unit.name := ShortString(ValueListEditor1.Values['Name']);
  curNode.Text := string(tmp_unit.name);
  tmp_unit.value := StrToInt(ValueListEditor1.Values['Init value']);
  tmp_unit.v_min := StrToInt(ValueListEditor1.Values['Min value']);
  tmp_unit.v_max := StrToInt(ValueListEditor1.Values['Max value']);
  tmp_unit.delta := StrToInt(ValueListEditor1.Values['Init delta']);
  tmp_unit.d_min := StrToInt(ValueListEditor1.Values['Min delta']);
  tmp_unit.d_max := StrToInt(ValueListEditor1.Values['Max delta']);
  has_global_changes := true;
  has_param_changes := false;
end;

function TForm1.GetParentCount(Node: TTreeNode): integer;
var
  X: integer;
begin
  X := 0;
  while Node.Parent <> nil do
  begin
    inc(X);
    Node := Node.Parent;
  end;
  Result := X;
end;

procedure TForm1.TM_Generate(FName: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  TM_GenTreeArray(SL);
  TM_GenParamArray(SL);
  TM_GenPrintFunc(SL);
  TM_GenChangeFunc(SL);
  TM_GenExecFunc(SL);
  TM_GenSpecFunc(SL);
  SL.SaveToFile(FName);
  SL.Free;
  ShellExecute(Application.Handle, 'open', PWideChar(FName), '', '', SW_SHOW);
end;

procedure TForm1.TM_GenChangeFunc(var SL: TStringList);
var
  tmp_unit: PM_Unit;
  i: integer;
begin
  SL.Add('void ChangeParam(int index){');
  SL.Add('  // change parameter function prototype');
  SL.Add('  switch(index){');
  for i := 0 to TreeView1.Items.Count - 1 do
  begin
    tmp_unit := TreeView1.Items[i].Data;
    if tmp_unit.is_param then
    begin
      SL.Add('    case ' + IntToStr(i) + ': // ' + string(tmp_unit.name));
      SL.Add('');
      SL.Add('    break; // end of ' + string(tmp_unit.name));
    end;
  end;
  SL.Add('    default:');
  SL.Add('    break;');
  SL.Add('  }');
  SL.Add('}');
  SL.Add('');
end;

procedure TForm1.TM_GenExecFunc(var SL: TStringList);
var
  tmp_unit: PM_Unit;
  i: integer;
begin
  SL.Add('void ExecuteCmd(int index){');
  SL.Add('  // ?ommand execution function prototype');
  SL.Add('  switch(index){');
  for i := 0 to TreeView1.Items.Count - 1 do
  begin
    tmp_unit := TreeView1.Items[i].Data;
    if (not tmp_unit.is_param) and (TreeView1.Items[i].getFirstChild = nil) then
    begin
      SL.Add('    case ' + IntToStr(i) + ': // ' + string(tmp_unit.name));
      SL.Add('');
      SL.Add('    break; // end of ' + string(tmp_unit.name));
    end;
  end;
  SL.Add('    default:');
  SL.Add('    break;');
  SL.Add('  }');
  SL.Add('}');
end;

procedure TForm1.TM_GenParamArray(var SL: TStringList);
var
  tmp_unit: PM_Unit;
  i, X: integer;
  S: string;
begin
  SL.Add('TM_Param params[TM_MENU_SIZE]={');
  S := '  ';
  X := 0;
  for i := 0 to TreeView1.Items.Count - 1 do
  begin
    tmp_unit := TreeView1.Items[i].Data;
    inc(X);
    if X > 5 then
    begin
      SL.Add(S);
      S := '  ';
      X := 1;
    end;
    S := S + '{' + IntToStr(tmp_unit.value) + ', ' + IntToStr(tmp_unit.delta);
    if i < TreeView1.Items.Count - 1 then
      S := S + '},'
    else
      S := S + '}';
  end;
  SL.Add(S);
  SL.Add('};');
  SL.Add('');
end;

procedure TForm1.TM_GenPrintFunc(var SL: TStringList);
begin
  SL.Add('void PrintMenu(int index,TM_DeepLevel DeepLevel){');
  SL.Add('  // printing function prototype');
  SL.Add('  switch(DeepLevel){');
  SL.Add('    case DL_NAME: // print name');
  SL.Add('');
  SL.Add('    break;');
  SL.Add('    case DL_DELTA: // print param with cursor on symbol which will be change');
  SL.Add('');
  SL.Add('    break;');
  SL.Add('    case DL_PARAM: // print param with cursor on symbol which changing');
  SL.Add('');
  SL.Add('    break;');
  SL.Add('  }');
  SL.Add('}');
  SL.Add('');
end;

procedure TForm1.TM_GenSpecFunc(var SL: TStringList);
var
  tmp_unit: PM_Unit;
  i: integer;
begin
  SL.Add('void SpecFunction(int index){');
  SL.Add('  // special function prototype');
  SL.Add('  switch(index){');
  for i := 0 to TreeView1.Items.Count - 1 do
  begin
    tmp_unit := TreeView1.Items[i].Data;
    if TreeView1.Items[i].getFirstChild = nil then
    begin
      SL.Add('    case ' + IntToStr(i) + ': // ' + string(tmp_unit.name));
      SL.Add('');
      SL.Add('    break; // end of ' + string(tmp_unit.name));
    end;
  end;
  SL.Add('    default:');
  SL.Add('    break;');
  SL.Add('  }');
  SL.Add('}');
  SL.Add('');
end;

procedure TForm1.TM_GenTreeArray(var SL: TStringList);
var
  S: string;
  i, j, parent_id, parent_count: integer;
  tmp_unit: PM_Unit;
begin
  SL.Add('#define TM_MENU_SIZE ' + IntToStr(TreeView1.Items.Count));
  SL.Add('const TM_Unit menu[TM_MENU_SIZE]={');
  for i := 0 to TreeView1.Items.Count - 1 do
  begin
    tmp_unit := TreeView1.Items[i].Data;
    if TreeView1.Items[i].Parent <> nil then
      parent_id := TreeView1.Items[i].Parent.AbsoluteIndex
    else
      parent_id := -1;
    parent_count := GetParentCount(TreeView1.Items[i]);
    S := '';
    for j := 1 to parent_count do
      S := S + '  ';
    S := S + '  {' + IntToStr(parent_id) + ', ' +
      LowerCase(BoolToStr(tmp_unit.is_param, true)) + ', "' +
      string(tmp_unit.name) + '", ' + IntToStr(tmp_unit.v_min) + ', ' +
      IntToStr(tmp_unit.v_max) + ', ' + IntToStr(tmp_unit.d_min) + ', ' +
      IntToStr(tmp_unit.d_max);
    if i < TreeView1.Items.Count - 1 then
      S := S + '},'
    else
      S := S + '}';
    SL.Add(S);
  end;
  SL.Add('};');
  SL.Add('');
end;

procedure TForm1.TM_Load(FName: string);
var
  i: integer;
  tmp_unit: PM_Unit;
  f: file of TM_Unit;
begin
  TreeView1.LoadFromFile(FName);
  AssignFile(f, FName + '_');
  Reset(f);
  for i := 0 to TreeView1.Items.Count - 1 do
  begin
    tmp_unit := new(PM_Unit);
    read(f, tmp_unit^);
    TreeView1.Items[i].Data := tmp_unit;
  end;
  CloseFile(f);
  global_counter := TreeView1.Items.Count;
end;

procedure TForm1.TM_Remove;
begin
  if curNode <> nil then
  begin
    TreeView1.Items.Delete(curNode);
    has_global_changes := true;
  end;
end;

procedure TForm1.TM_Save(FName: string);
var
  i: integer;
  tmp_unit: PM_Unit;
  u: TM_Unit;
  f: file of TM_Unit;
begin
  TreeView1.SaveToFile(FName);
  AssignFile(f, FName + '_');
  Rewrite(f);
  for i := 0 to TreeView1.Items.Count - 1 do
  begin
    tmp_unit := TreeView1.Items[i].Data;
    u := tmp_unit^;
    write(f, tmp_unit^);
  end;
  CloseFile(f);
  has_global_changes := false;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.Expandall1Click(Sender: TObject);
begin
  TreeView1.FullExpand;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TForm1.Addchild1Click(Sender: TObject);
begin
  TM_AddChild;
end;

procedure TForm1.Addroot1Click(Sender: TObject);
begin
  TM_AddRoot;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  TM_Apply;
end;

procedure TForm1.Collapseall1Click(Sender: TObject);
begin
  TreeView1.FullCollapse;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if has_global_changes then
    if MessageDlg('Want to save changes?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then
      if OpenDialog1.FileName <> '' then
        TM_Save(OpenDialog1.FileName)
      else if SaveDialog1.FileName <> '' then
        TM_Save(SaveDialog1.FileName)
      else if SaveDialog1.Execute then
        TM_Save(SaveDialog1.FileName)
      else
        Action := caNone;
end;

procedure TForm1.Generate1Click(Sender: TObject);
begin
  TM_Generate('out.txt');
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    TM_Load(OpenDialog1.FileName);
    Form1.Caption := Form1.Caption + ' - ' + OpenDialog1.FileName;
    // SaveDialog1.FileName:=OpenDialog1.FileName;
  end;
end;

procedure TForm1.Remove1Click(Sender: TObject);
begin
  TM_Remove;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  if OpenDialog1.FileName <> '' then
    TM_Save(OpenDialog1.FileName)
  else if SaveDialog1.Execute then
    if not FileExists(SaveDialog1.FileName) then
      TM_Save(SaveDialog1.FileName)
    else if MessageDlg('File is exist. Rewrite?', mtConfirmation, [mbYes, mbNo],
      0) = mrYes then
      TM_Save(SaveDialog1.FileName);
end;

procedure TForm1.Saveas1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    if not FileExists(SaveDialog1.FileName) then
      TM_Save(SaveDialog1.FileName)
    else if MessageDlg('File is exist. Rewrite?', mtConfirmation, [mbYes, mbNo],
      0) = mrYes then
      TM_Save(SaveDialog1.FileName);
end;

procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  tmp_unit: PM_Unit;
begin
  if (has_param_changes) and (curNode <> nil) then
    if MessageDlg('Want apply changes?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then
      TM_Apply
    else
      has_param_changes := false;

  curNode := Node;
  if Node <> nil then
  begin
    tmp_unit := Node.Data;
    ValueListEditor1.Values['Is parameter'] :=
      BoolToStr(tmp_unit.is_param, true);
    ValueListEditor1.Values['Name'] := string(tmp_unit.name);
    ValueListEditor1.Values['Init value'] := IntToStr(tmp_unit.value);
    ValueListEditor1.Values['Min value'] := IntToStr(tmp_unit.v_min);
    ValueListEditor1.Values['Max value'] := IntToStr(tmp_unit.v_max);
    ValueListEditor1.Values['Init delta'] := IntToStr(tmp_unit.delta);
    ValueListEditor1.Values['Min delta'] := IntToStr(tmp_unit.d_min);
    ValueListEditor1.Values['Max delta'] := IntToStr(tmp_unit.d_max);
  end;
end;

procedure TForm1.TreeView1Deletion(Sender: TObject; Node: TTreeNode);
var
  tmp_unit: PM_Unit;
begin
  tmp_unit := Node.Data;
  dispose(tmp_unit);
end;

procedure TForm1.TreeView1DragDrop(Sender, Source: TObject; X, Y: integer);
var
  AnItem: TTreeNode;
  AttachMode: TNodeAttachMode;
  HT: THitTests;
begin
  AttachMode := naInsert;
  if TreeView1.Selected = nil then
    Exit;
  HT := TreeView1.GetHitTestInfoAt(X, Y);
  AnItem := TreeView1.GetNodeAt(X, Y);
  if (HT - [htOnItem, htOnIcon, htNowhere, htOnIndent, htOnRight] <> HT) then
  begin
    if (htOnItem in HT) or (htOnIcon in HT) then
      AttachMode := naAddChild
    else if htNowhere in HT then
      AttachMode := naAdd
    else if (htOnIndent in HT) or (htOnRight in HT) then
      AttachMode := naInsert;
    TreeView1.Selected.MoveTo(AnItem, AttachMode);
    if AttachMode = naAddChild then
      PM_Unit(AnItem.Data).is_param := false;
    has_global_changes := true;
  end;
end;

procedure TForm1.TreeView1DragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  Accept := Sender = Source;
end;

procedure TForm1.TreeView1Edited(Sender: TObject; Node: TTreeNode;
  var S: string);
var
  tmp_unit: PM_Unit;
begin
  tmp_unit := Node.Data;
  tmp_unit.name := ShortString(S);
  ValueListEditor1.Values['Name'] := string(tmp_unit.name);
end;

procedure TForm1.ValueListEditor1KeyPress(Sender: TObject; var Key: Char);
begin
  if curNode <> nil then
    has_param_changes := true;
  if Key = #13 then
    TM_Apply;
end;

end.
