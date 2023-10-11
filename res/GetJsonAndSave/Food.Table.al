table 50110 Food
{
    Caption = 'Foods';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer) { AutoIncrement = true; }
        field(2; Name; Text[100]) { }
        field(3; Price; Text[10]) { }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
}