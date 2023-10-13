page 50121 ApiHistoryCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ApiHistory;
    Editable = false;

    layout
    {
        area(Content)
        {
            group("Api History")
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