table 50108 InventoryApi
{
    Caption = 'Inventory Api';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; LLMSCode; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(2; BarCode; Text[13])
        {
            DataClassification = ToBeClassified;

        }
        field(3; LotNo; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; NewLotNo; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(5; EpxDate; Text[7])
        {
            DataClassification = ToBeClassified;

        }
        field(6; ScanQty; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(7; WareHouse; Text[2])
        {
            DataClassification = ToBeClassified;

        }
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