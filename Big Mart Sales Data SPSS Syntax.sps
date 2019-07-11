* Encoding: UTF-8.
*Import data into SPSS.

GET DATA  /TYPE=TXT
  /FILE="H:\My Documents\Harriet\Portfolio\Test_u94Q5KV.txt" /*test dataset.
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  Item_Identifier A5
  Item_Weight F6.3
  Item_Fat_Content A7
  Item_Visibility F11.9
  Item_Type A21
  Item_MRP F8.4
  Outlet_Identifier A6
  Outlet_Establishment_Year F4.0
  Outlet_Size A6
  Outlet_Location_Type A6
  Outlet_Type A17.
CACHE.
EXECUTE.
DATASET NAME DataSet2 WINDOW=FRONT.


GET DATA  /TYPE=TXT
  /FILE="H:\My Documents\Harriet\Portfolio\Train_UWu5bXk.txt"/*train dataset.
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  Item_Identifier A5
  Item_Weight F6.3
  Item_Fat_Content A7
  Item_Visibility F11.9
  Item_Type A21
  Item_MRP F8.4
  Outlet_Identifier A6
  Outlet_Establishment_Year F4.0
  Outlet_Size A6
  Outlet_Location_Type A6
  Outlet_Type A17
  Item_Outlet_Sales F9.4.
CACHE.
EXECUTE.
DATASET NAME DataSet3 WINDOW=FRONT.

*Merge the two files so that both datasets are cleaned the same way.
DATASET ACTIVATE DataSet4.
ADD FILES /FILE=*
  /FILE='DataSet2'
/IN=Testset.
VARIABLE LABELS Testset
'Case source is Dataset2'.
EXECUTE.

*Explorative Analysis.

* Basic statistics of metric variables.
DESCRIPTIVES VARIABLES=Item_Weight Item_Visibility Item_MRP Outlet_Establishment_Year 
    Item_Outlet_Sales
  /STATISTICS=MEAN STDDEV MIN MAX.

*Histograms and boxplots of metric variables.
EXAMINE VARIABLES=Item_Weight Item_Visibility Item_MRP Outlet_Establishment_Year
  /PLOT BOXPLOT HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS NONE
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*Basic statistics, frequency tables and bar charts of categorical variables.
FREQUENCIES VARIABLES=Item_Fat_Content Item_Type Outlet_Identifier Outlet_Size Outlet_Location_Type 
    Outlet_Type
  /STATISTICS=STDDEV MINIMUM MAXIMUM MODE
  /BARCHART FREQ
  /ORDER=ANALYSIS.

*Dealing with missing variables.
RECODE Item_Weight (SYSMIS=12.85765).
EXECUTE.
RECODE Item_Visibility (0=0.0659527801).
EXECUTE.

*Compute categories.
RECODE Item_Fat_Content ('LF'='Low Fat') ('low fat'='Low Fat') ('reg'='Regular').
EXECUTE.

RECODE Item_Fat_Content ('Low Fat'='0') ('Regular'='1').
EXECUTE.

RECODE Item_Type ('Baking Goods'='Food') ('Breads'='Food') ('Breakfast'='Food') 
    ('Canned'='Food') ('Dairy'='Food') ('Frozen Foods'='Food') ('Fruits and Vegetables'='Food') 
    ('Hard Drinks'='Drinks') ('Health and Hygiene'='Non Consumable') ('Household'='Non Consumable') 
    ('Meat'='Food') ('Others'='Non Consumable') ('Seafood'='Food') ('Snack Foods'='Food') ('Soft '+
    'Drinks'='Drinks') ('Starchy Foods'='Food').
EXECUTE.

COMPUTE Years_of_Operation=2019-Outlet_Establishment_Year.
EXECUTE.

*Creating dummy variables for Item_type, Outlet_size, outlet_type and outlet_location_type.

*Dummies for Itemtype.
RECODE Item_Type ('Food'=1) (ELSE=0) INTO DummyItem_type1.
VARIABLE LABELS  DummyItem_type1 'DummyItem_type1'.
EXECUTE.

RECODE Item_Type ('Drinks'=1) (ELSE=0) INTO DummyItem_type2.
VARIABLE LABELS  DummyItem_type2 'DummyItem_type2'.
EXECUTE.

RECODE Item_Type ('Non Consumable'=1) (ELSE=0) INTO DummyItem_type3.
VARIABLE LABELS  DummyItem_type3 'DummyItem_type3'.
EXECUTE.

*Dummies for Outlet_size.
DATASET ACTIVATE DataSet1.
RECODE Outlet_Size ('Small'=1) (ELSE=0) INTO DummyOutlet_Size1.
VARIABLE LABELS  DummyOutlet_Size1 'DummyOutlet_Size1'.
EXECUTE.

RECODE Outlet_Size ('Medium'=1) (ELSE=0) INTO DummyOutlet_Size2.
VARIABLE LABELS  DummyOutlet_Size2 'DummyOutlet_Size2'.
EXECUTE.

RECODE Outlet_Size ('High'=1) (ELSE=0) INTO DummyOutlet_Size3.
VARIABLE LABELS  DummyOutlet_Size3 'DummyOutlet_Size3'.
EXECUTE.


*Dummies for Outlet Location type.
RECODE Outlet_Location_Type ('Tier 1'=1) (ELSE=0) INTO DummyLocation_Type1.
VARIABLE LABELS  DummyLocation_Type1 'DummyLocation_Type1'.
EXECUTE.

RECODE Outlet_Location_Type ('Tier 2'=1) (ELSE=0) INTO DummyLocation_Type2.
VARIABLE LABELS  DummyLocation_Type2 'DummyLocation_Type2'.
EXECUTE.

RECODE Outlet_Location_Type ('Tier 3'=1) (ELSE=0) INTO DummyLocation_Type3.
VARIABLE LABELS  DummyLocation_Type3 'DummyLocation_Type3'.
EXECUTE.

*Dummies for Outlet Type.
RECODE Outlet_Type ('Grocery Store'=1) (ELSE=0) INTO DummyOutlet_Type1.
VARIABLE LABELS  DummyOutlet_Type1 'DummyOutlet_Type1'.
EXECUTE.

RECODE Outlet_Type ('Supermarket Type1'=1) (ELSE=0) INTO DummyOutlet_Type2.
VARIABLE LABELS  DummyOutlet_Type2 'DummyOutlet_Type2'.
EXECUTE.

RECODE Outlet_Type ('Supermarket Type2'=1) (ELSE=0) INTO DummyOutlet_Type3.
VARIABLE LABELS  DummyOutlet_Type3 'DummyOutlet_Type3'.
EXECUTE.

RECODE Outlet_Type ('Supermarket Type3'=1) (ELSE=0) INTO DummyOutlet_Type4.
VARIABLE LABELS  DummyOutlet_Type4 'DummyOutlet_Type4'.
EXECUTE.

*Tackling skewness in variables Item_visibility, Item_Weight and Item_MRP.
COMPUTE Log_ItemVisibility=LN(Item_Visibility).
EXECUTE.

COMPUTE SQRT_ItemWeight=SQRT(Item_Weight).
EXECUTE.

COMPUTE SQRT_ItemMRP=SQRT(Item_MRP).
EXECUTE.

COMPUTE SQRT_OutletSales=SQRT(Item_Outlet_Sales).
EXECUTE.

*Split the file in Test and Train dataset.

SORT CASES  BY Dataset_identifier.

SPSSINC SPLIT DATASET SPLITVAR=Dataset_identifier
/OUTPUT DIRECTORY= "H:\My Documents\Harriet\Portfolio" DELETECONTENTS=NO FILENAME="Test_Set2"
/OPTIONS NAMES=VALUES.

DATASET COPY  Train_dataset2.
DATASET ACTIVATE  Train_dataset2.
FILTER OFF.
USE ALL.
SELECT IF (Dataset_identifier = 1).
EXECUTE.
DATASET ACTIVATE  DataSet1.

* Analyze binary relations to check a linear relation between IV and DV. Also to check the correlation and tolerance. 
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SQRT_OutletSales
  /METHOD=ENTER DummyItem_type1 DummyItem_type2 DummyItem_type3 DummyOutlet_Size1 DummyOutlet_Size2 
    DummyOutlet_Size3 DummyLocation_Type1 DummyLocation_Type2 DummyLocation_Type3 DummyOutlet_Type1 
    DummyOutlet_Type2 DummyOutlet_Type3 DummyOutlet_Type4 Item_Fat_Content SQRT_ItemMRP SQRT_ItemWeight 
    Log_ItemVisibility Years_of_Operation.

*exclude variables from the equation with a correlation of bigger than 0.75 and tolerance smaller than 0.3. 

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SQRT_OutletSales
  /METHOD=ENTER DummyItem_type1 DummyItem_type2 DummyItem_type3 DummyOutlet_Size1 DummyOutlet_Size2 
    DummyLocation_Type3 DummyOutlet_Type2 DummyOutlet_Type3 Item_Fat_Content SQRT_ItemMRP 
    SQRT_ItemWeight Log_ItemVisibility.

*Calculate Cook's distance and Mahalanobis values to check multivariate outliers.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SQRT_OutletSales
  /METHOD=ENTER DummyItem_type1 DummyItem_type2 DummyItem_type3 DummyOutlet_Size1 DummyOutlet_Size2 
    DummyLocation_Type3 DummyOutlet_Type2 DummyOutlet_Type3 Item_Fat_Content SQRT_ItemMRP 
    SQRT_ItemWeight Log_ItemVisibility
  /SAVE MAHAL COOK.

SORT CASES BY COO_1(A).

*No action required as cook distance is not greater than 1.

*Exclude variables from the equation that are not statistically significant.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SQRT_OutletSales
  /METHOD=ENTER DummyItem_type1 DummyOutlet_Size1 DummyOutlet_Size2 DummyLocation_Type3 
    DummyOutlet_Type2 DummyOutlet_Type3 SQRT_ItemMRP Log_ItemVisibility
  /SAVE MAHAL COOK.

*Final Model (only significant variables are included)
4.004+
1.483*DummyOutlet_size1
+ 1.734*DummyOutlet_size2
+8.236*DummyOutlet_size3
+3.254*DummyLocationtype1
+2.268*DummyLocationtype2
-23.41*DummyOutletype1
-4.269*DummyOutlettype3
+20.437*Dummyoutlettype4
+0.445*Item_fat_content
+3.769*(Sqrt_itemMRP)
-0.345*Years of operation
=(SQRT_outlet Sales).

COMPUTE SQRT_OutletSales=4.004+1.483*DummyOutlet_Size1+ 
    1.734*DummyOutlet_Size2+8.236*DummyOutlet_Size3+3.254*DummyLocation_Type1+2.268*
    DummyLocation_Type2-23.41*DummyOutlet_Type1-4.269*DummyOutlet_Type3+20.437*DummyOutlet_Type4+0.445*
    Item_Fat_Content+3.769*(SQRT_ItemMRP)-0.345*Years_of_Operation.
EXECUTE.

COMPUTE Item_Outlet_Sales=(SQRT_OutletSales) ** 2.
EXECUTE.