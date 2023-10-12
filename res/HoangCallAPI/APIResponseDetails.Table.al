table 60999 "API Response Detailss"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "PKCode"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "IsError"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Messages"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Time"; Text[24])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "ParentCode"; Code[50])
        {
            DataClassification = ToBeClassified;
            // Foreign key to API Call History table
        }
    }
    keys
    {
        key(PK; "PKCode")
        {
            Clustered = true;
        }
    }
}
