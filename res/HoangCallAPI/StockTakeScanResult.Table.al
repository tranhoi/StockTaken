table 60099 "Stock Take Scan Resultt"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Seq"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "StockTakeDate"; Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "LLMSCode"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Barcode"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "LotNo"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "NewLotNo"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "ExpDate"; Text[7])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "ScanQty"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Warehouse"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Message"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "InsertDate"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Seq")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        LastSeqRec: Record "Stock Take Scan Resultt";
    begin
        if not LastSeqRec.FindLast() then
            Seq := 1
        else
            Seq := LastSeqRec.Seq + 1;
    end;
}
