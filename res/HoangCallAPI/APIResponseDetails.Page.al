page 70007 "API Response Detailss"
{
    PageType = List;
    SourceTable = "API Response Detailss";
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PKCode; Rec.PKCode)
                {
                    ApplicationArea = All;
                }
                field(IsError; Rec.IsError)
                {
                    ApplicationArea = All;
                }
                field(Messages; Rec.Messages)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field(ParentCode; Rec.ParentCode)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure SetParentCode(Code: Code[50])
    begin
        Rec.SetRange("ParentCode", Code);
    end;
}
