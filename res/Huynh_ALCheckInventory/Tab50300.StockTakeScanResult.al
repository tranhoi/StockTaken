table 50310 TableStockTakeScanResultt
{
    Caption = 'StockTakeScanResult';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Seq; Integer)
        {
            Caption = 'Seq';
        }
        field(2; StockTakeDate; Text[8])
        {
            Caption = 'StockTakeDate';
        }
        field(3; LLMSCode; Text[50])
        {
            Caption = 'LLMSCode';
        }
        field(4; BarCode; Text[50])
        {
            Caption = 'BarCode';
        }
        field(5; LotNo; Text[50])
        {
            Caption = 'LotNo';
        }
        field(6; NewLotNo; Text[50])
        {
            Caption = 'NewLotNo';
        }
        field(7; ExpDate; Text[12])
        {
            Caption = 'ExpDate';
        }
        field(8; ScanQty; Integer)
        {
            Caption = 'ScanQty';
        }
        field(9; WareHouse; Text[2])
        {
            Caption = 'WareHouse';
        }
        field(10; Message; Code[500])
        {
            Caption = 'Message';
        }
        field(11; InsertDate; DateTime)
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
