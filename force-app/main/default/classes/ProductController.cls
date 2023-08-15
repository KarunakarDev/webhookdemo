public class ProductController {

    @AuraEnabled(cacheable=true)
    public static WrapperData getProducts(){
       WrapperData wd = new WrapperData();
        List<Pricebookentry> peList = [SELECT Id,Name,Product2.Id,Product2.Name,Product2.ProductCode,Product2.pre_order__c,
                                       Product2.Available_Inventory__c,
                                       Product2.Brand__c,UnitPrice 
										FROM Pricebookentry 
										WHERE PriceBook2.IsStandard=true 
										AND Product2.Id='01t2y000001VjxxAAC'];
        for(Pricebookentry p : peList){
            wd.productName = p.Product2.Name;
            wd.productCode = p.Product2.ProductCode;
            wd.avlInvent = p.Product2.Available_Inventory__c;
            wd.brand = p.Product2.Brand__c;
            wd.preOrder = p.Product2.pre_order__c;
            wd.price = p.UnitPrice;
        }
        return wd;
    }
    
    public class WrapperData {
        @AuraEnabled public String productName;
        @AuraEnabled public String productCode;
         @AuraEnabled public Double avlInvent;
         @AuraEnabled public String brand;
         @AuraEnabled public Boolean preOrder;
         @AuraEnabled public Double price;
        
    }
}