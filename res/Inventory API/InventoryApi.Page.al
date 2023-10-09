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
            group(GroupName)
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}