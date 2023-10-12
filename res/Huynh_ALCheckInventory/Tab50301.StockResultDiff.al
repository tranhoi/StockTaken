table 70012 TableStockResultDifff
{
    Caption = 'StockResultDiff';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; LLMSCode; Text[30])
        {
            Caption = 'LLMSCode';
        }
        field(2; SystemQty; Integer)
        {
            Caption = 'SystemQty';
        }
        field(3; ScanQty; Integer)
        {
            Caption = 'ScanQty';
        }
        field(4; Diff; Integer)
        {
            Caption = 'Diff';
        }
        field(5; UnShipmentCount; Integer)
        {
            Caption = 'UnShipmentCount';
        }
        field(6; DiscountQty; Integer)
        {
            Caption = 'DiscountQty';
        }
        field(7; UnShipmentDiscount; Integer)
        {
            Caption = 'UnShipmentDiscount';
        }
    }
    keys
    {
        key(PK; LLMSCode)
        {
            Clustered = true;
        }
    }
}
