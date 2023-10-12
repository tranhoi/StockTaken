table 50200 StockTakeScanResult
{
    Caption = 'StockTakeScanResult';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Seq; Integer)
        {
            Caption = 'Seq';
            AutoIncrement = true;
        }
        field(2; StockTakeDate; Text[8])
        {
            Caption = 'StockTakeDate';
        }
        field(3; LLMSCode; Text[50])
        {
            Caption = 'LLMSCode';
        }
        field(4; Barcode; Text[50])
        {
            Caption = 'Barcode';
        }
        field(5; LotNo; Text[50])
        {
            Caption = 'LotNo';
        }
        field(6; NewLotNo; Text[50])
        {
            Caption = 'NewLotNo';
        }
        field(7; ExpDate; Text[7])
        {
            Caption = 'ExpDate';
        }
        field(8; ScanQty; Integer)
        {
            Caption = 'ScanQty';
        }
        field(9; Warehouse; Text[2])
        {
            Caption = 'Warehouse';
        }
        field(10; Message; Text[2000])
        {
            Caption = 'Message';
        }
        field(11; InsertDate; Datetime)
        {
            Caption = 'InsertDate';
        }
    }
    keys
    {
        key(PK; Seq)
        {
            Clustered = true;
        }
    }
}
