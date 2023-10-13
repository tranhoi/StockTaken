page 50120 ApiHistory
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ApiHistory;
    CardPageId = ApiHistoryCard;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Api History")
            {
                field("Post time"; Rec."Post time")
                {
                    ApplicationArea = All;

                }
                field(JsonData; Rec.JsonData)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}