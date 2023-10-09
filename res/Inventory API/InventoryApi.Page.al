page 50108 InventoryApi
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = InventoryApi;

    layout
    {
        area(Content)
        {
            repeater(LLMS)
            {
                field(LLMSCode; rec.LLMSCode)
                {
                    ApplicationArea = All;

                }
                field(BarCode; rec.BarCode)
                {
                    ApplicationArea = All;

                }
                field(LotNo; rec.LotNo)
                {
                    ApplicationArea = All;

                }
                field(NewLotNo; rec.NewLotNo)
                {
                    ApplicationArea = All;

                }
                field(EpxDate; rec.EpxDate)
                {
                    ApplicationArea = All;

                }
                field(ScanQty; rec.ScanQty)
                {
                    ApplicationArea = All;

                }
                field(WareHouse; rec.WareHouse)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Data")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    JsonCode := '{"menu": {"id": "file","value": "File","popup": {"menuitem": [{"value": "New", "onclick": "CreateNewDoc()"},{"value": "Open", "onclick": "OpenDoc()"},{"value": "Close", "onclick": "CloseDoc()"}]}}}';
                    Message(JsonCode);
                end;
            }
        }
    }

    var
        myInt: Integer;
        JsonCode: Text[500];
}