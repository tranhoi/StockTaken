table 60009 "API Call Historyy"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Time"; Text[24])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Request"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Response"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
