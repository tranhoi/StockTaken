table 50124 InventoryApi
{
    Caption = 'Inventory Api';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; LLMSCode; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; BarCode; Text[13]) { }
        field(3; LotNo; Text[50]) { }
        field(4; NewLotNo; Text[50]) { }
        field(5; EpxDate; Text[7]) { }
        field(6; ScanQty; Integer) { }
        field(7; WareHouse; Text[2]) { }
    }

    keys
    {
        key(Key1; LLMSCode)
        {
            Clustered = true;
        }
    }
}