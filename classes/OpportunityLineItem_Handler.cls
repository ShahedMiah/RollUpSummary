public class OpportunityLineItem_Handler{
    public void updateQuantityUsed(List<OpportunityLineItem> ListOppLi){ 
        Map<Id, Product2> productToUpdate = new Map<Id, Product2>();

        for(OpportunityLineItem oli:ListOppLi){
            if(oli.Product2Id != null){
                /* Put the values in the Map if Map does not contains the value already */
                if(!productToUpdate.containsKey(oli.Product2Id)){
                    productToUpdate.put(oli.Product2Id, new Product2(Id = oli.Product2Id));
                }
            }
        }
        
        List<AggregateResult> aggResult = new List<AggregateResult>();
        
        aggResult = [Select Product2Id,  SUM(Quantity)usedQuntity From OpportunityLineItem Where Product2Id IN : productToUpdate.keySet() Group By Product2Id];
        
        for(AggregateResult ar : aggResult){
            Id productId = (ID)ar.get('Product2Id');
            if(productToUpdate.containsKey(productId)){
                Product2 p = productToUpdate.get(productId);
                double usedQuantityTotal = (double)ar.get('usedQuntity');
                p.Quantity_Used__c = usedQuantityTotal;
                productToUpdate.put(productId , p);
            }
        }
    
    /* Update the value in the Map. values() method returns the list of records */
    
    update productToUpdate.values();
 
    }
}
