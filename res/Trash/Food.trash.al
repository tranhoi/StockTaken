table 50123 Food
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer) { AutoIncrement = true; }
        field(2; Name; Text[50]) { }
        field(3; Price; Text[9]) { }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
}