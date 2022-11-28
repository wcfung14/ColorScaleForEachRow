Attribute VB_Name = "Module1"
Sub ColorScaleForEachRow()

    'Define Range
    Dim MyRange As Range
    Dim cs As ColorScale
    
    'Get A Cell Address From The User to Get Number Format From
    'https://www.thespreadsheetguru.com/blog/vba-to-select-range-with-inputbox
      On Error Resume Next
        Set MyRange = Application.InputBox( _
          Title:="Color scale for each row", _
          Prompt:="Select cell range to apply Conditional Formatting color gradient to each row (highest value=red, lowest value=blue)", _
          Type:=8)
      On Error GoTo 0
    
    'Test to ensure User Did not cancel
      If MyRange Is Nothing Then Exit Sub
      
    'Apply color gradient to each row
    'https://www.bluepecantraining.com/portfolio/excel-vba-apply-colour-scale-conditional-formatting-with-vba-macro/
    'https://stackoverflow.com/questions/61051765/how-to-do-conditional-formatting-of-colour-scale-in-vba-in-a-more-efficient-way
    For Each r In MyRange.Rows
        'Delete Existing Conditional Formatting from Range
        r.FormatConditions.Delete
        
        'Apply Conditional Formatting
        Set cs = r.FormatConditions.AddColorScale(ColorScaleType:=3)
        With cs
            'the first colour is blue
            With .ColorScaleCriteria(1)
                .FormatColor.Color = RGB(135, 206, 250)
                .Type = xlConditionValueLowestValue
            End With
            'the second colour is white
            With .ColorScaleCriteria(2)
                .FormatColor.Color = RGB(255, 255, 255)
                .Type = xlConditionValuePercentile
                .Value = 50
            End With
            'the third colour is red
            With .ColorScaleCriteria(3)
                .FormatColor.Color = RGB(240, 128, 128)
                .Type = xlConditionValueHighestValue
            End With
        End With
    Next r
    
End Sub



