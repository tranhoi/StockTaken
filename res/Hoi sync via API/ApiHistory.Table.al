table 50120 ApiHistory
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Post time"; DateTime) { }
        field(3; JsonData; Text[2048]) { }
    }

    keys
    {
        key(key1; ID)
        {
            Clustered = true;
        }
    }
}