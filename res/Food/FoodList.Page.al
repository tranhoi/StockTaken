page 50103 FoodList
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = Food;

    layout
    {
        area(Content)
        {
            repeater(Food)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Price; rec.Price)
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    InvenApiImport: Codeunit FoodImport;
                begin
                    InvenApiImport.GetData();
                end;
            }
        }
    }
}