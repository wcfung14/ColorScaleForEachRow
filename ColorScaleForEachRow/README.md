# Heatmap visualization for transcriptome data gene count matrix (or any other matrix) in Excel with VBA
Example: “dummy_data.xlsx”


### 1. Open the .xlsx file, which looks like this:
![image](https://user-images.githubusercontent.com/44503876/204193165-ac849235-fe1b-4225-862b-c91155035c4f.png)


### 2. Importing the VBA script (“ColorScaleForEachRow.bas”): 
  - click “Visual Basic” under the tab “Develop
![image](https://user-images.githubusercontent.com/44503876/204193259-4d09b6de-9e14-4d78-bb6e-8259cdec3bc2.png)

  - click “Import File” under “File” in the prompted VBA window
  - In the “Import File” prompt, choose “ColorScaleForEachRow.bas” 
  - close VBA window
  
![image](https://user-images.githubusercontent.com/44503876/204193442-93ef52e9-4a04-4fd4-a45f-707914d3ceff.png)


### 3. Running the script
  - click “Macros” under the tab “Developer”
![image](https://user-images.githubusercontent.com/44503876/204193473-5031ae6d-030a-4c20-903a-fb43c4ec1020.png)


### 4.	Run Macro “ColorScaleForEachRow”
![image](https://user-images.githubusercontent.com/44503876/204193532-f08e4fc6-ba94-47de-b75f-fc976872a05f.png)


### 5.	A prompt will pop up
  - Select the cell range that you want to format, by mouse or typing the cell range (the cell range is “F2:K5” in this example)

![image](https://user-images.githubusercontent.com/44503876/204193576-5b23b7da-e149-45ac-aa76-ea8fc876fc9b.png)


### 6. BOOM!
  - (also validated the formatting by checking if the color rules are applied for each row, not the whole cell range)

![image](https://user-images.githubusercontent.com/44503876/204193607-96c9e6eb-d308-497e-a245-a061c8407ea3.png)
