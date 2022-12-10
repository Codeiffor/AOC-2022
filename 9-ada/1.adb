with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Hashed_Sets;
with Ada.Strings.Hash;

procedure Main is
    type Point is record
        I : Integer;
        J : Integer;
    end record;

    procedure Print_Point (P : Point) is
    begin
        Put_Line (Integer'Image (P.I) & Integer'Image (P.J));
    end Print_Point;

    function Hash (key : Point) return Ada.Containers.Hash_Type is
    begin
        return
           Ada.Strings.Hash (Integer'Image (key.I) & Integer'Image (key.J));
    end Hash;
    package Point_Set is new Ada.Containers.Hashed_Sets (Point, Hash, "=");
    use Point_Set;

    procedure Parse_Line
       (File : File_Type; Direction : out Character; Steps : out Integer)
    is
        Line : String := Get_Line (File => File);
    begin
        Direction := Line (Line'First .. 1) (1);
        Steps     := Integer'Value (Line (3 .. Line'Last));
    end Parse_Line;

    procedure Update_Position
       (Direction : Character; Head : in out Point; Tail : in out Point)
    is
        I_Diff : Integer;
        J_Diff : Integer;
    begin
        -- update head
        if Direction = 'R' then
            Head.I := Head.I + 1;
        elsif Direction = 'L' then
            Head.I := Head.I - 1;
        elsif Direction = 'U' then
            Head.J := Head.J + 1;
        elsif Direction = 'D' then
            Head.J := Head.J - 1;
        end if;
        -- update tail
        I_Diff := Head.I - Tail.I;
        J_Diff := Head.J - Tail.J;
        if (I_Diff = 0 and abs J_Diff = 2) or (abs I_Diff = 2 and J_Diff = 0)
        then
            Tail.I := Tail.I + I_Diff / 2;
            Tail.J := Tail.J + J_Diff / 2;
        end if;
        if abs I_Diff + abs J_Diff = 3 then
            Tail.I := Tail.I + I_Diff / abs I_Diff;
            Tail.J := Tail.J + J_Diff / abs J_Diff;
        end if;
    end Update_Position;

    File      : File_Type;
    Direction : Character;
    Steps     : Integer;
    Visited   : Point_Set.Set;
    Head      : Point := (I => 0, J => 0);
    Tail      : Point := (I => 0, J => 0);
begin
    Visited.Include (Tail);
    Open (File => File, Mode => In_File, Name => "input.txt");
    while not End_Of_File (File) loop
        Parse_Line (File, Direction, Steps);
        for i in 1 .. Steps loop
            Update_Position (Direction, Head, Tail);
            --  Print_Point(Tail);
            Visited.Include (Tail);
        end loop;
    end loop;
    Put (Visited.Length'Image);
    Close (File);
end Main;
