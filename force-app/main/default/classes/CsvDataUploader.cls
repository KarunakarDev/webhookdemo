public class CsvDataUploader {
	@AuraEnabled
    public static void saveFile(String base64Data , Id parentId) {
        System.debug('CsvDataUploader saveFile parentId --> '+parentId);
        system.debug('CsvDataUploader saveFile base64Data'+ base64Data);
        String data = JSON.deserializeUntyped(base64Data).toString();
        system.debug('CsvDataUploader saveFile data'+ data);
        list<QuoteLineItem > quoteLineList = new list<QuoteLineItem >();
        list<String> lstCSVLines = data.split('\n');
        List<Product2> prodList = [SELECT ID,Model__c FROM Product2 WHERE Model__c != ''];
        Map<String,String> mapModelToProductId = new Map<String,String>();
        for(Product2 prod : prodList){
            mapModelToProductId.put(prod.Model__c, prod.id);
        }
		//PriceBookEntry pbe = [SELECT id FROM PricebookEntry 
				//WHERE Product2Id =: prod.id LIMIT 1];
        for(Integer i = 1; i < lstCSVLines.size(); i++){
            QuoteLineItem  quoteLine = new QuoteLineItem ();
            String csvLine = lstCSVLines[i];
            String prevLine = csvLine;
            Integer startIndex;
            Integer endIndex;
            while(csvLine.indexOf('"') > -1){
                if(startIndex == null){
                    startIndex = csvLine.indexOf('"');
                    csvLine = csvLine.substring(0, startIndex) + ':quotes:' + csvLine.substring(startIndex+1, csvLine.length());
                }else{
                    if(endIndex == null){
                        endIndex = csvLine.indexOf('"');
                        csvLine = csvLine.substring(0, endIndex) + ':quotes:' + csvLine.substring(endIndex+1, csvLine.length());
                    }
                }
                if(startIndex != null && endIndex != null){
                    String sub = csvLine.substring(startIndex, endIndex);
                    sub = sub.replaceAll(',', ':comma:');
                    csvLine = csvLine.substring(0, startIndex) + sub + csvLine.substring(endIndex, csvLine.length());
                    startIndex = null;
                    endIndex = null;
                }
            }
            List<String> csvRowData = new List<String>();
            for(String column : csvLine.split(',')){
                column = column.replaceAll(':quotes:', '').replaceAll(':comma:', ',');
                csvRowData.add(column);
            }
			quoteLine.QuoteId  				= parentId;
            quoteLine.Product2Id 			= mapModelToProductId.containsKey(csvRowData[1]) ? mapModelToProductId.get(csvRowData[0]) : null;
            quoteLine.Description           = String.valueOf(csvRowData[2].replace('\r',''));
            quoteLine.Pricing_EOM__c        = String.valueOf(csvRowData[3].replace('\r',''));
            quoteLine.Quantity  			= Decimal.valueOf(csvRowData[4].replace('\r',''));
            quoteLine.UnitPrice   			= Decimal.valueOf(csvRowData[5].replace('\r',''));
            //quoteLine.Shipping_UOM__c       = Integer.valueOf(csvRowData[4].replace('\r',''));
            
            //quoteLine.PriceBookentryid   	= pbe.Id;
            System.debug('Quote Line Item --> '+quoteLine);
            quoteLineList.add(quoteLine);
        }
        system.debug('CsvDataUploader saveFile quoteLineList'+ quoteLineList);
        insert quoteLineList;
    }

}