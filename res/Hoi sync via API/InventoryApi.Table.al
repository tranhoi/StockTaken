table 50111 LLMS
{
    Caption = 'Inventory Api';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer) { AutoIncrement = true; }
        field(2; LLMSCode; Text[30]) { }
        field(3; BarCode; Text[13]) { }
        field(4; LotNo; Text[50]) { }
        field(5; NewLotNo; Text[50]) { }
        field(6; ExpDate; Text[7]) { }
        field(7; ScanQty; Integer) { }
        field(8; WareHouse; Text[2]) { }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }
}