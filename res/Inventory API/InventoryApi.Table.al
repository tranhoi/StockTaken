table 50111 InventoryApi
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

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        Message('Data insert');
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        Message('Data delete');
    end;

    trigger OnRename()
    begin
        Message('Data rename');
    end;

}