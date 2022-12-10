with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Hashed_Sets;
with Ada.Strings.Hash;

procedure Main is
    type Point is record
        I : Integer;
        J : Integer;
    end record;
    type Point_Array is array (0 .. 9) of Point;

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
       (Direction : Character; Rope : in out Point_Array)
    is
        I_Diff : Integer;
        J_Diff : Integer;
    begin
        -- update head
        if Direction = 'R' then
            Rope (0).I := Rope (0).I + 1;
        elsif Direction = 'L' then
            Rope (0).I := Rope (0).I - 1;
        elsif Direction = 'U' then
            Rope (0).J := Rope (0).J + 1;
        elsif Direction = 'D' then
            Rope (0).J := Rope (0).J - 1;
        end if;
        -- update rope
        for K in 1 .. 9 loop
            I_Diff := Rope (K - 1).I - Rope (K).I;
            J_Diff := Rope (K - 1).J - Rope (K).J;
            if (I_Diff = 0 and abs J_Diff = 2) or
               (abs I_Diff = 2 and J_Diff = 0)
            then
                Rope (K).I := Rope (K).I + I_Diff / 2;
                Rope (K).J := Rope (K).J + J_Diff / 2;
            end if;
            if abs I_Diff + abs J_Diff > 2 then
                Rope (K).I := Rope (K).I + I_Diff / abs I_Diff;
                Rope (K).J := Rope (K).J + J_Diff / abs J_Diff;
            end if;
        end loop;
    end Update_Position;

    File      : File_Type;
    Direction : Character;
    Steps     : Integer;
    Visited1  : Point_Set.Set;
    Visited2  : Point_Set.Set;
    Rope      : Point_Array := (others => (I => 0, J => 0));
begin
    Visited1.Include (Rope (1));
    Visited2.Include (Rope (9));
    Open (File => File, Mode => In_File, Name => "input.txt");
    while not End_Of_File (File) loop
        Parse_Line (File, Direction, Steps);
        for I in 1 .. Steps loop
            Update_Position (Direction, Rope);
            --  Print_Point(Rope(9));
            Visited1.Include (Rope (1));
            Visited2.Include (Rope (9));
        end loop;
    end loop;
    Put_Line ("part 1:" & Visited1.Length'Image);
    Put_Line ("part 2:" & Visited2.Length'Image);
    Close (File);
end Main;
